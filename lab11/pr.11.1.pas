                   {СТЕК}
{Прога, создающая стек и позволяющая работать с ним}
uses crt; 
 
type
  stack=^s;//список
  s=record
    key:integer;//данные
    prev:stack;//указатель на пред эл-т
  end;
  


procedure Insert(num:integer; var a:stack);//добавление
var
  next:stack;
begin
  if a=nil then//если у нас пустой стек//создаем
  begin
    new(a);
    a^.key:=num;
    a^.prev:=nil;
  end
  else
  begin
    new(next);//создаем след. элемент стека
    next^.key:=num;
    next^.prev:=a;//а теперь предыдущий
    a:=next;
  end;
end;


procedure Delete(var a:stack);//удаление
var
  ext:stack;//доп переменная
begin
  ext:=a^.prev;//сохраняем адрес пред ячейки стека
  dispose(a);//чистим память
  a:=ext;//перекидываем указатель назад
end;

procedure Print(a:stack);//вывод стека
begin
  while a<>nil do//пока есть что выводить
  begin
    write(a^.key,' ');//выводим
    a:=a^.prev;//двигаем назад
  end;
end;


procedure Menu1_Inserting(var a:stack);//добавление эл-та
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

procedure Menu3_Print(var a:stack);//печать
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


procedure Menu2_Deleting(var a:stack);//удаление
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


procedure Main_Menu(var a:stack; var ex:boolean);//гл.меню
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
  Ex:boolean;//датчик выхода
  a:stack;
  i:integer;
begin
  ex:=false;//пока выходить не надо
  while not ex do//если не выход, запускаем гл.меню
    Main_Menu(a,ex);
end.