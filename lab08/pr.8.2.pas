                 {СОРТИРОВКА СТРОК}
{Прога, которая создает файл, где строки из введенного файла в алфавитном поряке}
const
  N=100;                 
                 
type
  strings=array[1..N] of string; //массив из строк
  
  
procedure Sort(var str:strings;n:integer);//сортировка массива пузырьком
var
  k,j:integer;
  str1:string;
begin
  for k:=n downto 1 do
    for j:=1 to k-1 do
      if str[j]>str[j+1] then
      begin
        str1:=str[j];
        str[j]:=str[j+1];
        str[j+1]:=str1
      end;
end;
      
      
procedure Input(var name:string);//ввод
begin
  writeln('Enter name of file');
  readln(name);
end;


var
  f,f2:text;//файл
  str:strings;//имя файла
  filename:string;
  i,k:integer;
begin
  input(FileName);
  if not FileExists(FileName) then//если файла нет, то может расширение забыл указать
    FileName:=FileName+'.txt';
  if FileExists(FileName) then//если файл есть
  begin
    assign(f,FileName); 
    assign(f2,'Total.txt');
    reset(f);//открвывем введенный файл
    i:=1;
    while not EoF(f) do//считываем строки
    begin
      readln(f,str[i]);
      i:=i+1;
    end;
    close(f);//закрываем файл
    i:=i-1;//узнаем колво строк
    Sort(str,i);//сортируем
    rewrite(f2);//создаем total
    for k:=1 to i do//вбиваем строки
      writeln(f2,str[k]); 
    close(f2);//закрыавем
    writeln('Complete!!!');
  end
  else
    writeln('File is not');  
end.