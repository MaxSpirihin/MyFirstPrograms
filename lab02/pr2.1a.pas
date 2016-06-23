{Программа, выводящая числа от K до N c шагом S с помощью цикла с параметром}
const 
    K=1;  {начало}
    N=10; {конец}
    S=1;  {шаг}
var i:integer;  
begin
    for i:=0 to (N-K) div S do
    write(K+i*S);
end.