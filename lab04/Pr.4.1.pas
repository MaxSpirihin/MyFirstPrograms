{������� ����������� ���������}
{������ ��������� ������������� ��� ���������� ������ ����������� ���������}
program SolveSqrEqual;

const
  INF_ROOTS=3;                                                                   {���������, ������������ ���������� ������, ���� �� ����������}
  TEST=1;                                                                        {������������� ������� �����. 1 ��� ������� �����}
 
procedure InputVars (var a,b,c:real);                                            {��������� ����� ������������� ���������}
begin
  writeln('Quadratic equation of the form ax^2+bx+c');
  writeln('Enter a');
  readln(a);
  writeln('Enter b');
  readln(b);
  writeln('Enter c');
  readln(c);
end;

procedure showroots(nroots:byte; x1,x2:real);                                    {��������� ������ ������ � ���-�� �� �� ���-��}
begin
  case nroots of                                                                 {� ����������� �� ���-�� ������, ����� ��������}
    0:writeln('No solution');
    1:writeln('single solution x=',x1:7:5);
    2:writeln('Two solution x1=',x1:7:5,', x2=',x2:8:5);
    INF_ROOTS:writeln('x belongs R');
  else
    writeln('Error');                                                            {�������� ���-�� ������ ������ ���� 0,1,2,INF_ROOTS}
  end;
end;

function SolveSqrEq(a,b,c:real; var x1,x2:real):byte;                            {�������, ������������ ���-�� ������ ���������, � ����� ������������ � �1 � �2 �������� ������ ���������}
var 
  D:real;                                                                        {������������}
  r:byte;                                                                        {���-�� ������}
begin
  if 0=a then                                                                    {���� ��������� ��������}
    begin
    if 0=b then                                                                      {���� ��������� ���� 0*�=-c}
      begin 
      if 0=c then                                                                         {0*x=0  x-�����}
        r:=INF_ROOTS
      else                                                                                {0*x<>0 ������ ���}
        r:=0;                         
      end
    else                                                                             {���� b*x=-c, b<>0, 1 ������ x=-c/b}                                                        
      begin
      x1:=-c/b;
      r:=1;
      end;
    end
  else                                                                            {���� ��������� ����������}
    begin
    D:=sqr(b)-4*a*c;                                                              {��������� ������������}                                       
    if 0>D then                                                                   {���� ������������ �����������, ������ ���}
      r:=0
    else
      begin
      if 0=D then                                                                 {���� ������������ ����� ����, �� 1 ������� x=-b/(2*a)}
        begin
        x1:=-b/(2*a);
        r:=1;
        end
      else                                                                        {���� ������������ �����������, �� 2 �������. ��������� �� �� �������}
        begin
        r:=2;
        x1:=(-b-sqrt(D))/(2*a);
        x2:=(-b+sqrt(D))/(2*a);
        end;
      end;
    end;
  SolveSqrEq:=r;                                                                  {���-�� ������ r ������ ���������� �������}
end;

procedure Realtest(var x1,x2:real; nroots:byte);                                  {���������, ����������� ������ ���� ��������� � ���������, ����� �� ��� ��������}
var
  flag:boolean;
begin
  flag:=true;
  nroots:=SolveSqrEq(0,0,0,x1,x2);
  if nroots<>INF_ROOTS then 
    flag:=false;
  nroots:=SolveSqrEq(0,0,1,x1,x2);
  if nroots<>0 then 
    flag:=false;
  nroots:=SolveSqrEq(0,1,1,x1,x2);
  if (x1<>-1) or (nroots<>1) then 
    flag:=false;
  nroots:=SolveSqrEq(1,1,20,x1,x2);
  if nroots<>0 then 
    flag:=false;
  nroots:=SolveSqrEq(1,2,1,x1,x2);
  if (x1<>-1) or (nroots<>1) then 
    flag:=false;
  nroots:=SolveSqrEq(1,-5,4,x1,x2);
  if (x1<>1) or (nroots<>2) or (x2<>4) 
    then flag:=false;
  if flag then
    writeln('Test is passed')
  else
    writeln('Test is not passed')
end;
  
var 
  a,b,c:real;                                                                    {������������ ��������}
  x1,x2:real;                                                                    {�����}
  nroots,test_test:byte;                                                         {���-�� ������,������������� ������� �����}
begin
  test_test:=TEST;
  if test_test=1 then
    RealTest(x1,x2,nroots)
  else
    begin
    InputVars(a,b,c);                                                            {���� ������������� a,b,c}
    nroots:=SolveSqrEq(a,b,c,x1,x2);                                             {���������� ������ ���������}
    showroots(nroots,x1,x2);                                                     {����� ������}
    end;
end.