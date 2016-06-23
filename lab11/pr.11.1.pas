                   {����}
{�����, ��������� ���� � ����������� �������� � ���}
uses crt; 
 
type
  stack=^s;//������
  s=record
    key:integer;//������
    prev:stack;//��������� �� ���� ��-�
  end;
  


procedure Insert(num:integer; var a:stack);//����������
var
  next:stack;
begin
  if a=nil then//���� � ��� ������ ����//�������
  begin
    new(a);
    a^.key:=num;
    a^.prev:=nil;
  end
  else
  begin
    new(next);//������� ����. ������� �����
    next^.key:=num;
    next^.prev:=a;//� ������ ����������
    a:=next;
  end;
end;


procedure Delete(var a:stack);//��������
var
  ext:stack;//��� ����������
begin
  ext:=a^.prev;//��������� ����� ���� ������ �����
  dispose(a);//������ ������
  a:=ext;//������������ ��������� �����
end;

procedure Print(a:stack);//����� �����
begin
  while a<>nil do//���� ���� ��� ��������
  begin
    write(a^.key,' ');//�������
    a:=a^.prev;//������� �����
  end;
end;


procedure Menu1_Inserting(var a:stack);//���������� ��-��
var
  i:integer;
  key:char;
begin
  clrscr;
  writeln('Enter element');
  readln(i);
  Insert(i,a);
  write('Complete. Press any key');
  key:=readkey;
end;

procedure Menu3_Print(var a:stack);//������
var
  k:char;
begin
  if a=nil then
  begin
    clrscr;
    write('Stack is empty. Press any key');
    k:=readkey;
  end
  else
  begin
    clrscr;
    Print(a);
    writeln;
    write('Press any key');
    k:=readkey;
  end;
end;


procedure Menu2_Deleting(var a:stack);//��������
var
  key:char;
begin
  if a=nil then
  begin
    clrscr;
    write('Stack is empty. Press any key');
    key:=readkey;
  end
  else
  begin
    Delete(a);
    clrscr;
    write('Complete. Press any key');
    key:=readkey;
  end;
end;


procedure Main_Menu(var a:stack; var ex:boolean);//��.����
var
  k:char;
begin
  clrscr;
  gotoxy(30,1);
  writeln('The Stack');
  writeln('1-Add element to stack');
  writeln('2-Delete element from stack');
  writeln('3-Print stack');
  writeln('4-Exit');
  k:=readkey;
  case k of
    '1':Menu1_Inserting(a);
    '2':Menu2_Deleting(a);
    '3':Menu3_Print(a);
    '4':ex:=true;
  end;
end;

  
var
  Ex:boolean;//������ ������
  a:stack;
  i:integer;
begin
  ex:=false;//���� �������� �� ����
  while not ex do//���� �� �����, ��������� ��.����
    Main_Menu(a,ex);
end.