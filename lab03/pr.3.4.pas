{���������, ������� ��� ������� ����������� � ������������ �������� ������� y=ax+b+c*sin(d*x)(��� a,b,c,d ��� ��������� 4 ����� ������� �� ������ 7 "�"=1,�="2") 
�� �������, ������� �������� �������� �������������}
{����������� ������ �������� ������� �� ������� � ����� N � �� ��� ������������ ������� � ��������}
const
  Bukva1=ord('�');                                 {� ������ ��������� �������� 4 ��������� ����� �������}
  Bukva2=ord('�');
  Bukva3=ord('�');
  Bukva4=ord('�');
  A=(Bukva1-ord('�')+1)mod 7;                      {����������� �������� ������������� �,b,c,d, �� ���������� � ������� �������}
  B=(Bukva2-ord('�')+1)mod 7;
  C=(Bukva3-ord('�')+1)mod 7;
  D=(Bukva4-ord('�')+1)mod 7;
  N=0.001;                                         {N-���������, ������������ �������� ���������� �������� � ���������}
var x1,x2:real;                                    {������� �������}
min,max:real;                                      {������� �������� �������� � ���������}
x,y:real;                                          {���������� ��� ������ �������� ������� ������ �������}
begin
  writeln('������� ������ � ����� ���������� ����� ������. ��������! ��� ������� ������� ����� ���������� ��������� ����� �������� ������� �����');
  readln(x1,x2);
  x:=x1;                    {����������� ��������� � ������ �������}
  min:=A*x+B+C*sin(D*x);    {����������� ���������� min �������� � ������ �������}             
  max:=A*x+B+C*sin(D*x);    {����������� ���������� min �������� � ������ �������}  
  while x<=x2 do            {��������� ������ � �� ������� � ����� N}
    begin                   
      y:=A*x+B+C*sin(D*x);  {��������� �������� ������� �� �}
      if max<y then         {���������� � m��}
        max:=y;               
      if min>y then         {���������� � min}
        min:=y;
      x:=x+N;               {����������� � �� �������� ���}
    end;
    y:=A*x2+B+C*sin(D*x2);  {�������� ��������� �������� �� ����� ��� ���� �������}
  if min>y then 
    min:=y; 
  if max<y then 
    max:=y;
  writeln('������������ ��������=',max:7:5);        {������� ������� ��������}
  writeln('����������� ��������=',min:7:5);
end.
  