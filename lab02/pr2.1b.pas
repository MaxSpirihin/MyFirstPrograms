{Программа, выводящая числа от K до N c шагом S с помощью цикла с предусловием}
const 
    K=1;  {начало}
    N=10; {конец}
    S=1;  {шаг}
var i:integer;
begin
    i:=K;
    while i<N+1 do
        begin
        write(i);
        i:=i+S;
        end;
end.