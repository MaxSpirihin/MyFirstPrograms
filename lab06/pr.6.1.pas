                                   {ГИСТОГРАММА СИМВОЛОВ СТРОКИ}
{Прога выводиит гистограмму встречаемости символов в введенной строке}
type
  symbol=array[' '..'я'] of byte;//массив, инициализирующийся всеми символами
  
procedure Input(var str:string);//процедура ввода
begin
  writeln('Enter string:');
  readln(str);
end;

procedure Output(table:symbol);//процедура вывода
var
  i:char;
  j:integer;
begin
  for i:=' ' to 'я' do//прогоняем весь массив
  begin
    if table[i]>0 then//если символ был
    begin
      write(i);//выводим символ
      for j:=1 to Table[i] do
      write('*');//выводим столько звезд, сколько раз встречается символ
      writeln;//перепрыгиваем строку
    end;
  end;
end;

procedure Filing(str:string;var table:symbol);//заполнение массива символов
var 
  i:char;
  j:integer;
begin
  for i:=' 'to 'я' do//сначала заполняем нулями
    table[i]:=0;  
  for j:=1 to length(str) do//берем каждый символ и увеличиваем его кол-во в массиве на 1
    table[str[j]]:=table[str[j]]+1;  
end;

var
  str:string;//строка
  table:symbol;//массив, где table[i]=n i-символ n-количество его встречаемости в сторке 

begin
  Input(str);//ввод
  Filing(str,table);//заполнение массива
  Output(table);//вывод
end.