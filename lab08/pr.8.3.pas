                      {БОЛЬШИЕ НА МАЛЕНЬКИЕ}
{Прога создает файл, куда записывает текст из указанного файла, меняя заглавные буквы на строчные и наоборот}

procedure Redacting(var c:char);//изменение символа
begin
  case c of 
    'A'..'Z':c:=chr(ord(c)+32);
    'a'..'z':c:=chr(ord(c)-32);
    'а'..'я':c:=chr(ord(c)-32);
    'А'..'Я':c:=chr(ord(c)+32);
  end;
end;

procedure Input(var name:string);//ввод
begin
  writeln('Enter name of file');
  readln(name);
end;


procedure Action(Filename:string);//действие
var
  f,f2:text;//файл для чтения и вывода
  c:char;//считываемый символ
begin
  if not FileExists(FileName) then//если файла нет, то может расширение забыл указать
    FileName:=FileName+'.txt';
  if FileExists(FileName) then//если файл есть
  begin
    assign(f,FileName);
    assign(f2,'Total.txt');
    reset(f);
    rewrite(f2);
    while not EoF(f) do
    begin
      read(f,c);//считываем символ
      redacting(c);//изменяем
      write(f2,c);//пишем во 2й файл
    end;//пока не конец файла
    writeln('Complete!!!');
    close(f);//закрываем
    close(f2);
  end
  else
    writeln('File is not'); 
end;


var
  Filename:string;
begin
  input(FileName);//ввод
  Action(FileName);//действие
end.