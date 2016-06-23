                              {TETRIS}
 
{���������� ��������� ���� "������" �� �������. � �������������� graphABC. C �������������� ���������� ������.}
 
uses crt,graphABC;//crt ��� ��������

const
  N=10;//����� ����
  M=20;//������ ����
  
type 
  cup=array[-1..N+2,-2..M+2] of boolean;//������ ��� �������� �����
  Tfigure=array[0..5,0..5] of boolean;//������
  
  
{���������� ���������� �.�. ��� ��������� �������� � ������ � ���� �� �����������}  
var
  field,main_field:cup;//�������� � ������������� ����
  figure,next_figure:Tfigure;//������ � ��������� ������
  x,y,score,time,detector:integer;//���������� ������,����,�������� ����, ������ ��������� �������� ����
  PlayerMusic := new System.Media.soundPlayer('data/music.wav');//������ � ����
  Playerendloser := new System.Media.soundPlayer('data/END-LOSER.wav');//������ ��� ������ ����������
  PlayerendNormal := new System.Media.soundPlayer('data/END-NORMAL.wav');//������ ��� ���������� ����������
  PlayerendCool := new System.Media.soundPlayer('data/END-COOL.wav');//������ ��� �������� ����������
  
  
  
                                            {����� 1. ��������� ������}  
  
  
{���������� ���� ��� ����}
procedure Build_window;
begin
  SetWindowWidth(310);
  setbrushcolor(clgray);
  SetWindowHeight(390);
  fillrect(5,5,205,385);
  setbrushcolor(clblack);
  fillrect(0,0,5,390);//������ �����
  fillrect(0,0,210,5);
  fillrect(205,0,210,390);
  fillrect(0,385,210,390);
  setbrushcolor(cllightgray);
  fillrect(210,0,310,390);
  SetFontSize(15);
  TextOut(210,20,'Next figure');//����� �������
  textOut(225,165,'SCORE:');
  setbrushcolor(clblack);
  fillrect(215,55,220,145);//������ ����� ��� next figure
  fillrect(215,55,305,60);
  fillrect(220,140,305,145);
  fillrect(300,60,305,140);
  //������ ��� �����
  drawrectangle(229,199,291,224);
  setbrushcolor(clgray);
  fillrect(230,200,290,223);  
end;
{...}  
  



{����� ���� �� �����}
procedure print_field(field:cup);//������� ������� ��������� ���� �� �����
var  
  i,j:integer;
begin
  LockDrawing;//���� ���������(�� ��������� ��������)
  for i:=2 to M do
    for j:=1 to N do
      if not field[j,i] then//���� ��� ������ ���� ����� ������� ����� ������
      begin
        setbrushcolor(clgray);
        fillrect(20*(j-1)+5,20*(i-1)-15,20*j+5,20*i-15);
      end
      else//���� �� ����� ������ �����
      begin  
        setbrushcolor(clred);
        drawrectangle(20*(j-1)+5,20*(i-1)-15,20*j+5,20*i-15);
        fillrect(20*(j-1)+6,20*(i-1)-14,20*j+4,20*i-16);
      end;
  redraw;//�� ��������� ��������
end;
{...}






                                      {����� 2. �������� � ������ � ��������}

  
{�������}
procedure Create_empty_field(var field:cup);//�������� ������� ����. ������ ������ ����� ������.
var
  i,j:integer;
begin
  for i:=1 to N do
    for j:=1 to M do
      field[i,j]:=false;
end;
{...}



{������}
procedure down_shift(var space:boolean);//�����. ���� ����� �� �������� ������ ����, ����� ���������� ������� space false
var
  i,j:integer;
begin
  y:=y+1;
  for i:=1 to 4 do//��������� �� �����������
    for j:=1 to 4 do
      if figure[i,j] then//���� � ������ ���� ��� �����
        if (i=4) or (not figure[i+1,j]) then //���� ��� ��� ������
          if (y+i-2=M) or (main_field[x+j-1,y+i-1]) then  //���� ������ ������
            space:=false;
  if space then
  begin
    for i:=1 to N do//������� ������ ������
      for j:=1 to M do
        if not main_field[i,j] then
          field[i,j]:=false;
    for i:=1 to 4 do
      for j:=1 to 4 do
        if figure[i,j] then//���� � ������ ���� ��� �����
          field[x+j-1,y+i-1]:=figure[i,j];
  end
  else
    y:=y-1;//�������� �� �����
end;
            
 
procedure Right_shift(var is_possible:boolean);//����� ������
var
  i,j:integer;
begin
  is_possible:=true;//����������� ������
  x:=x+1;
  for i:=1 to 4 do//��������� �� �����������
    for j:=1 to 4 do
      if figure[i,j] then//���� � ������ ���� ��� �����
        if (j=4) or (not figure[i,j+1]) then //���� ��� ������ ����
          if (x+j-2=N) or (main_field[x+j-1,y+i-1]) then  //���� ������ ������
            is_possible:=false;
  if is_possible then
  begin
    for i:=1 to N do//������� ������ ������
      for j:=1 to M do
        if not main_field[i,j] then
          field[i,j]:=false;
    for i:=1 to 4 do
      for j:=1 to 4 do
        if figure[i,j] then//���� � ������ ���� ��� �����
          field[x+j-1,y+i-1]:=figure[i,j];
  end
  else//���������� ���������
    x:=x-1;
end;


procedure Left_shift(var is_possible:boolean);//����� �����
var
  i,j:integer;
begin
  is_possible:=true;//����������� ������
  x:=x-1;
  for i:=1 to 4 do//��������� �� �����������
    for j:=1 to 4 do
      if figure[i,j] then//���� � ������ ���� ��� �����
        if (j=1) or (not figure[i,j-1]) then //���� ��� ����� ����
          if (x+j-1=0) or (main_field[x+j-1,y+i-1]) then  //���� ������ ������
            is_possible:=false;
  if is_possible then
  begin
    for i:=1 to N do//������� ������ ������
      for j:=1 to M do
        if not main_field[i,j] then
          field[i,j]:=false;
    for i:=1 to 4 do
      for j:=1 to 4 do
        if figure[i,j] then//���� � ������ ���� ��� �����
          field[x+j-1,y+i-1]:=figure[i,j];
  end
  else//�������� ��������� ����������
    x:=x+1;
end;


procedure real_down;//���������� �������
var
  space:boolean;
begin
  space:=true;
  while space do//�������� ���� ���� �����
    down_shift(space);
end; 
{...} 
 



{�������}
{������� ����������� �� ���������� ���������:}
{1.������� ������������ ������}
{2.��������� �� ������, ���� ����� ��������, ������ ����� �� ������ ������������}
{3.���� ������������ ������, �������� ��� ���������}

function Left_space:boolean;//�������� ������� ����� �����
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

function Right_space:boolean;//�������� ������� ����� ������
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


function Down_space:boolean;//�������� ������� ����� �����
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


procedure Turn(var is_possible:boolean);//��� �������
var
  i,j,extra_x,extra_y:integer;//��� ���������� ��� ������ ���������
  extra_figure:tfigure;
  extra_field:cup;
begin 
  extra_x:=x;
  extra_y:=y;
  extra_figure:=figure;//�������� ������
  extra_field:=field;//��� ���� �� ������, ���� ������� ����������
  
  for i:=1 to 4 do//������������
    for j:=1 to 4 do
      figure[i,j]:=extra_figure[j,5-i];    
 
  for i:=1 to N do//������� ������ ������
        for j:=1 to M do
          if not main_field[i,j] then
            field[i,j]:=false;
  
  is_possible:=true;//������� ����������� ��������
  if not down_space then //���� ����� ������, �� �� ����� ������������
    is_possible:=false;
  
  if not left_space then//������ �����
  begin
    x:=x+1;//������� ������
    if not right_space then//������ ������
      is_possible:=false//������� ����������
    else
      if not left_space then//�������� ������ �����
      begin
        x:=x+1;//��� �������
        if not right_space then//���� ��������� ������ ������
          is_possible:=false;//������� ����������
      end;
  end;
  
  if is_possible then//���� ������� ���� ��������, ���������� � ������ �����
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

  if is_possible  then//���� ��������� �����, ������ ������ � ����  
  begin
    for i:=1 to 4 do
      for j:=1 to 4 do
        if figure[i,j] then//���� � ������ ���� ��� �����
          field[x+j-1,y+i-1]:=figure[i,j];
  end
  else//���������� ��� ��� ����
  begin
    figure:=extra_figure;
    field:=extra_field;
    x:=extra_x;
    y:=extra_y;
  end;
end;
{...}




{���� �������� �����}
procedure clean_figure(var figure:tfigure);//������� ������
var
  i,j:integer;
begin
  for i:=1 to 4 do
    for j:=1 to 5 do
      figure[i,j]:=false;
end;



procedure create_I(var figure:tfigure);//�����
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
   

procedure create_O(var figure:tfigure);//�����
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
   
 

procedure create_figure;//�������� ����� ������ � ������ ���������
var
  key:integer;
  i,j:integer;
begin
  figure:=next_figure;//���������� ������ ������ ���
  key:=random(7)+1;//�������� ���� ������
  clean_figure(next_figure);//������� ���� ������
  case key of 
    1:create_I(next_figure);
    2:create_J(next_figure);
    3:create_L(next_figure);
    4:create_O(next_figure);
    5:create_S(next_figure);
    6:create_T(next_figure);
    7:create_Z(next_figure);
  end;
  for i:=1 to 4 do//������� �� � ���� ������
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






                                      {����� 3. �������� ���� ��������}
                                      
{������� �������}

procedure keyx(key:integer);//��������� ������������ �������� ��� ������� ������
var
  space:boolean;//����� ��� ��������
begin
  case key of
    VK_Right:begin//����� ������
               Right_shift(space);
               delay(10);
               if space then
                 print_field(field);
             end;
    VK_Left:begin//����� �����
              Left_shift(space);
              delay(10);
              if space then
                print_field(field);
            end;
    VK_Down:begin//����� ����
              space:=true;
              Down_shift(space);
              print_field(field);
            end;
    VK_SPACE:begin//�������
               Real_down;
               print_field(field); 
             end;
    VK_ENTER:begin//�������(�� enter ���� �����)
              Real_down;
              print_field(field); 
            end;
    VK_UP:begin//�������
            Turn(space);
            delay(55);
            if space then
              print_field(field);
          end;
  end;
end;
{...} 
 


{������� ���������}
function game_over:boolean;//���������� true, ���� ��������� ������� ��� �� ���� �.�. �� ���������
var
  i,j:integer;
  yes:boolean;
begin
  yes:=false;//���� ��� ��
  for i:=1 to 2 do
    for j:=1 to N do
      if main_field[j,i] then
        yes:=true;
  game_over:=yes;
end; 
{...} 
 
 
 


{�������� ������}
procedure Move;//��������� �������� ������ � ����
var
  space:boolean;
begin
  delay(time);//��������
  OnkeyDown:=keyx;//��������� ������� �������
  delay(50);//���-� ��������
  space:=true;//���� �� ����� ���� ������ ������
  down_shift(space);//����� ����, ���� �����
  print_field(field);//����� ����
  if space then//���� ���� ���� ������, ��������� ��������
    Move
  else
    main_field:=field;//������� �������� ����
end;
{...}
 
 
 
{C��� �����}
procedure Cut_lines(var main_field:cup);//��������� ����� ����������� ����� � ���� � ������� ��
var
  i,j,k:integer;
  yes:boolean;
  extra_field:cup;
begin
  extra_field:=main_field;//��� ����
  for j:=1 to M do//��� ������ ������
  begin
    yes:=true;//��������� �� �������������
    for i:=1 to N do
      if not main_field[i,j] then
        yes:=false;
    if yes then//���� ������ ���������
    begin
      print_field(main_field);
      for k:=2 to j do//�������� ���, ��� �� ����������� ����� ����
        for i:=1 to N do
          main_field[i,k]:=extra_field[i,k-1];
      score:=score+100;//����������� ����
      detector:=detector+1;//����������� ������
      extra_field:=main_field;//������ ��� ����
    end;  
  end;
  print_field(main_field);
end;
{...}




{���������� � ����}
procedure Preparing_to_game;//������������ ���������������� �������� � ����
var
  i:integer;
begin
  playerMusic.Load;//��������� ������
  playerMusic.PlayLooping;//�������� ��
  time:=250;//��������� ��������
  score:=0;//��������� ����
  detector:=0;//������ �������
  create_empty_field(main_field);//�������� ����
  create_empty_field(field);
  build_window;//������ ����
  i:=random(7)+1;//���� ������� ������� ������ ������
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




procedure end_game; forward;//����������� �������� ��������� ��������� �����


{�������� �������}
procedure The_game;
var
  strin:string;
begin
  if (detector>10) and (time>20) then//���� ����, �������� �������� ����
  begin
    detector:=detector mod 10;
    time:=time-25;
  end;
  create_figure;//������� ������
  x:=4;//������ �� ���������� � ����
  y:=-1;
  Move;//��������� �� ��������
  Cut_lines(field);//������� ����������� �����
  main_field:=field;
  str(score,strin);//������� �� ����� ���������� ����
  setbrushcolor(clgray);
  textOut(230,200,strin);
  if not game_over then//���� ��� �� ���������, �� ���������������
    The_game
  else
    end_game;//����� ����
end; 
 
 
 
       
                          
                                      {����� 4. ����}
                                      

{����� ����}                                      
procedure end_game;
var
  strin:string;
begin
  Window.Width:=210;//��������� ����
  Window.Width:=400;
  setbrushcolor(clwhite);
  fillrect(210,0,400,390);
  textOut(250,100,'Your score');//������� �������� ����
  setfontsize(50);
  str(score,strin);
  case score of
    0:textOut(280,130,strin);
    100..900:textOut(240,130,strin);
    1000..9900: textOut(225,130,strin);
    10000..20000: textOut(200,130,strin);
  end;
  setfontsize(10);
  case score of//� ����������� �� ����� ������ ���������� � ��������������� ������
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


procedure start_menu; forward;//����������� �������� �������� ����


{���������� �� ����}
procedure show_information;//������� �� ����� ���������� ����� about �� ����� data
var
  f:text;
  str:string;
  y:integer;
begin
  setwindowwidth(400);//��������� ����
  clearwindow;//������ ���
  setbrushcolor(clwhite);
  assign(f,'data/about.txt');//�������� �����
  reset(f);
  y:=4;
  setfontsize(10);
  while not EoF(f) do//��������� � ������� ���������
  begin
    readln(f,str); 
    textout(3,y,str);
    y:=y+15;
  end;
  textout(130,360,'NRNU MEPHI, kaf 17');
  readln;
  start_menu;//������� � ����
end;
{...}



{��������� ����}
procedure Start_menu;//��������� ������ ���� � ������� ���� �� ����
var
  key:string; 
begin
  SetWindowWidth(210);//������� ������
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
  if key='1' then//���� �� ���������� ����� 1 ������� ���� �� ����
    show_information;
end;
{...}



                                      {�������� ����}
                                      
begin
  SetWindowIsFixedSize(true);//���� ������ ��������
  setWindowTitle('Tetris');//���� ���������� ������
  Start_menu;//��������� ��������� ����
  preparing_to_game;//��������� � ����
  The_game;//��������� ����
end.


