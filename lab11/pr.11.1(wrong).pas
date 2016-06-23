                   {СПИСОК}
{Прога, создающая список и позволяющая работать с ним}
uses crt; 
 
type
  queue=^s;//список
  s=record
    key:integer;//данные
    next:queue;//указатель на следующий эл-т
  end;
  
var
  Ex:boolean;//датчик выхода(глобальный)


procedure InsertNum(num:integer; var a:queue);//добавление num в список а
var
  real_a:queue;//доп переменная
begin
  if a=nil then//если список пус, создаем
  begin
    new(a);
    a^.key:=1;
    a^.next:=nil;
  end
  else//если он не пуст
  begin
    real_a:=a;//записываем его текущее значения
    while a^.next<>nil do//двигаем до последнего эл-та
    begin
      a:=a^.next;
    end;
    new(a^.next);//включаем эл-т
    a^.next^.key:=num;
    a^.next^.next:=nil;
    a:=real_a;//перемещаем указатель в начальное значение
  end;
end;

procedure Print(a:queue);//вывод списка
begin
  while a<>nil do//пока есть что выводить
  begin
    write(a^.key,' ');//выводим
    a:=a^.next;//двигаем дальше
  end;
end;
 
procedure Delete(var a:queue);//удаление
var
  real_a:queue;
begin
  if a<>nil then//если список не пуст
  begin
    if a^.next=nil then//если список из 1 элемента, чистим его
    begin
      dispose(a);
      a:=nil;
    end
    else//если много элементов
    begin
      real_a:=a;//доп переменная
      while a^.next^.next<>nil do//двигаем к предпоследнему эл-ту 
        a:=a^.next;
      dispose(a^.next);//чистим посл.элемент
      a^.next:=nil;
      a:=real_a;//перемещаем указатель в начальное значение
    end;
  end;
end;


procedure Menu1_Inserting(var a:queue);//добавление эл-та
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

procedure Menu3_Print(var a:queue);//печать
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


procedure Menu2_Deleting(var a:queue);//удаление
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


procedure Main_Menu(var a:queue);//гл.меню
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
  ex:=false;//пока выходить не надо
  while not ex do//если не выход, запускаем гл.меню
    Main_Menu(a);
end.