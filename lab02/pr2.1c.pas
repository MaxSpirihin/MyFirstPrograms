{���������, ��������� ����� �� K �� N c ����� S � ������� ����� � ������������}
const 
    K=1;  {������}
    N=10; {�����}
    S=1;  {���}
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