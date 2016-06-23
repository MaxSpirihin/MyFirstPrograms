                                      {ХАНОЙСКИЕ БАШНИ}
{
План разработки:
  1.Функция создания массивов(башен)
  2.Функция вывода их на экран в виде башен
  3.Функция перекладывания адного диска на другой
  4.Основная рекурсивная функция
}

uses crt,graphABC;//первое для задержки, граф для рисовалки

const
  MAX=20;//максимальное число башен
  TIME=300;//время перестановки
  
type
  Ttower=array[0..MAX] of integer;//башня
  Ttowers=array[1..3] of Ttower;//3 башни
  
procedure Input(var a:Ttowers;var n:integer);//Функция создания массивов(башен)
var
  i,k:integer;//счетчики
  strin:string;
begin
  setWindowWidth(400);//настраиваем окно
  SetWindowHeight(200);
  for i:=1 to MAX do//инициализируем башни как пустые
  begin
    a[1][i]:=0;
    a[2][i]:=0;
    a[3][i]:=0;
  end;
  SetFontSize(40);//пишем надписи
  setbrushcolor(cllightblue);
  fillrect(0,0,400,200);
  setfontcolor(clbrown);
  SetFontSize(40);
  TextOut(16,20,'Hanoys Towers');
  setfontcolor(clblack);
  SetFontSize(15);
  str(MAX,strin);
  strin:='Enter amount of disks(<'+strin+'):';
  TextOut(70,140,strin);
  setfontcolor(clblue);
  SetFontSize(10);
  TextOut(280,183,'By Spirikhin Maxim');
  n:=MAX;
  while (n>MAX-1) or (n<1) do//считываем кол-во дисков
    readln(n);
  k:=1;
  for i:=n downto 1 do//заполняем первую башню
  begin
    a[1][k]:=i;
    inc(k);
  end;
end;



procedure Output(a:Ttowers;n:integer);//отрисовка
var
  i:integer;
  h,dif,len:integer;//высота 1 диска, разница радиусов, радиус каждого
begin
  LockDrawing;//без рывков
  setbrushcolor(cllightblue);
  fillrect(0,0,400,200);
  setbrushcolor(clblack);
  fillrect(0,180,400,200);
  TextOut(280,183,'By Spirikhin Maxim');
  fillrect(97,50,103,180);//рисуем башни
  fillrect(197,50,203,180);
  fillrect(297,50,303,180);
  //вычисляем параметры 
  h:=100 div n;
  dif:=40 div n;
  //отрисовываем диски
  setbrushcolor(clred);
  setpencolor(clblack);
  for i:=1 to n do//башня а
  if a[1][i]<>0 then
    begin
      len:=a[1][i]*dif;
      line(100-len,180-h*i,100+len,180-h*i);
      line(100-len,179-h*(i-1),100+len,179-h*(i-1));
      line(100-len,180-h*i,100-len,180-h*(i-1));
      line(99+len,180-h*i,99+len,180-h*(i-1));
      fillrect(101-len,181-h*i,99+len,179-h*(i-1));
    end;
  for i:=1 to n do//башня b
  if a[2][i]<>0 then
    begin
      len:=a[2][i]*dif;
      line(200-len,180-h*i,200+len,180-h*i);
      line(200-len,179-h*(i-1),200+len,179-h*(i-1));
      line(200-len,180-h*i,200-len,180-h*(i-1));
      line(199+len,180-h*i,199+len,180-h*(i-1));
      fillrect(201-len,181-h*i,199+len,179-h*(i-1));
    end;
  for i:=1 to n do//башня c
  if a[3][i]<>0 then
    begin
      len:=a[3][i]*dif;
      line(300-len,180-h*i,300+len,180-h*i);
      line(300-len,179-h*(i-1),300+len,179-h*(i-1));
      line(300-len,180-h*i,300-len,180-h*(i-1));
      line(299+len,180-h*i,299+len,180-h*(i-1));
      fillrect(301-len,181-h*i,299+len,179-h*(i-1));
    end;
    Redraw;
end;


procedure Shift(var a:Ttowers;t_from,t_to:integer);//переложение верхнего диска с башни t_from на t_to
var
  i:integer;
  num_to,num_from:integer;//номера крайних дисков
begin
  i:=1;
  while (a[t_from][i]<>0)and(i<>MAX) do
    inc(i);
  num_from:=i-1;//ищем позицию перекладываемого диска
  i:=1;
  while (a[t_to][i]<>0)and(i<>MAX) do
    inc(i);
  num_to:=i;//ищем куда его пичкануть
  a[t_to][num_to]:=a[t_from][num_from];//перекладываем
  a[t_from][num_from]:=0;
end;


procedure Hanoys_Towers(var a:Ttowers; t_from,t_to,m,n:integer);//переложение кучи дисков кол-м m с башни t_from на t_to (ОСНОВНАЯ ПРОЦЕДУРА).
var
  i:integer;
  t_ext:integer;//номер доп башни
begin
  if (m>0) then//выход из рекурсии
  begin
    for i:=1 to 3 do//находим 3ю башню. Для компа это не очевидно
      if (i<>t_from) and (i<>t_to) then
        t_ext:=i;
    Hanoys_Towers(a,t_from,t_ext,m-1,n);//перекладываем кучу без 1 на доп башню
    Shift(a,t_from,t_to);//перекладываем нижний
    delay(TIME);
    Output(a,n);//отрисовываем
    Hanoys_Towers(a,t_ext,t_to,m-1,n);//перекладываем кучу с доп куда надо
  end;
end;


var
  a:Ttowers;//башни
  n:integer;//диски
begin
  SetWindowIsFixedSize(true);//окно нельзя изменять
  setWindowTitle('Hanoys Towers');//окно называется Hanoys Towers
  Input(a,n);//ввод
  Output(a,n);//отрисовка
  Hanoys_Towers(a,1,2,n,n);//игра
  Output(a,n);//итог
end.
//время написания кода-2.5 часа