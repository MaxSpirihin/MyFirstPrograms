                              {������� ����������}
{�����, ����������� ��������� ������ ������� �����������}
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


procedure qSort(first, last: integer; var arr: tarray);//������� ���������� ������������ ������� � � ��������� ��-� first � �������� last
var
  i, j, k:integer;//�������� 
  center:integer;//�������� ������ � 
  b: tarray;//��� ������
begin
  if last > first then//���� ������� �� ����
  begin
    if last - first = 1 then//���� 2 ��������, �� ���� ������������� �� 
    begin
      if arr[last] < arr[first] then
        replacement(arr[last], arr[first]);
    end
    else//���� 3 � ����� ���������
    begin
      i:=first;//����� ������ ��� �������, ���� ���������� ��������  ������ ������������
      j:=last;//����� ������ ��� �������, ���� ���������� ��������  ������ ������������
      center := arr[first];//����������� ����� ���� ����� ������{����� ��������� ��� � �������� ���}
      for k:=first to last do//��� ���� ��-� ����������
        if arr[k]<>center then//���� ������� �� ����� ������������
        begin
          if arr[k]>center then//���� ��-� ������ �������������
          begin
            b[j]:=arr[k];//��������� ��� � j-� ������ ��� �������
            j:=j-1;//������ ���������(���� � �����)
          end
          else
          begin//���� ��-� ������ �������������
            b[i]:=arr[k];//��������� ��� � i-� ������ ��� �������
            i:=i+1;//������ �����������(���� � ������)
          end;
        end;
      for k:=i to j do//������������� ������ ������ ���� ����� ������������
        b[k]:=center;
      for k:=first to last do//������ ��������� ��������� �������
        arr[k]:=b[k];
      qsort(first,i-1,arr);//��������� ����� �� ������ �����
      qsort(j+1,last,arr);//��������� ������ �� ������ �����
    end;
  end;
end;


procedure output(arr:tarray;k:integer);//����� �������
var 
  i:integer;
begin
  writeln('ordered array is');
  for i:=1 to k do
    write(arr[i],' ' );
end; 


var
  arr: tarray;//������
  k:integer;//���-�� ��-� �������
  i:integer;//�������

begin
  Input(arr, k);//���� �������
  qSort(1, k, arr);//������� ����������
  output(arr,k);//����� �������
end.