                       {ВНЕШНЯЯ СОРТИРОВКА}
{Cортирунт числа из файла, храня в памяти только N чисел}
const
  N=84;//количество чисел, вмещающихся в оперативку
  
type
  Tarr=array[1..N] of integer;//масиив


procedure sort(k:integer;var a:tarr);//пузырьковая сортировка массива в оперативке
var
  i,j,r:integer;
begin
  for i:=k downto 2 do
    for j:=2 to i do
      if a[j]<a[j-1] then
      begin
        r:=a[j];
        a[j]:=a[j-1];
        a[j-1]:=r;
      end;
end;



procedure Create_Start_files(var j:int64);//разбиение входного файла на кучу новых типизированных по n чисел в каждом
var
  input:text;//входной файл
  f:file of integer;//для выходных файлов
  strin,name:string;
  c:char;
  num,i,ercode:integer;
  arr:tarr;
  k:integer;//счетчик элемента в массиве
begin
  assign(input,'input.txt');//связка файлов
  append(input);//добавляем в файл пробел, дабы не переписывть код
  write(input,' ');
  close(input);
  reset(input);//открываем файл на чтение
  j:=1;//номер создаваемого файла и его имя
  k:=1;//счетчик номера в массиве
  strin:='';//обнуляем строку с числом
  while not EoF(input) do
  begin
    read(input,c);//считываем символ
    if (c<>' ') and (ord(c)<>13) then//до пробела или ентера
      strin:=strin+c
    else//число записано
    begin
      val(strin,num,ercode);//переводим в число
      if ercode=0 then
      begin//добавляем в массив
        arr[k]:=num;
        k:=k+1;
      end;
      strin:='';  
    end;
    if k=N+1 then//массив сформирован
    begin
      sort(N,arr);//сортируем
      str(j,name);
      name:=name+'.txt';
      assign(f,name);
      rewrite(f);//пихаем в файл
      for i:=1 to k-1 do
        write(f,arr[i]);
      close(f);
      j:=j+1;
      k:=1;
    end;
  end;
  close(input);
  if k<>1 then //если остался неполный массив
  begin
  //остатки массива
    sort(k-1,arr);
    str(j,name);
    name:=name+'.txt';
    assign(f,name);
    rewrite(f);
    for i:=1 to k-1 do
      write(f,arr[i]);
      close(f);
  end
  else
    j:=j-1;
end;


{Слияние 2х файлов в один}
procedure merg(name1,name2,newname:string);//имена сливаемых файлов и нового
var
  flag:byte;
  num1,num2:integer;
  f1,f2,newfile:file of integer;
  ex:boolean;
begin
  assign(f1,name1);//1й
  assign(f2,name2);//2й
  assign(newfile,newname);//новый
  reset(f1);
  reset(f2);
  rewrite(newfile);
  read(f1,num1);//считываем первое число
  flag:=2;//показывает из какого файла считывать внутри цикла
  ex:=false;//условие выхода(конец 1 из файлов и запись последнего файла)
  while not ex do//пока не дошли до конца одного из файлов
  begin
    if flag=2 then//считываем след число
      read(f2,num2)
    else
      read(f1,num1);
    if num1<num2 then//записываем в файл меньшее число и сдвигаемся
    begin
      write(newfile,num1);
      flag:=1;
      if eof(f1) then//проверяем, не пора ли заканчивать
        ex:=true;
    end
    else
    begin
      write(newfile,num2);
      flag:=2;
      if eof(f2) then
        ex:=true;
    end;
  end;
  if not eof(f1) or not eof(f2) then//если 1 из файлов не закончился
  begin
    if eof(f1) then//если закончился f1
    begin
      write(newfile,num2);
      while not eof(f2) do//записываем остатки f2
      begin
        read(f2,num2);
        write(newfile,num2);
      end;
    end
    else//если закончился f2 поступаем аналогично
    begin
      write(newfile,num1);
      while not eof(f1) do
      begin
        read(f1,num1);
        write(newfile,num1);
      end;
    end;
  end
  else//если оба файла закончились, значит остался 1 член
    if num1>num2 then
      write(newfile,num1)
    else
      write(newfile,num2);
  close(newfile);
  close(f1);
  close(f2);
  erase(f1);
  erase(f2);
end;


procedure create_last_file(amount:int64; var lastf:string);//создание главного файла
var
  j:integer;//счетчик файла
  strin,newf,r:string;//показывает название для создаваемого файла
begin
  j:=3;
  merg('1.txt','2.txt','a.txt');//сливаем 2 первых файла
  lastf:='a.txt';
  newf:='b.txt';
  while j<=amount do//сливаем все по порядку, формируя главный
  begin
    str(j,strin);
    strin:=strin+'.txt';
    merg(strin,lastf,newf);
    r:=lastf;
    lastf:=newf;
    newf:=r;
    j:=j+1;
  end;
end;
    
    
procedure create_output(name:string); //перевод типизированного файла в текстовый
var
  f:file of integer;
  output:text;
  num:integer;
begin
  assign(f,name);
  assign(output,'output.txt');
  reset(f);
  rewrite(output);
  while not eof(f) do
  begin
    read(f,num);
    writeln(output,num);
  end;
  close(f);
  erase(f);
  close(output);
end;
  
      
       


  
var
  amount:int64;
  name:string;
  
begin
  Create_Start_files(amount);//разбиваем исходный файл
  if amount=1 then//если количество цифр меньше данных в оперативке т.е разбиение было на 1 файл
    name:='1.txt'
  else
    create_last_file(amount,name);//создаем упорядоченный файл
  create_output(name);//создаем итоговый файл
end.