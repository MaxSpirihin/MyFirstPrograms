                                      {��������� �����}
{
���� ����������:
  1.������� �������� ��������(�����)
  2.������� ������ �� �� ����� � ���� �����
  3.������� �������������� ������ ����� �� ������
  4.�������� ����������� �������
}

uses crt,graphABC;//������ ��� ��������, ���� ��� ���������

const
  MAX=20;//������������ ����� �����
  TIME=300;//����� ������������
  
type
  Ttower=array[0..MAX] of integer;//�����
  Ttowers=array[1..3] of Ttower;//3 �����
  
procedure Input(var a:Ttowers;var n:integer);//������� �������� ��������(�����)
var
  i,k:integer;//��������
  strin:string;
begin
  setWindowWidth(400);//����������� ����
  SetWindowHeight(200);
  for i:=1 to MAX do//�������������� ����� ��� ������
  begin
    a[1][i]:=0;
    a[2][i]:=0;
    a[3][i]:=0;
  end;
  SetFontSize(40);//����� �������
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
  while (n>MAX-1) or (n<1) do//��������� ���-�� ������
    readln(n);
  k:=1;
  for i:=n downto 1 do//��������� ������ �����
  begin
    a[1][k]:=i;
    inc(k);
  end;
end;



procedure Output(a:Ttowers;n:integer);//���������
var
  i:integer;
  h,dif,len:integer;//������ 1 �����, ������� ��������, ������ �������
begin
  LockDrawing;//��� ������
  setbrushcolor(cllightblue);
  fillrect(0,0,400,200);
  setbrushcolor(clblack);
  fillrect(0,180,400,200);
  TextOut(280,183,'By Spirikhin Maxim');
  fillrect(97,50,103,180);//������ �����
  fillrect(197,50,203,180);
  fillrect(297,50,303,180);
  //��������� ��������� 
  h:=100 div n;
  dif:=40 div n;
  //������������ �����
  setbrushcolor(clred);
  setpencolor(clblack);
  for i:=1 to n do//����� �
  if a[1][i]<>0 then
    begin
      len:=a[1][i]*dif;
      line(100-len,180-h*i,100+len,180-h*i);
      line(100-len,179-h*(i-1),100+len,179-h*(i-1));
      line(100-len,180-h*i,100-len,180-h*(i-1));
      line(99+len,180-h*i,99+len,180-h*(i-1));
      fillrect(101-len,181-h*i,99+len,179-h*(i-1));
    end;
  for i:=1 to n do//����� b
  if a[2][i]<>0 then
    begin
      len:=a[2][i]*dif;
      line(200-len,180-h*i,200+len,180-h*i);
      line(200-len,179-h*(i-1),200+len,179-h*(i-1));
      line(200-len,180-h*i,200-len,180-h*(i-1));
      line(199+len,180-h*i,199+len,180-h*(i-1));
      fillrect(201-len,181-h*i,199+len,179-h*(i-1));
    end;
  for i:=1 to n do//����� c
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


procedure Shift(var a:Ttowers;t_from,t_to:integer);//����������� �������� ����� � ����� t_from �� t_to
var
  i:integer;
  num_to,num_from:integer;//������ ������� ������
begin
  i:=1;
  while (a[t_from][i]<>0)and(i<>MAX) do
    inc(i);
  num_from:=i-1;//���� ������� ���������������� �����
  i:=1;
  while (a[t_to][i]<>0)and(i<>MAX) do
    inc(i);
  num_to:=i;//���� ���� ��� ���������
  a[t_to][num_to]:=a[t_from][num_from];//�������������
  a[t_from][num_from]:=0;
end;


procedure Hanoys_Towers(var a:Ttowers; t_from,t_to,m,n:integer);//����������� ���� ������ ���-� m � ����� t_from �� t_to (�������� ���������).
var
  i:integer;
  t_ext:integer;//����� ��� �����
begin
  if (m>0) then//����� �� ��������
  begin
    for i:=1 to 3 do//������� 3� �����. ��� ����� ��� �� ��������
      if (i<>t_from) and (i<>t_to) then
        t_ext:=i;
    Hanoys_Towers(a,t_from,t_ext,m-1,n);//������������� ���� ��� 1 �� ��� �����
    Shift(a,t_from,t_to);//������������� ������
    delay(TIME);
    Output(a,n);//������������
    Hanoys_Towers(a,t_ext,t_to,m-1,n);//������������� ���� � ��� ���� ����
  end;
end;


var
  a:Ttowers;//�����
  n:integer;//�����
begin
  SetWindowIsFixedSize(true);//���� ������ ��������
  setWindowTitle('Hanoys Towers');//���� ���������� Hanoys Towers
  Input(a,n);//����
  Output(a,n);//���������
  Hanoys_Towers(a,1,2,n,n);//����
  Output(a,n);//����
end.
//����� ��������� ����-2.5 ����