                                      {��������� �����}
{
���� ����������:
  1.������� �������� ��������(�����)
  2.������� ������ �� �� ����� � ���� �����
  3.������� �������������� ������ ����� �� ������
  4.�������� ����������� �������
}

const
  MAX=50;//������������ ����� �����
type
  Ttower=array[0..MAX] of integer;//�����
  Ttowers=array[1..3] of Ttower;//3 �����
  
procedure Input(var a:Ttowers;n:integer);//������� �������� ��������(�����)
var
  i,k:integer;//��������
  strin:string;
begin
  for i:=1 to MAX do//�������������� ����� ��� ������
  begin
    a[1][i]:=0;
    a[2][i]:=0;
    a[3][i]:=0;
  end;
  k:=1;
  for i:=n downto 1 do//��������� ������ �����
  begin
    a[1][k]:=i;
    inc(k);
  end;
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


procedure Hanoys_Towers(var a:Ttowers; t_from,t_to,t_ext,m,n:integer);//����������� ���� ������ ���-� m � ����� t_from �� t_to (�������� ���������).
var
  i:integer;
begin
  if (m>0) then//����� �� ��������
  begin
    Hanoys_Towers(a,t_from,t_ext,t_to,m-1,n);//������������� ���� ��� 1 �� ��� �����
    Shift(a,t_from,t_to);//������������� ������
    Hanoys_Towers(a,t_ext,t_to,t_from,m-1,n);//������������� ���� � ��� ���� ����
  end;
end;


var
  a:Ttowers;//�����
  n,i:integer;//�����
begin
  readln(n);
  Input(a,n);//����
  Hanoys_Towers(a,1,2,3,n,n);//����
  writeln('complete');
end.