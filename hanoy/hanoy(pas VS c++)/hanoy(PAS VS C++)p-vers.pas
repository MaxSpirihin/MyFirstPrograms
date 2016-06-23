                                      {ХАНОЙСКИЕ БАШНИ}
{
План разработки:
  1.Функция создания массивов(башен)
  2.Функция вывода их на экран в виде башен
  3.Функция перекладывания адного диска на другой
  4.Основная рекурсивная функция
}

const
  MAX=50;//максимальное число башен
type
  Ttower=array[0..MAX] of integer;//башня
  Ttowers=array[1..3] of Ttower;//3 башни
  
procedure Input(var a:Ttowers;n:integer);//Функция создания массивов(башен)
var
  i,k:integer;//счетчики
  strin:string;
begin
  for i:=1 to MAX do//инициализируем башни как пустые
  begin
    a[1][i]:=0;
    a[2][i]:=0;
    a[3][i]:=0;
  end;
  k:=1;
  for i:=n downto 1 do//заполняем первую башню
  begin
    a[1][k]:=i;
    inc(k);
  end;
end;


procedure Shift(var a:Ttowers;t_from,t_to:integer);//переложение верхнего диска с башни t_from на t_to
var
  i:integer;
  num_to,num_from:integer;//номера крайних дисков
begin
  i:=1;
  while (a[t_from][i]<>0)and(i<>MAX) do
    inc(i);
  num_from:=i-1;//ищем позицию перекладываемого диска
  i:=1;
  while (a[t_to][i]<>0)and(i<>MAX) do
    inc(i);
  num_to:=i;//ищем куда его пичкануть
  a[t_to][num_to]:=a[t_from][num_from];//перекладываем
  a[t_from][num_from]:=0;
end;


procedure Hanoys_Towers(var a:Ttowers; t_from,t_to,t_ext,m,n:integer);//переложение кучи дисков кол-м m с башни t_from на t_to (ОСНОВНАЯ ПРОЦЕДУРА).
var
  i:integer;
begin
  if (m>0) then//выход из рекурсии
  begin
    Hanoys_Towers(a,t_from,t_ext,t_to,m-1,n);//перекладываем кучу без 1 на доп башню
    Shift(a,t_from,t_to);//перекладываем нижний
    Hanoys_Towers(a,t_ext,t_to,t_from,m-1,n);//перекладываем кучу с доп куда надо
  end;
end;


var
  a:Ttowers;//башни
  n,i:integer;//диски
begin
  readln(n);
  Input(a,n);//ввод
  Hanoys_Towers(a,1,2,3,n,n);//игра
  writeln('complete');
end.