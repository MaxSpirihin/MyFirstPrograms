                                  {�������������� �����}
{� ���-�� ������ ����� ������ ������ ����� ���������� �� ����� � ���-�� ��� ����������. ��� N ���}
procedure Enter(var n:integer;var number:string);     {��������� ����� ������}
begin
  Writeln('Enter amount of operation:');
  readln(n);
  writeln('Enter number:');
  readln(number);
end;

procedure Total(number:string);                        {��������� ������ ������}
begin
  writeln('Total is ',number);
end;

function Action(number:string):string;                 {�������, �������� ����� �� �������}
var
  i,j:integer;//���������� �����
  act:string;//���������� ������(�����)
  c,b:string;//��������������� ����������
begin
  i:=1;
  act:='';
  while i<=length(number) do
    begin
    c:=copy(number,i,1);//���� �����
    j:=0;
    while copy(number,i+j,1)=c do//����, ������� ��� ����� ���� ������
      j:=j+1;
    str(j,b);//�� ���� ���������� �������
    act:=act+b+c;
    i:=i+j;//������������� �� ������ ����� � �����
    end;
  action:=act;
end;

var
  n,i:integer;//n ���������� ������� ��� �������� �������, i-���������� �����
  number:string;//��������� � ���������� �����

begin
  Enter(n,number);//���� ������
  for i:=1 to n do
    number:=action(number);//��������� ������� n ���
  Total(number);//������� �����
end.