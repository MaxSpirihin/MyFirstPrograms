                                  {ПРЕОБРАЗОВАНИЕ ЧИСЛА}
{в дес-ой записи числа подряд идущие числа заменяются на число и кол-во его повторений. Так N раз}
procedure Enter(var n:integer;var number:string);     {Процедура ввода данных}
begin
  Writeln('Enter amount of operation:');
  readln(n);
  writeln('Enter number:');
  readln(number);
end;

procedure Total(number:string);                        {Процедура вывода данных}
begin
  writeln('Total is ',number);
end;

function Action(number:string):string;                 {Функция, строящая число по правилу}
var
  i,j:integer;//переменные цикла
  act:string;//строящаяся строка(число)
  c,b:string;//вспомогательные переменные
begin
  i:=1;
  act:='';
  while i<=length(number) do
    begin
    c:=copy(number,i,1);//само число
    j:=0;
    while copy(number,i+j,1)=c do//ищем, сколько раз цифра идет подряд
      j:=j+1;
    str(j,b);//мы ведь пользуемся строкой
    act:=act+b+c;
    i:=i+j;//перепрыгиваем до другой цифры в числе
    end;
  action:=act;
end;

var
  n,i:integer;//n показывает сколько раз вызывать функцию, i-переменная цикла
  number:string;//введенное и изменяемое число

begin
  Enter(n,number);//ввод данных
  for i:=1 to n do
    number:=action(number);//выполняем функцию n раз
  Total(number);//смотрим итоги
end.