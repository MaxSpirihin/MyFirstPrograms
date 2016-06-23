                         {ЧИСЛА ФИБОНАЧИ ПО СПИРАЛИ}
{Прога, которая запоняет массив N*M по спирали по часовой стрелке числами фибоначи по порядку}
const
  N=7;//кол-во строк
  M=7;//кол-во столбцов
  LEN=12;//длина символов для распечатки таблицы
  
type
  matrix=array[0..N+1,0..M+1] of int64;//матрица
  direction=byte;//направление хода(1-right, 2-left, 3-down, 4-up)
  
procedure filing(var mtx:matrix);//заполнение матрицы
var
  i,j:integer;//номера строки и столбца
  nnew,old,very_old:int64;//переменные для подсчета чисел фибоначи
  direct:direction;//направление
begin
  for i:=0 to N+1 do//заполним матрицу единицами, добавив лишние мтроки и столбцы с каждой стороны
    for j:=0 to M+1 do
      mtx[i,j]:=1;
  for i:=1 to N do//заполним нужную часть матрицы нулями
    for j:=1 to M do
      mtx[i,j]:=0;
  i:=1;//начинаем с 1 строки и 1 столбца
  j:=1;
  direct:=1;//идем вправо с начала 
  old:=1;//пред-ее число 
  very_old:=0;//предпред-ее число
  while (mtx[i,j]=0) do//пока ячейка пуста
  begin
    if (i=1) and (j=1) then//если это начало забиваем туда 1 без изменения чисел для фибоначи
      mtx[1,1]:=1
    else
    begin//забиваем число фибоначи, изменяем предыдущее на это, а предпредыдущее на пред-ее
      nnew:=old+very_old;
      mtx[i,j]:=nnew;
      very_old:=old;
      old:=nnew;
    end;
    if direct=1 then//если идем вправо
    begin
      if mtx[i,j+1]=0 then//если есть куда идти то переходим, иначе надо идти вниз
        j:=j+1
      else direct:=3;
    end;
    if direct=3 then//если идем вниз
    begin
      if mtx[i+1,j]=0 then//если есть куда идти то переходим, иначе надо идти влево
        i:=i+1
      else direct:=2;
    end;
    if direct=2 then//если идем влево
    begin
      if mtx[i,j-1]=0 then//если есть куда идти то переходим, иначе надо идти вверх
        j:=j-1
      else direct:=4;
    end;
    if direct=4 then//если идем ввверх
    begin
      if mtx[i-1,j]=0 then//если есть куда идти то переходим, иначе надо идти вправо
        i:=i-1
      else 
      begin
        direct:=1;
        if mtx[i,j+1]=0 then//если мы сразу шли вниз, то проверим есть ли путь вправо.
          j:=j+1
      end;
    end;
  end;
end;

procedure Output(mtx:matrix);//вывод матрицы
var
  i,j,k:integer;
  num:string;
begin
  for i:=1 to N do
  begin
    for j:=1 to M do
    begin
      str(mtx[i,j],num);//переводим число в строку, чтобы узнать кол-во цифр
      write(mtx[i,j]);//печатаем число
      for k:=1 to (LEN-length(num)) do//печатаем пробелы, чтобы длина стала LEN
        write(' ');
    end;  
    writeln;
  end;
end;
    
var
  mtx:matrix;//матрица

begin
  Filing(mtx);//заполнение матрицы
  Output(mtx);//вывод матрицы
end.