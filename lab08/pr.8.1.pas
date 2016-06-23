                 {ВЫВОД СОДЕРЖИМОГО ФАЙЛА}
{Прога, которая выводит в консоль содержимое файла с введенным именем}

procedure Input(var name:string);//ввод
begin
  writeln('Enter name of file');
  readln(name);
end;

procedure Action(f:text;filename:string);//действие
var
  c:char;//символ для считывания
begin
  if not FileExists(FileName) then//если файла нет, то может расширение забыл указать
    FileName:=FileName+'.txt';
  if FileExists(FileName) then//если файл есть
  begin
    assign(f,FileName);//связка
    reset(f);//открытие
    while not EoF(f) do//перевод всего, что в файле
    begin
      read(f,c);
      write(c);
    end;
    close(f);//закрываем
  end
  else//если файла нет
    write('That file is not');
end;

var
  f:text;//файл
  FileName:string;//имя файла
 
begin
  Input(FileName);//считываем имя
  Action(f,filename);
end.