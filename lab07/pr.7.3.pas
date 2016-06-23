                            {���������� ��������}
{�����, ����������� ������ ��������}
const
  N = 20;

type
  Tarray = array[1..N] of integer;//������


procedure replacement(var a, b: integer);//����� ����������
var
  r: integer;//��� ����������
begin
  r := a;
  a := b;
  b := r;
end;

procedure Input(var arr: tarray; var k: integer);//��������� �����
var
  i: integer;
begin
  writeln('Enter amount of elements');
  readln(k);
  writeln('Enter elements');
  for i := 1 to k do
    read(arr[i]);
end;


procedure output(arr:tarray;k:integer);//����� �������
var 
  i:integer;
begin
  writeln('ordered array is');
  for i:=1 to k do
    write(arr[i],' ' );
end; 



procedure Merg_sort(first,last:integer;var arr:tarray);//���������� ��������
var
  i,j,index1,index2,index:integer;//�������
  b:tarray;//��� ������
begin
  i:=first+(last-first+1) div 2-1;//������ ����� ������ ��������
  j:=i+1;//������ ������ ������ ��������
  if last-first>0 then//���� ���� � ���������� �� 1 �������
  begin//������������� ��� �������� ��� �� ��������
    merg_sort(first,i,arr);
    merg_sort(j,last,arr);
  end;
  if last-first=1 then//���� ��������� �� 2 ��������� ���� ������������� ��
  begin
    if arr[last] < arr[first] then
      replacement(arr[last], arr[first]);
  end 
  else//���� ��-� 3 � ������
  begin
    index1:=first;//������ ������ ��������
    index2:=j;//������ ������ ��������
    index:=first;//������ ������������ ����������
    while (index1<=i) and (index2<=last) do//���� �� ������� �� ������� �������
    begin
      if arr[index1]<arr[index2]then//���� ������� ������� 1 �������� ������ ��� ������, ������� ��� � ���������
      begin
        b[index]:=arr[index1];
        index1:=index1+1;
      end
      else//���� ������� ������� 2 �������� ������ ��� ������, ������� ��� � ���������
      begin
        b[index]:=arr[index2];
        index2:=index2+1;
      end;
      index:=index+1;//����������� ������ ���������� �. �. ������ �������
    end;
    //� ����� �� �������� �������� ��������
    if index1>i then//���� ��� �� ������
    begin
     for index1:=index2 to last do//�������� �� � ���������
      begin
        b[index]:=arr[index1];
        index:=index+1;
      end
    end
    else//���� ��� �� ������
    begin
      for index2:=index1 to i do//�������� �� � ���������
      begin
        b[index]:=arr[index2];
        index:=index+1;
      end;
    end;   
    for index:=first to last do//�������� ������ �������� �� ���������� � ��������
      arr[index]:=b[index];
  end;
end;
  

var
  arr:tarray;
  k:integer;
  

begin
  input(arr,k);//���� �������
  Merg_sort(1,k,arr);//���������
  output(arr,k);//����� �������
end.