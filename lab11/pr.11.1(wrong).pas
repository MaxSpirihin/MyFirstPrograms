                   {������}
{�����, ��������� ������ � ����������� �������� � ���}
uses crt; 
 
type
  queue=^s;//������
  s=record
    key:integer;//������
    next:queue;//��������� �� ��������� ��-�
  end;
  
var
  Ex:boolean;//������ ������(����������)


procedure InsertNum(num:integer; var a:queue);//���������� num � ������ �
var
  real_a:queue;//��� ����������
begin
  if a=nil then//���� ������ ���, �������
  begin
    new(a);
    a^.key:=1;
    a^.next:=nil;
  end
  else//���� �� �� ����
  begin
    real_a:=a;//���������� ��� ������� ��������
    while a^.next<>nil do//������� �� ���������� ��-��
    begin
      a:=a^.next;
    end;
    new(a^.next);//�������� ��-�
    a^.next^.key:=num;
    a^.next^.next:=nil;
    a:=real_a;//���������� ��������� � ��������� ��������
  end;
end;

procedure Print(a:queue);//����� ������
begin
  while a<>nil do//���� ���� ��� ��������
  begin
    write(a^.key,' ');//�������
    a:=a^.next;//������� ������
  end;
end;
 
procedure Delete(var a:queue);//��������
var
  real_a:queue;
begin
  if a<>nil then//���� ������ �� ����
  begin
    if a^.next=nil then//���� ������ �� 1 ��������, ������ ���
    begin
      dispose(a);
      a:=nil;
    end
    else//���� ����� ���������
    begin
      real_a:=a;//��� ����������
      while a^.next^.next<>nil do//������� � �������������� ��-�� 
        a:=a^.next;
      dispose(a^.next);//������ ����.�������
      a^.next:=nil;
      a:=real_a;//���������� ��������� � ��������� ��������
    end;
  end;
end;


procedure Menu1_Inserting(var a:queue);//���������� ��-��
var
  i:integer;
  key:char;
begin
  clrscr;
  writeln('Enter element');
  readln(i);
  InsertNum(i,a);
  write('Complete. Press any key');
  key:=readkey;
end;

procedure Menu3_Print(var a:queue);//������
var
  k:char;
begin
  if a=nil then
  begin
    clrscr;
    write('Queue is empty. Press any key');
    k:=readkey;
  end
  else
  begin
    clrscr;
    Print(a);
    writeln;
    write('Complete. Press any key');
    k:=readkey;
  end;
end;


procedure Menu2_Deleting(var a:queue);//��������
var
  key:char;
begin
  if a=nil then
  begin
    clrscr;
    write('Queue is empty. Press any key');
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


procedure Main_Menu(var a:queue);//��.����
var
  k:char;
begin
  clrscr;
  gotoxy(30,1);
  writeln('The Queue');
  writeln('1-Add element to queue');
  writeln('2-Delete last element from queue');
  writeln('3-Print queue');
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
  a:queue;
  i:integer;
begin
  ex:=false;//���� �������� �� ����
  while not ex do//���� �� �����, ��������� ��.����
    Main_Menu(a);
end.