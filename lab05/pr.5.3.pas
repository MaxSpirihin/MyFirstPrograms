{��������� ����������� ������� �����. ���������� �� �������� ��� ��������� ���-�� �����}
type
 TMyType=integer;

var
  number:string;//����� � ���� ������
  c:string[1];//1 ������, ������� �� ����� ��������� �� ������
  str:string;//��������� ������
  cp:integer;//������� �������� � ������
  real_number:TMyType;//�����
  ercode:integer;//��� ������ ��� val
  n:integer;//���������� ����� � ������������������
  sum,sum_sq:TMyType;//����� ��������� � ����� ��������� ���������
  x,i:integer;//�������� ����� � ������� �����
  total:real;//���������

begin
  Writeln('enter sequence:');
  readln(str);//��������� ������
  str:=str+' ';//������� ������ ��� ���������� ������ ����
  sum:=0;
  Sum_sq:=0;
  cp:=1;
  n:=0;
  while cp<=length(str) do//���� �� �� ����� �� ����� ������
    begin
    c:=copy(str,cp,1);//��������� ������ � �������� cp �� ������
    if c<>' ' then//���� � �� ������ ���������� ����������
      number:=number+c
    else//����� ������������
      begin
      val(number,real_number,ercode);//��������� �����-������ � �����
      if ercode=0 then //���� ��� ���� (�������� ������ � 2�� ��������� ������)
        begin
        sum:=sum+real_number;//���� �����
        sum_sq:=sum_sq+sqr(real_number);//���� ����� ���������
        n:=n+1;//���� ����� ���������
        end;
      number:='';//�������� ���������� ����-������ ��� ������ ����������
      end;
    cp:=cp+1;
    end;
  total:=(sum_sq-(2*sum*sum/N)+sum*sum/n)/n;//������� ������� � �������� ������� ��� ������� �������� � ������� ��� �������
  writeln('total:',total);
end.
    
    