{РЕШЕНИЕ КВАДРАТНОГО УРАВНЕНИЯ}
{Данная программа предназначена для нахождения корней квадратного уравнения}
program SolveSqrEqual;

const
  INF_ROOTS=3;                                                                   {Константа, определяющая количество корней, если их бесконечно}
  TEST=1;                                                                        {Идентификатор запуска теста. 1 для запуска теста}
 
procedure InputVars (var a,b,c:real);                                            {процедура ввода коэффициентов уравнения}
begin
  writeln('Quadratic equation of the form ax^2+bx+c');
  writeln('Enter a');
  readln(a);
  writeln('Enter b');
  readln(b);
  writeln('Enter c');
  readln(c);
end;

procedure showroots(nroots:byte; x1,x2:real);                                    {Процедура вывода корней и инф-ии об их кол-ве}
begin
  case nroots of                                                                 {В зависимости от кол-ва корней, вывод различен}
    0:writeln('No solution');
    1:writeln('single solution x=',x1:7:5);
    2:writeln('Two solution x1=',x1:7:5,', x2=',x2:8:5);
    INF_ROOTS:writeln('x belongs R');
  else
    writeln('Error');                                                            {Значение кол-ва корней должно быть 0,1,2,INF_ROOTS}
  end;
end;

function SolveSqrEq(a,b,c:real; var x1,x2:real):byte;                            {Функция, возвращающая кол-во корней уравнения, а также записывающая в х1 и х2 значения корней уравнения}
var 
  D:real;                                                                        {Дискриминант}
  r:byte;                                                                        {Кол-во корней}
begin
  if 0=a then                                                                    {Если уравнение линейное}
    begin
    if 0=b then                                                                      {Если уравнение вида 0*х=-c}
      begin 
      if 0=c then                                                                         {0*x=0  x-любое}
        r:=INF_ROOTS
      else                                                                                {0*x<>0 корней нет}
        r:=0;                         
      end
    else                                                                             {Если b*x=-c, b<>0, 1 корень x=-c/b}                                                        
      begin
      x1:=-c/b;
      r:=1;
      end;
    end
  else                                                                            {Если уравнение квадратное}
    begin
    D:=sqr(b)-4*a*c;                                                              {Вычисляем дискриминант}                                       
    if 0>D then                                                                   {Если дискриминант отрицателен, корней нет}
      r:=0
    else
      begin
      if 0=D then                                                                 {Если дискриминант равен нулю, то 1 решение x=-b/(2*a)}
        begin
        x1:=-b/(2*a);
        r:=1;
        end
      else                                                                        {Если дискриминант положителен, то 2 решения. Вычисляем их по формуле}
        begin
        r:=2;
        x1:=(-b-sqrt(D))/(2*a);
        x2:=(-b+sqrt(D))/(2*a);
        end;
      end;
    end;
  SolveSqrEq:=r;                                                                  {Кол-во корней r должна возвращать функция}
end;

procedure Realtest(var x1,x2:real; nroots:byte);                                  {Процедура, тестирующая каждый блок программы и говорящая, верно ли она работает}
var
  flag:boolean;
begin
  flag:=true;
  nroots:=SolveSqrEq(0,0,0,x1,x2);
  if nroots<>INF_ROOTS then 
    flag:=false;
  nroots:=SolveSqrEq(0,0,1,x1,x2);
  if nroots<>0 then 
    flag:=false;
  nroots:=SolveSqrEq(0,1,1,x1,x2);
  if (x1<>-1) or (nroots<>1) then 
    flag:=false;
  nroots:=SolveSqrEq(1,1,20,x1,x2);
  if nroots<>0 then 
    flag:=false;
  nroots:=SolveSqrEq(1,2,1,x1,x2);
  if (x1<>-1) or (nroots<>1) then 
    flag:=false;
  nroots:=SolveSqrEq(1,-5,4,x1,x2);
  if (x1<>1) or (nroots<>2) or (x2<>4) 
    then flag:=false;
  if flag then
    writeln('Test is passed')
  else
    writeln('Test is not passed')
end;
  
var 
  a,b,c:real;                                                                    {коэффициенты уранения}
  x1,x2:real;                                                                    {корни}
  nroots,test_test:byte;                                                         {кол-во корней,идентификатор запуска теста}
begin
  test_test:=TEST;
  if test_test=1 then
    RealTest(x1,x2,nroots)
  else
    begin
    InputVars(a,b,c);                                                            {Ввод коэффициэнтов a,b,c}
    nroots:=SolveSqrEq(a,b,c,x1,x2);                                             {Нахождение корней уравнения}
    showroots(nroots,x1,x2);                                                     {Вывод корней}
    end;
end.