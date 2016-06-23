{Программа, выводящая числа от K до N c шагом S с помощью цикла с постусловием}
const 
    K=1;  {начало}
    N=10; {конец}
    S=1;  {шаг}
var i:integer;
begin
    i:=K;
    repeat 
        begin
        write(i);
        i:=i+S;
        end;
    until i>N;
end.