                                   {����������� �������� ������}
{����� �������� ����������� ������������� �������� � ��������� ������}
type
  symbol=array[' '..'�'] of byte;//������, ������������������ ����� ���������
  
procedure Input(var str:string);//��������� �����
begin
  writeln('Enter string:');
  readln(str);
end;

procedure Output(table:symbol);//��������� ������
var
  i:char;
  j:integer;
begin
  for i:=' ' to '�' do//��������� ���� ������
  begin
    if table[i]>0 then//���� ������ ���
    begin
      write(i);//������� ������
      for j:=1 to Table[i] do
      write('*');//������� ������� �����, ������� ��� ����������� ������
      writeln;//������������� ������
    end;
  end;
end;

procedure Filing(str:string;var table:symbol);//���������� ������� ��������
var 
  i:char;
  j:integer;
begin
  for i:=' 'to '�' do//������� ��������� ������
    table[i]:=0;  
  for j:=1 to length(str) do//����� ������ ������ � ����������� ��� ���-�� � ������� �� 1
    table[str[j]]:=table[str[j]]+1;  
end;

var
  str:string;//������
  table:symbol;//������, ��� table[i]=n i-������ n-���������� ��� ������������� � ������ 

begin
  Input(str);//����
  Filing(str,table);//���������� �������
  Output(table);//�����
end.