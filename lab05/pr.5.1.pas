procedure FindNeightBourghs(str: string);
var
  i, j: integer;//счетчики цикла                           
  wd, oldWd: string;//старое и новое слово
begin
  oldWd := ' ';
  i := 0;
  while i <= length(str) do//прогоняем все символы строки
  begin
    if (i = 0) or (copy(str, i, 1) = ' ') then//ищем пробел
    begin
      j := 1;
      while (copy(str, i + j, 1) <> ' ') and (i + j <= length(str)) do//ищем следующий пробел или конец строки
        j := j + 1;
      //новое слово найдено
      wd := copy(str, i + 1, j - 1);
      //если оноудовлетворяем требованиям, работаем с ним
      if (length(wd) >= 2) and (length(wd) <= 6) then
      begin
        if wd = oldWd then
          writeln(wd);
        oldWd := wd;
      end;
    end;
    i := i + 1; 
  end;
end;


var
  str: string;//строка и макс.палиндром

begin
  writeln('Enter string:');
  readln(str);
  FindNeightBourghs(str);
end.