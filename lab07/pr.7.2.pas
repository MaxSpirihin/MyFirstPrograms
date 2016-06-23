                              {Ѕџ—“–јя —ќ–“»–ќ¬ ј}
{ѕрога, сортирующа€ введенный массив быстрой сортировкой}
const
  N = 20;

type
  Tarray = array[1..N] of integer;//массив


procedure replacement(var a, b: integer);//обмен значени€ми
var
  r: integer;//доп переменна€
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


procedure qSort(first, last: integer; var arr: tarray);//быстра€ сортировка подмножества массива а с начальным эл-м first и конечным last
var
  i, j, k:integer;//счетчики 
  center:integer;//значение центра и 
  b: tarray;//доп массив
begin
  if last > first then//если элемент не один
  begin
    if last - first = 1 then//если 2 элемента, то тупо упор€дочиваем их 
    begin
      if arr[last] < arr[first] then
        replacement(arr[last], arr[first]);
    end
    else//если 3 и более элементов
    begin
      i:=first;//номер €чейки доп массива, куда записываем элементы  меньше центрального
      j:=last;//номер €чейки доп массива, куда записываем элементы  больше центрального
      center := arr[first];//центральную будем тупо брать первую{можно исправить код и изменить это}
      for k:=first to last do//дл€ всех эл-в подмассива
        if arr[k]<>center then//если элемент не равен центральному
        begin
          if arr[k]>center then//если эл-т больше центральноого
          begin
            b[j]:=arr[k];//впихиваем его в j-ю €чейку доп массива
            j:=j-1;//€чейку уменьшаем(идем с конца)
          end
          else
          begin//если эл-т меньше центральноого
            b[i]:=arr[k];//впихиваем его в i-ю €чейку доп массива
            i:=i+1;//€чейку увеличиваем(идем с начала)
          end;
        end;
      for k:=i to j do//незаполненные €чейки должны быть равны центральному
        b[k]:=center;
      for k:=first to last do//мен€ем подмассив исходного массива
        arr[k]:=b[k];
      qsort(first,i-1,arr);//сортируем левую от центра часть
      qsort(j+1,last,arr);//сортируем правую от центра часть
    end;
  end;
end;


procedure output(arr:tarray;k:integer);//вывод массива
var 
  i:integer;
begin
  writeln('ordered array is');
  for i:=1 to k do
    write(arr[i],' ' );
end; 


var
  arr: tarray;//массив
  k:integer;//кол-во эл-в массива
  i:integer;//счетчик

begin
  Input(arr, k);//ввод массива
  qSort(1, k, arr);//быстра€ сортировка
  output(arr,k);//вывод массива
end.