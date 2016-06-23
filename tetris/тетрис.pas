                              {TETRIS}
 
{Реализация известной игры "Тетрис" на паскале. С использованием graphABC. C использованием логических матриц.}
 
uses crt,graphABC;//crt для задержки

const
  N=10;//длина поля
  M=20;//высота поля
  
type 
  cup=array[-1..N+2,-2..M+2] of boolean;//стакан для основных полей
  Tfigure=array[0..5,0..5] of boolean;//фигура
  
  
{Переменные глобальные т.к. все процедуры работают с одними и теми же переменными}  
var
  field,main_field:cup;//основное и промежуточное поле
  figure,next_figure:Tfigure;//фигура и следующая фигура
  x,y,score,time,detector:integer;//координаты фигуры,очки,скорость игры, датчик изменения скорости игры
  PlayerMusic := new System.Media.soundPlayer('data/music.wav');//музыка в игре
  Playerendloser := new System.Media.soundPlayer('data/END-LOSER.wav');//музыка при плохом результате
  PlayerendNormal := new System.Media.soundPlayer('data/END-NORMAL.wav');//музыка при нормальном результате
  PlayerendCool := new System.Media.soundPlayer('data/END-COOL.wav');//музыка при отличном результате
  
  
  
                                            {ЧАСТЬ 1. ОБРАБОТКА ВЫВОДА}  
  
  
{ПОСТРОЕНИЕ ОКНА ДЛЯ ИГРЫ}
procedure Build_window;
begin
  SetWindowWidth(310);
  setbrushcolor(clgray);
  SetWindowHeight(390);
  fillrect(5,5,205,385);
  setbrushcolor(clblack);
  fillrect(0,0,5,390);//строим рамку
  fillrect(0,0,210,5);
  fillrect(205,0,210,390);
  fillrect(0,385,210,390);
  setbrushcolor(cllightgray);
  fillrect(210,0,310,390);
  SetFontSize(15);
  TextOut(210,20,'Next figure');//пишем надписи
  textOut(225,165,'SCORE:');
  setbrushcolor(clblack);
  fillrect(215,55,220,145);//строим рамку для next figure
  fillrect(215,55,305,60);
  fillrect(220,140,305,145);
  fillrect(300,60,305,140);
  //строим для очков
  drawrectangle(229,199,291,224);
  setbrushcolor(clgray);
  fillrect(230,200,290,223);  
end;
{...}  
  



{ВЫВОД ПОЛЯ НА ЭКРАН}
procedure print_field(field:cup);//выводит текущее состояние поля на экран
var  
  i,j:integer;
begin
  LockDrawing;//блок рисования(во избежание мерцания)
  for i:=2 to M do
    for j:=1 to N do
      if not field[j,i] then//если эта ячейка поля пуста очищаем кусок экрана
      begin
        setbrushcolor(clgray);
        fillrect(20*(j-1)+5,20*(i-1)-15,20*j+5,20*i-15);
      end
      else//если не пуста рисуем кубик
      begin  
        setbrushcolor(clred);
        drawrectangle(20*(j-1)+5,20*(i-1)-15,20*j+5,20*i-15);
        fillrect(20*(j-1)+6,20*(i-1)-14,20*j+4,20*i-16);
      end;
  redraw;//во избежание мерцания
end;
{...}






                                      {ЧАСТЬ 2. ДЕЙСТВИЯ С ПОЛЯМИ И ФИГУРАМИ}

  
{ОЧИСТКА}
procedure Create_empty_field(var field:cup);//создание пустого поля. Каждая клетка стает пустой.
var
  i,j:integer;
begin
  for i:=1 to N do
    for j:=1 to M do
      field[i,j]:=false;
end;
{...}



{СДВИГИ}
procedure down_shift(var space:boolean);//спуск. Если можно то сдвигает фигуру вниз, иначе возвращает значние space false
var
  i,j:integer;
begin
  y:=y+1;
  for i:=1 to 4 do//проверяем на возможность
    for j:=1 to 4 do
      if figure[i,j] then//если в фигуре есть это место
        if (i=4) or (not figure[i+1,j]) then //если это низ фигуры
          if (y+i-2=M) or (main_field[x+j-1,y+i-1]) then  //если падать некуда
            space:=false;
  if space then
  begin
    for i:=1 to N do//удаляем старую фигуру
      for j:=1 to M do
        if not main_field[i,j] then
          field[i,j]:=false;
    for i:=1 to 4 do
      for j:=1 to 4 do
        if figure[i,j] then//если в фигуре есть это место
          field[x+j-1,y+i-1]:=figure[i,j];
  end
  else
    y:=y-1;//спускать не будем
end;
            
 
procedure Right_shift(var is_possible:boolean);//сдвиг вправо
var
  i,j:integer;
begin
  is_possible:=true;//возможность сжвига
  x:=x+1;
  for i:=1 to 4 do//проверяем на возможность
    for j:=1 to 4 do
      if figure[i,j] then//если в фигуре есть это место
        if (j=4) or (not figure[i,j+1]) then //если это правый край
          if (x+j-2=N) or (main_field[x+j-1,y+i-1]) then  //если падать некуда
            is_possible:=false;
  if is_possible then
  begin
    for i:=1 to N do//удаляем старую фигуру
      for j:=1 to M do
        if not main_field[i,j] then
          field[i,j]:=false;
    for i:=1 to 4 do
      for j:=1 to 4 do
        if figure[i,j] then//если в фигуре есть это место
          field[x+j-1,y+i-1]:=figure[i,j];
  end
  else//возвращаем изменения
    x:=x-1;
end;


procedure Left_shift(var is_possible:boolean);//сдвиг влево
var
  i,j:integer;
begin
  is_possible:=true;//возможность сдвига
  x:=x-1;
  for i:=1 to 4 do//проверяем на возможность
    for j:=1 to 4 do
      if figure[i,j] then//если в фигуре есть это место
        if (j=1) or (not figure[i,j-1]) then //если это левый край
          if (x+j-1=0) or (main_field[x+j-1,y+i-1]) then  //если падать некуда
            is_possible:=false;
  if is_possible then
  begin
    for i:=1 to N do//удаляем старую фигуру
      for j:=1 to M do
        if not main_field[i,j] then
          field[i,j]:=false;
    for i:=1 to 4 do
      for j:=1 to 4 do
        if figure[i,j] then//если в фигуре есть это место
          field[x+j-1,y+i-1]:=figure[i,j];
  end
  else//отменяем изменение координаты
    x:=x+1;
end;


procedure real_down;//мгновенное падение
var
  space:boolean;
begin
  space:=true;
  while space do//сдвигаем вниз пока можем
    down_shift(space);
end; 
{...} 
 



{ПОВОРОТ}
{Поворот выполняется по следующему алгоритму:}
{1.Сначала поворачиваем фигуру}
{2.Проверяем на помехи, если нужно сдвигаем, узнаем можно ли вообще поворачивать}
{3.Если поворачивать нельзя, отменяем все изменения}

function Left_space:boolean;//проверка наличия места слева
var
  i,j:integer;
  l_space:boolean;
begin
  l_space:=true;
  for i:=1 to 4 do
    for j:=1 to 2 do
      if figure[i,j] then
        if (field[x+j-1,y+i-1]) or ((x+j-1)<1) then
          l_space:=false;
  left_space:=l_space;
end;

function Right_space:boolean;//проверка наличия места справа
var
  i,j:integer;
  r_space:boolean;
begin
  r_space:=true;
  for i:=1 to 4 do
    for j:=3 to 4 do
      if figure[i,j] then
        if (field[x+j-1,y+i-1]) or ((x+j-1)>N) then
          r_space:=false;
  right_space:=r_space;
end;


function Down_space:boolean;//проверка наличия места снизу
var
  i,j:integer;
  d_space:boolean;
begin
  d_space:=true;
  for i:=3 to 4 do
    for j:=1 to 4 do
      if figure[i,j] then
        if (field[x+j-1,y+i-1]) or ((y+i-1)>M) then
          d_space:=false;
  down_space:=d_space;
end;


procedure Turn(var is_possible:boolean);//сам поворот
var
  i,j,extra_x,extra_y:integer;//доп переменные для отката изменений
  extra_figure:tfigure;
  extra_field:cup;
begin 
  extra_x:=x;
  extra_y:=y;
  extra_figure:=figure;//побочная фигура
  extra_field:=field;//доп поле на случай, если поворот невозможен
  
  for i:=1 to 4 do//поворачиваем
    for j:=1 to 4 do
      figure[i,j]:=extra_figure[j,5-i];    
 
  for i:=1 to N do//удаляем старую фигуру
        for j:=1 to M do
          if not main_field[i,j] then
            field[i,j]:=false;
  
  is_possible:=true;//условие возможности поворота
  if not down_space then //если снизу помехи, то не будем поворачивать
    is_possible:=false;
  
  if not left_space then//помехи слева
  begin
    x:=x+1;//смещаем вправо
    if not right_space then//помехи справа
      is_possible:=false//поворот невозможен
    else
      if not left_space then//остались помехи слева
      begin
        x:=x+1;//еще смещаем
        if not right_space then//если появились помехи справа
          is_possible:=false;//поворот невозможен
      end;
  end;
  
  if is_possible then//если поворот пока возможен, аналогично с правым боком
  begin
    if not right_space then
    begin
      x:=x-1;
      if not left_space then
        is_possible:=false
      else
        if not right_space then
        begin
          x:=x-1;
          if not left_space then
            is_possible:=false;
        end;
    end;
  end;

  if is_possible  then//если повернуть можно, пихаем фигуру в поле  
  begin
    for i:=1 to 4 do
      for j:=1 to 4 do
        if figure[i,j] then//если в фигуре есть это место
          field[x+j-1,y+i-1]:=figure[i,j];
  end
  else//возвращаем все как было
  begin
    figure:=extra_figure;
    field:=extra_field;
    x:=extra_x;
    y:=extra_y;
  end;
end;
{...}




{БЛОК СОЗДАНИЯ ФИГУР}
procedure clean_figure(var figure:tfigure);//очистка фигуры
var
  i,j:integer;
begin
  for i:=1 to 4 do
    for j:=1 to 5 do
      figure[i,j]:=false;
end;



procedure create_I(var figure:tfigure);//палка
begin
  figure[1,2]:=true;
  figure[2,2]:=true;
  figure[3,2]:=true;
  figure[4,2]:=true;
end;
  

procedure create_J(var figure:tfigure);
begin
  figure[1,3]:=true;
  figure[2,3]:=true;
  figure[3,3]:=true;
  figure[3,2]:=true;
end;
 

procedure create_L(var figure:tfigure);
begin
  figure[1,2]:=true;
  figure[2,2]:=true;
  figure[3,2]:=true;
  figure[3,3]:=true;
end;
   

procedure create_O(var figure:tfigure);//кубик
begin
  figure[2,2]:=true;
  figure[2,3]:=true;
  figure[3,2]:=true;
  figure[3,3]:=true;
end;
     
 

procedure create_S(var figure:tfigure);
begin
  figure[1,2]:=true;
  figure[2,2]:=true;
  figure[2,3]:=true;
  figure[3,3]:=true;
end;
   
 

procedure create_T(var figure:tfigure);
begin
  figure[1,2]:=true;
  figure[2,2]:=true;
  figure[3,2]:=true;
  figure[2,3]:=true;
end;
   
 

procedure create_Z(var figure:tfigure);
begin
  figure[1,3]:=true;
  figure[2,3]:=true;
  figure[2,2]:=true;
  figure[3,2]:=true;
end;
   
 

procedure create_figure;//создание новой фигуры и расчет следующей
var
  key:integer;
  i,j:integer;
begin
  figure:=next_figure;//предыдущая фигура теперь это
  key:=random(7)+1;//выбираем след фигуру
  clean_figure(next_figure);//создаем след фигуру
  case key of 
    1:create_I(next_figure);
    2:create_J(next_figure);
    3:create_L(next_figure);
    4:create_O(next_figure);
    5:create_S(next_figure);
    6:create_T(next_figure);
    7:create_Z(next_figure);
  end;
  for i:=1 to 4 do//выводим ее в спец окошко
    for j:=1 to 4 do
      if not next_figure[i,j] then
      begin
        setbrushcolor(clgray);
        fillrect(20*(j-1)+220,20*(i-1)+60,20*j+220,20*i+60);
      end
      else
      begin  
        setbrushcolor(clred);
        fillrect(20*(j-1)+220,20*(i-1)+60,20*j+220,20*i+60);
        drawrectangle(20*(j-1)+220,20*(i-1)+60,20*j+220,20*i+60);
      end;    
end;
{...}






                                      {ЧАСТЬ 3. ОСНОВНОЙ БЛОК ПРОЦЕДУР}
                                      
{НАЖАТИЕ КЛАВИШИ}

procedure keyx(key:integer);//выполняет определенные действия при нажатии клавиш
var
  space:boolean;//место для действия
begin
  case key of
    VK_Right:begin//сдвиг вправо
               Right_shift(space);
               delay(10);
               if space then
                 print_field(field);
             end;
    VK_Left:begin//сдвиг влево
              Left_shift(space);
              delay(10);
              if space then
                print_field(field);
            end;
    VK_Down:begin//сдвиг вниз
              space:=true;
              Down_shift(space);
              print_field(field);
            end;
    VK_SPACE:begin//падение
               Real_down;
               print_field(field); 
             end;
    VK_ENTER:begin//падение(на enter тоже можно)
              Real_down;
              print_field(field); 
            end;
    VK_UP:begin//поворот
            Turn(space);
            delay(55);
            if space then
              print_field(field);
          end;
  end;
end;
{...} 
 


{УСЛОВИЕ ПРОИГРЫША}
function game_over:boolean;//возвращает true, если последний верхний ряд не пуст т.е. вы проиграли
var
  i,j:integer;
  yes:boolean;
begin
  yes:=false;//пока все ок
  for i:=1 to 2 do
    for j:=1 to N do
      if main_field[j,i] then
        yes:=true;
  game_over:=yes;
end; 
{...} 
 
 
 


{ДВИЖЕНИЕ ФИГУРЫ}
procedure Move;//реализует движение фигуры в поле
var
  space:boolean;
begin
  delay(time);//задержка
  OnkeyDown:=keyx;//считываем нажатые клавиши
  delay(50);//мин-я задержка
  space:=true;//есть ли место куда падать дальше
  down_shift(space);//сдвиг вниз, если можно
  print_field(field);//вывод поля
  if space then//если было куда падать, продолжим движение
    Move
  else
    main_field:=field;//изменим основное поле
end;
{...}
 
 
 
{CРЕЗ ЛИНИЙ}
procedure Cut_lines(var main_field:cup);//реализует поиск заполненных линий в поле и удаляет их
var
  i,j,k:integer;
  yes:boolean;
  extra_field:cup;
begin
  extra_field:=main_field;//доп поле
  for j:=1 to M do//для каждой строки
  begin
    yes:=true;//проверяем на заполненность
    for i:=1 to N do
      if not main_field[i,j] then
        yes:=false;
    if yes then//если строка заполнена
    begin
      print_field(main_field);
      for k:=2 to j do//сдвигаем все, что до заполненной линии вниз
        for i:=1 to N do
          main_field[i,k]:=extra_field[i,k-1];
      score:=score+100;//увеличиваем очки
      detector:=detector+1;//увеличиваем датчик
      extra_field:=main_field;//меняем доп поле
    end;  
  end;
  print_field(main_field);
end;
{...}




{ПОДГОТОВКА К ИГРЕ}
procedure Preparing_to_game;//Осуществляет подготовительные действия к игре
var
  i:integer;
begin
  playerMusic.Load;//загружаем музыку
  playerMusic.PlayLooping;//включаем ее
  time:=250;//начальная скорость
  score:=0;//начальные очки
  detector:=0;//начало датчика
  create_empty_field(main_field);//обнуляем поля
  create_empty_field(field);
  build_window;//строим окно
  i:=random(7)+1;//надо заранее сделать первую фигуру
  clean_figure(next_figure);
  case i of 
    1:create_I(next_figure);
    2:create_J(next_figure);
    3:create_L(next_figure);
    4:create_O(next_figure);
    5:create_S(next_figure);
    6:create_T(next_figure);
    7:create_Z(next_figure);
  end;
end;
{...}




procedure end_game; forward;//опережающее описание процедуры следующей части


{ОСНОВНОЙ ПРОЦЕСС}
procedure The_game;
var
  strin:string;
begin
  if (detector>10) and (time>20) then//если пора, изменяем скорость игры
  begin
    detector:=detector mod 10;
    time:=time-25;
  end;
  create_figure;//создаем фигуру
  x:=4;//задаем ее координаты в поле
  y:=-1;
  Move;//запускаем ее движение
  Cut_lines(field);//срезаем заполненные линии
  main_field:=field;
  str(score,strin);//выводим на экран измененные очки
  setbrushcolor(clgray);
  textOut(230,200,strin);
  if not game_over then//если еще не проиграли, то перезапускаемся
    The_game
  else
    end_game;//конец игры
end; 
 
 
 
       
                          
                                      {ЧАСТЬ 4. МЕНЮ}
                                      

{КОНЕЦ ИГРЫ}                                      
procedure end_game;
var
  strin:string;
begin
  Window.Width:=210;//расширяем окно
  Window.Width:=400;
  setbrushcolor(clwhite);
  fillrect(210,0,400,390);
  textOut(250,100,'Your score');//выводим итоговый счет
  setfontsize(50);
  str(score,strin);
  case score of
    0:textOut(280,130,strin);
    100..900:textOut(240,130,strin);
    1000..9900: textOut(225,130,strin);
    10000..20000: textOut(200,130,strin);
  end;
  setfontsize(10);
  case score of//в зависимости от счета выводи коментарий и соответствующкю музыку
    0..400:begin
             textOut(220,200,'YOU ARE F***ING LOSER!!');
             Playerendloser.Load;
             Playerendloser.Play;
           end;
    500..3000:begin
                textOut(220,200,'NOT BAD, MAN! TRY AGAIN.');
                PlayerendNormal.Load;
                PlayerendNormal.Play;
              end;
    3100..5000:begin
                 textOut(220,200,'GREAT JOB. YOU ARE GOOD PLAYER');
                 PlayerendNormal.Load;
                 PlayerendNormal.Play;
               end;
    5100..7500:begin
                textOut(220,200,'PERFECT!!! YOU ARE GEEK.');
                PlayerendCool.Load;
                PlayerendCool.Play;
              end;
    7600..11000:begin
                 textOut(220,200,'YOU ARE GOD OF TETRIS');
                 textOut(220,220,'OR F***ING CHEATER');
                 PlayerendCool.Load;
                 PlayerendCool.Play;
               end;
  end;
end;
{...}


procedure start_menu; forward;//опережающее описание главного меню


{ИНФОРМАЦИЯ ОБ ИГРЕ}
procedure show_information;//выводит на экран содержимое файла about из папки data
var
  f:text;
  str:string;
  y:integer;
begin
  setwindowwidth(400);//расширяем окно
  clearwindow;//чистим его
  setbrushcolor(clwhite);
  assign(f,'data/about.txt');//привязка файла
  reset(f);
  y:=4;
  setfontsize(10);
  while not EoF(f) do//считываем и выводим построчно
  begin
    readln(f,str); 
    textout(3,y,str);
    y:=y+15;
  end;
  textout(130,360,'NRNU MEPHI, kaf 17');
  readln;
  start_menu;//возврат в меню
end;
{...}



{НАЧАЛЬНОЕ МЕНЮ}
procedure Start_menu;//позволяет начать игру и вывести инфу об игре
var
  key:string; 
begin
  SetWindowWidth(210);//создаем окошко
  setbrushcolor(cllightgray);
  SetWindowHeight(390);
  fillrect(5,5,205,385);
  setbrushcolor(clblack);
  fillrect(0,0,5,390);
  fillrect(0,0,210,5);
  fillrect(205,0,210,390);
  fillrect(0,385,210,390);
  setbrushcolor(cllightgray);
  setfontsize(40);
  setfontcolor(clred);
  textOut(8,90,'TETRIS');
  setfontcolor(clblack);
  setfontsize(10);
  textout(45,190,'Press Enter to play');
  setfontsize(8);
  textout(15,230,'Enter "1" show information about game');
  setfontsize(15);
  setfontcolor(clblue);
  textout(50,350,'Mephi 2013');
  setfontcolor(clblack);
  readln(key);
  if key='1' then//если по инструкции ввели 1 выводим инфу об игре
    show_information;
end;
{...}



                                      {ОСНОВНОЕ ТЕЛО}
                                      
begin
  SetWindowIsFixedSize(true);//окно нельзя изменять
  setWindowTitle('Tetris');//окно называется тетрис
  Start_menu;//запускаем начальное меню
  preparing_to_game;//готовимся к игре
  The_game;//запускаем игру
end.


