{���������, ��������� ����� �� K �� N c ����� S � ������� ����� � ����������}
const 
    K=1;  {������}
    N=10; {�����}
    S=1;  {���}
var i:integer;  
begin
    for i:=0 to (N-K) div S do
    write(K+i*S);
end.