                            {СОРТИРОВКА СЛИЯНИЕМ}
{Прога, сортирующая массив слиянием}
const
  N = 20;

type
  Tarray = array[1..N] of integer;//массив


procedure replacement(var a, b: integer);//обмен значениями
var
  r: integer;//доп переменная
begin
  r := a;
  a := b;
  b := r;
end;

procedure Input(var arr: tarray; var k: integer);//процедура ввода
var
  i: integer;
begin
  writeln('Enter amount of elements');
  readln(k);
  writeln('Enter elements');
  for i := 1 to k do
    read(arr[i]);
end;


procedure output(arr:tarray;k:integer);//вывод массива
var 
  i:integer;
begin
  writeln('ordered array is');
  for i:=1 to k do
    write(arr[i],' ' );
end; 



procedure Merg_sort(first,last:integer;var arr:tarray);//сортировка слиянием
var
  i,j,index1,index2,index:integer;//индексы
  b:tarray;//доп массив
begin
  i:=first+(last-first+1) div 2-1;//индекс конца первой половины
  j:=i+1;//индекс начала второй половины
  if last-first>0 then//если если в подмассиве не 1 элемент
  begin//упорядочиваем обе половины тем же способом
    merg_sort(first,i,arr);
    merg_sort(j,last,arr);
  end;
  if last-first=1 then//если подмассив мз 2 элементов тупо упорядочиваем их
  begin
    if arr[last] < arr[first] then
      replacement(arr[last], arr[first]);
  end 
  else//если эл-в 3 и больше
  begin
    index1:=first;//индекс первой половины
    index2:=j;//индекс второй половины
    index:=first;//индекс заполняемого допмассива
    while (index1<=i) and (index2<=last) do//если не вылезли за границы половин
    begin
      if arr[index1]<arr[index2]then//если текущий элемент 1 половины больше чем второй, вбиваем его в допмассив
      begin
        b[index]:=arr[index1];
        index1:=index1+1;
      end
      else//если текущий элемент 2 половины больше чем первой, вбиваем его в допмассив
      begin
        b[index]:=arr[index2];
        index2:=index2+1;
      end;
      index:=index+1;//увеличиваем индекс допмассива т. к. забили элемент
    end;
    //в какой то половине остались элементы
    if index1>i then//если они во втором
    begin
     for index1:=index2 to last do//забиваем их в допмассив
      begin
        b[index]:=arr[index1];
        index:=index+1;
      end
    end
    else//если они во втором
    begin
      for index2:=index1 to i do//забиваем их в допмассив
      begin
        b[index]:=arr[index2];
        index:=index+1;
      end;
    end;   
    for index:=first to last do//копируем нужные элементы из допмассива в основной
      arr[index]:=b[index];
  end;
end;
  

var
  arr:tarray;
  k:integer;
  

begin
  input(arr,k);//ввод массива
  Merg_sort(1,k,arr);//сортируем
  output(arr,k);//вывод массива
end.