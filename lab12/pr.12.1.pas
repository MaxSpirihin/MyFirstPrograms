                       {������ �������}


uses graphABC;

const
  TOPX=650;//����-�� ������� �� ��� �
  TOPY=350;//������ ������� �� ��� y;
  EY=100;//����� ���������� ������� �� y;
  EX=50;//����� ���������� ������� �� x;
  LENX=500;//����� ��� �(��������)
  LENY=250;//����� ��� y(��������)
  EPS=0.02;//���
  STARTX=10;//����� ����� � ������



function func(x:real):real;//�������, ��� ������ �� ������. ��� ��������� �� �������� �������� ��������� name!!!
begin
  func:=cos(x);
end;

procedure Name();//������� �������� �-��.
begin
  SetfontSize(100);
  SetfontColor(clred);
  TextOut(20,20,'y=cos(x)');
end;

function NewY(y0:real): integer;//������� �-�� �����. � ����� �������
var
  y:integer;
begin
  y0:=y0*10000;
  y:=trunc(y0);
  y:=y div (10000 div EY);
  y:=TOPY-y;
  NewY:=y;
end;

function NewX(x0:real): integer;//������� �-�� �����. � ����� �������
var
  x:integer;
begin
  x0:=x0*10000;
  x:=trunc(x0);
  x:=x div (10000 div EX);
  x:=TOPx+x;
  NewX:=x;
end;

procedure Start();//���������� ������
var
  x,y:integer;
begin
  InitgraphABC();
  SetWindowSize(1300,700);
  SetWindowPos(10,10);
  line(TOPX-LENX,TOPY,TOPX+LENX,TOPY);//��� �
  line(TOPX,TOPY-LENY,TOPX,TOPY+LENY);//��� y
  //������ ���������
  line(TOPX-5,TOPY-LENY+5,TOPX,TOPY-LENY);//y
  line(TOPX+5,TOPY-LENY+5,TOPX,TOPY-LENY);
  line(TOPX+LENX-5,TOPY-5,TOPX+LENX,TOPY);//x
  line(TOPX+LENX-5,TOPY+5,TOPX+LENX,TOPY);
  //����������� � � �
  textout(TOPX+5,TOPY-LENY-5,'y');
  textout(TOPX+LENX+5,TOPY-10,'x'); 
  textout(TOPX+5,TOPY+5,'0');
  //����� ��������
  Name();
end;

procedure doey();//������������ �� �������� �� �
var
  y:integer;
begin
    y:=0;
  while (y<LENY) do
  begin
    line(TOPX-2,TOPY-y,TOPX+2,TOPY-y);
    line(TOPX-2,TOPY+y,TOPX+2,TOPY+y);
    y:=y+EY;
  end;
end;

procedure doex();//������������ �� �������� �� �
var
  x:integer;
begin
  x:=0;
  while (x<LENX) do
  begin
    line(TOPX+x,TOPY-2,TOPX+x,TOPY+2);
    line(TOPX-x,TOPY-2,TOPX-x,TOPY+2);
    x:=x+EX;
  end;
end;

procedure Dopi();//������������ �� �� �. ��� �������� ������
var
  x,k,s:integer;
  stri:string;
begin
  setfontsize(10);//����� �������
  setfontcolor(clblack);
  s:=1;//������� ��
  k:=NewX(pi)-TOPX;//������� �� � �������
  x:=k;//������
  while (x<LENX) do//���� ���� ���� ��������
  begin
    line(TOPX+x,TOPY-2,TOPX+x,TOPY+2);//������ �������
    str(s,stri);//��������� ����� �� � ������
    textout(TOPX+x-5,TOPY+6,stri+'�');//�������  ����� ��
    line(TOPX-x,TOPY-2,TOPX-x,TOPY+2);//���������� ��� �������������
    textout(TOPX-x-5,TOPY+6,'-'+stri+'�');
    x:=x+k;//������
    s:=s+1;//���������� ������� ��
  end;
end;

procedure DoGraph();//���������� �������. ������ �������� �� ������ �� 1 ����� � ���������
var
  x,y:real;//����-��
  xn,yn,xp,yp:integer;//��� � ��������(����� � ����������)
begin
  x:=-STARTX;//�������� ����
  y:=func(x);//��������� �
  xp:=newx(x);//��������� � �������
  yp:=newy(y);
  x:=x+EPS;//������
  while (x<STARTX) do//���� �� ����� �� �����
  begin
    y:=func(x);//��������� �
    yn:=NewY(y);//��������� � �������
    xn:=NewX(x);
    line(xn,yn,xp,yp);//������ ����� �� ����� ����� � ����������
    xp:=xn;//����� ����� ����� ������
    yp:=yn;
    x:=x+EPS;//������
  end;
end;

begin
  Start();//�������������� �������
  Dograph();//������ ������
  doey();//����������� �� ������� �� �
  Dopi();//��������� ��
end.  