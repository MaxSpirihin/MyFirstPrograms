                           {ОПРЕДЕЛИТЕЛЬ И ОБРАТНАЯ МАТРИЦА}
{Прога считает определитель введенной матрицы и находит обратную ей матрицу}
const
  N=3;//ранг матрицы

type
  matrix=array[1..N,1..N] of real;//вводимая матрица
  arr=array[1..N] of boolean;//массив для хранинеия инфы о том, вычеркнут ли столбец

function determinant(mtx:matrix;i:integer;j:arr):real;//вычисление определителя
var
  a1,a2,a3,a4:real;//для двойной матрицы
  k,m:integer;//счетчики
  deter:real;
begin
  if (N-i)=2 then//если осталась двойная матрица
    begin
      k:=1;
      while not j[k] do
        k:=k+1;
      a1:=mtx[i+1,k];//ищем mtx[1,1] для условной матрицы
      k:=k+1;
      while not j[k] do
        k:=k+1;
      a2:=mtx[i+1,k];//ищем mtx[1,2] для условной матрицы
      k:=1;
      while not j[k] do
        k:=k+1;
      a3:=mtx[i+2,k];//ищем mtx[2,1] для условной матрицы
      k:=k+1;
      while not j[k] do
        k:=k+1;
      a4:=mtx[i+2,k];//ищем mtx[2,2] для условной матрицы
      Deter:=a1*a4-a2*a3;//вычисляем определитель
    end
  else//если матрица не двойная
    begin
      i:=i+1;//переходим на след строку
      Deter:=0;
      m:=1;//счетчик столбца
      for k:=1 to N do//проходимся по всем столбцам
        if j[k] then//если столбец не выкинут
        begin
          if (m mod 2)=1 then//если нечетный столбец берем с плюсом
          begin
            j[k]:=false;//вычеркиваем текущий столбец
            Deter:=Deter+mtx[i,k]*Determinant(mtx,i,j);//увеличиваем опред
            j[k]:=true//возвращаем выкинутый столбец
          end
          else//если четный столбец берем с минусом
          begin
            j[k]:=false;//вычеркиваем текущий столбец
            Deter:=Deter-mtx[i,k]*Determinant(mtx,i,j);//увеличиваем опред
            j[k]:=true;//возвращаем выкинутый столбец
          end;
          m:=m+1;//столбец стал следующим
        end;
    end;
  Determinant:=Deter;
end;



procedure Input(var mtx:matrix);//ввод матрицы
var
  i,j:integer;
begin
  for i:=1 to N do
  begin
    writeln('Enter ',i,' string');
    for j:=1 to N do
      read(mtx[i,j]);
  end;
end;  

procedure Output(Det:real;mtx:matrix);//итог
var
  i,j:integer;
begin  
  writeln('Determinant is ',det);
  if det=0 then
    writeln('Reverse matrix is not defined')
  else
  begin
    writeln('Reverse matrix:');
    for i:=1 to N do
    begin
      for j:=1 to N do
        write(mtx[i,j]:5:3,' ');
      writeln;
    end;
  end;
end;

function reverse(mtx:matrix):matrix;//ф-я возвращающая матрицу, обратную данной
var
  main_mtx,rev_mtx:matrix;//промежуточные матрицы
  i,k,p:integer;//счетчики циклов
  det:real;//определитель основной матрицы
  j:arr;//массив забитых или нет строк
  extra_arr:array[1..N] of real;//дополнительный массив для вбивания строки
begin
  main_mtx:=mtx;//забьем начальный вид массива в отдельный
  for i:=1 to N do//пока все столбцы забиты
    j[i]:=true;
  det:=determinant(mtx,0,j);//считаем определитель основной матрицы
  for i:=1 to N do//для всех строк
  begin
    for k:=1 to N do//копируем строку в побочный массив
      extra_arr[k]:=mtx[i,k];
    for p:=i downto 2 do//сдвигаем строки вниз
    begin
      for k:=1 to N do
        mtx[p,k]:=mtx[p-1,k];
    end;
    for k:=1 to N do//первую строку забиваем из побочного
      mtx[1,k]:=extra_arr[k];
    for k:=1 to N do//все столбцы забиты
      j[k]:=true;
    for k:=1 to N do
    begin
      j[k]:=false;
      rev_mtx[i,k]:=determinant(mtx,1,j);//строим матрицу миноров
      j[k]:=true;
    end;
    mtx:=main_mtx;//мы изменили матрицу, так что вернем ей начальное значение
  end;
  //матрица миноров построена
  for i:=1 to N do
    for k:=1 to N do
      if (i+k) mod 2<>0 then 
        rev_mtx[i,k]:=-rev_mtx[i,k];
  //где надо знак сменили
  for i:=1 to N do
    for k:=1 to N do 
      mtx[i,k]:=rev_mtx[k,i]/det;   
  //создали транспонированную матрицу алг. дополнений деленную на определиттель т.е обратную
  reverse:=mtx;//готово
end;  
  
var
  mtx,rev_mtx:matrix;//матрица и обратная матрица
  i:integer;//определитель и счетчик
  j:arr;//массив логич.переменных, показывающих вычеркнут ли данный столбец
  det:real;

begin
  Input(mtx);//ввод
  for i:=1 to N do//пока ни один столбец не вычеркнут
    j[i]:=true;
  Det:=Determinant(mtx,0,j);//ищем определитель
  
  if det=0 then
  begin
    writeln('Determinant is ',det);
    writeln('Reverse matrix is not defined')
  end
  else
  begin
    rev_mtx:=reverse(mtx);//ищем обратную матрицу
    Output(Det,rev_mtx);//выводим итог
  end;
end.