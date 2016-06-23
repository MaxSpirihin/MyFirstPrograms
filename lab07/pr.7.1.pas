                              {СОРТИРОВКА ДЕРЕВОМ}
{Прога сортитрует введенный массив деревом}
const
  N=100;//количество ячеек массива

type 
  tree=^S;//дерево
  s=record
    key:integer;
    left:tree;
    right:tree;
  end;
  Tarray=array[1..N] of integer;//массив
  
  
  
procedure Input(var arr:tarray; var k:integer);//процедура ввода
var
  i:integer;
begin
  writeln('Enter amount of elements');
  readln(k);
  writeln('Enter elements');
  for i:=1 to k do
    read(arr[i]);
end;



procedure round(a:tree);//симметричный обход дерева
begin
  if a<>nil then
  begin
    round(a^.left);
    write(a^.key,' ');
    round(a^.right);
  end;
end;




procedure ins(root:integer;var a:tree);//вставка числа в дерево
begin
    if (a=nil) then//если мы в пустом листе
      begin
      new(a);//создаем его
      a^.key:=root;//заполняем
      a^.left:=nil;
      a^.right:=nil;
      end
    else
    begin  
      if root>a^.key then//если больше идем направо, если меньше влево
        ins(root,a^.right)
      else
        ins(root,a^.left);
    end;
end;


procedure Do_tree(arr:tarray;k:integer; var a:tree);//построение дерева
var
  i:integer;
begin
  for i:=1 to k do//каждый элемент массива добавляем в дерево
    ins(arr[i],a);
end;


var
  a:tree;//дерево
  arr:tarray;//массив
  k:integer;//кол-во элементов

begin
  Input(arr,k);//ввод массива
  Do_tree(arr,k,a);//построение дерева
  Round(a);//симметричный обход дерева
end.

