                 {����� ����������� �����}
{�����, ������� ������� � ������� ���������� ����� � ��������� ������}

procedure Input(var name:string);//����
begin
  writeln('Enter name of file');
  readln(name);
end;

procedure Action(f:text;filename:string);//��������
var
  c:char;//������ ��� ����������
begin
  if not FileExists(FileName) then//���� ����� ���, �� ����� ���������� ����� �������
    FileName:=FileName+'.txt';
  if FileExists(FileName) then//���� ���� ����
  begin
    assign(f,FileName);//������
    reset(f);//��������
    while not EoF(f) do//������� �����, ��� � �����
    begin
      read(f,c);
      write(c);
    end;
    close(f);//���������
  end
  else//���� ����� ���
    write('That file is not');
end;

var
  f:text;//����
  FileName:string;//��� �����
 
begin
  Input(FileName);//��������� ���
  Action(f,filename);
end.