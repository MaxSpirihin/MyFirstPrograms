{Программа вычисляющая среднее квадр. отклонение от среднего для введенной пос-ти чисел}
type
 TMyType=integer;

var
  number:string;//число в виде строки
  c:string[1];//1 символ, который мы будем считывать из строки
  str:string;//введенная строка
  cp:integer;//счетчик элемента в строке
  real_number:TMyType;//число
  ercode:integer;//код ошибки для val
  n:integer;//количество чисел в последовательности
  sum,sum_sq:TMyType;//сумма элементов и сумма квадратов элементов
  x,i:integer;//вводимое число и счетчик цикла
  total:real;//результат

begin
  Writeln('enter sequence:');
  readln(str);//считываем строку
  str:=str+' ';//добавим пробел для корректной работы кода
  sum:=0;
  Sum_sq:=0;
  cp:=1;
  n:=0;
  while cp<=length(str) do//пока мы не дошли до конца строки
    begin
    c:=copy(str,cp,1);//считываем символ с индексом cp из строки
    if c<>' ' then//если с не пробел продолжаем считывание
      number:=number+c
    else//число сформировано
      begin
      val(number,real_number,ercode);//переволим число-строку в число
      if ercode=0 then //если все норм (возможен случай с 2мя пробелами подряд)
        begin
        sum:=sum+real_number;//ищем сумму
        sum_sq:=sum_sq+sqr(real_number);//ищем сумму квадратов
        n:=n+1;//ищем колво элементов
        end;
      number:='';//обнуляем переменную чило-строка для записи следующего
      end;
    cp:=cp+1;
    end;
  total:=(sum_sq-(2*sum*sum/N)+sum*sum/n)/n;//раскрыл квадрат в исходной формуле для каждого квадрата и получил эту формулу
  writeln('total:',total);
end.
    
    