                      {������� �� ���������}
{����� ������� ����, ���� ���������� ����� �� ���������� �����, ����� ��������� ����� �� �������� � ��������}

procedure Redacting(var c:char);//��������� �������
begin
  case c of 
    'A'..'Z':c:=chr(ord(c)+32);
    'a'..'z':c:=chr(ord(c)-32);
    '�'..'�':c:=chr(ord(c)-32);
    '�'..'�':c:=chr(ord(c)+32);
  end;
end;

procedure Input(var name:string);//����
begin
  writeln('Enter name of file');
  readln(name);
end;


procedure Action(Filename:string);//��������
var
  f,f2:text;//���� ��� ������ � ������
  c:char;//����������� ������
begin
  if not FileExists(FileName) then//���� ����� ���, �� ����� ���������� ����� �������
    FileName:=FileName+'.txt';
  if FileExists(FileName) then//���� ���� ����
  begin
    assign(f,FileName);
    assign(f2,'Total.txt');
    reset(f);
    rewrite(f2);
    while not EoF(f) do
    begin
      read(f,c);//��������� ������
      redacting(c);//��������
      write(f2,c);//����� �� 2� ����
    end;//���� �� ����� �����
    writeln('Complete!!!');
    close(f);//���������
    close(f2);
  end
  else
    writeln('File is not'); 
end;


var
  Filename:string;
begin
  input(FileName);//����
  Action(FileName);//��������
end.