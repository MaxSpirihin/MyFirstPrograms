procedure FindNeightBourghs(str: string);
var
  i, j: integer;//�������� �����                           
  wd, oldWd: string;//������ � ����� �����
begin
  oldWd := ' ';
  i := 0;
  while i <= length(str) do//��������� ��� ������� ������
  begin
    if (i = 0) or (copy(str, i, 1) = ' ') then//���� ������
    begin
      j := 1;
      while (copy(str, i + j, 1) <> ' ') and (i + j <= length(str)) do//���� ��������� ������ ��� ����� ������
        j := j + 1;
      //����� ����� �������
      wd := copy(str, i + 1, j - 1);
      //���� ���������������� �����������, �������� � ���
      if (length(wd) >= 2) and (length(wd) <= 6) then
      begin
        if wd = oldWd then
          writeln(wd);
        oldWd := wd;
      end;
    end;
    i := i + 1; 
  end;
end;


var
  str: string;//������ � ����.���������

begin
  writeln('Enter string:');
  readln(str);
  FindNeightBourghs(str);
end.