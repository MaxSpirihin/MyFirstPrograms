                         {����� �������� �� �������}
{�����, ������� �������� ������ N*M �� ������� �� ������� ������� ������� �������� �� �������}
const
  N=7;//���-�� �����
  M=7;//���-�� ��������
  LEN=12;//����� �������� ��� ���������� �������
  
type
  matrix=array[0..N+1,0..M+1] of int64;//�������
  direction=byte;//����������� ����(1-right, 2-left, 3-down, 4-up)
  
procedure filing(var mtx:matrix);//���������� �������
var
  i,j:integer;//������ ������ � �������
  nnew,old,very_old:int64;//���������� ��� �������� ����� ��������
  direct:direction;//�����������
begin
  for i:=0 to N+1 do//�������� ������� ���������, ������� ������ ������ � ������� � ������ �������
    for j:=0 to M+1 do
      mtx[i,j]:=1;
  for i:=1 to N do//�������� ������ ����� ������� ������
    for j:=1 to M do
      mtx[i,j]:=0;
  i:=1;//�������� � 1 ������ � 1 �������
  j:=1;
  direct:=1;//���� ������ � ������ 
  old:=1;//����-�� ����� 
  very_old:=0;//��������-�� �����
  while (mtx[i,j]=0) do//���� ������ �����
  begin
    if (i=1) and (j=1) then//���� ��� ������ �������� ���� 1 ��� ��������� ����� ��� ��������
      mtx[1,1]:=1
    else
    begin//�������� ����� ��������, �������� ���������� �� ���, � �������������� �� ����-��
      nnew:=old+very_old;
      mtx[i,j]:=nnew;
      very_old:=old;
      old:=nnew;
    end;
    if direct=1 then//���� ���� ������
    begin
      if mtx[i,j+1]=0 then//���� ���� ���� ���� �� ���������, ����� ���� ���� ����
        j:=j+1
      else direct:=3;
    end;
    if direct=3 then//���� ���� ����
    begin
      if mtx[i+1,j]=0 then//���� ���� ���� ���� �� ���������, ����� ���� ���� �����
        i:=i+1
      else direct:=2;
    end;
    if direct=2 then//���� ���� �����
    begin
      if mtx[i,j-1]=0 then//���� ���� ���� ���� �� ���������, ����� ���� ���� �����
        j:=j-1
      else direct:=4;
    end;
    if direct=4 then//���� ���� ������
    begin
      if mtx[i-1,j]=0 then//���� ���� ���� ���� �� ���������, ����� ���� ���� ������
        i:=i-1
      else 
      begin
        direct:=1;
        if mtx[i,j+1]=0 then//���� �� ����� ��� ����, �� �������� ���� �� ���� ������.
          j:=j+1
      end;
    end;
  end;
end;

procedure Output(mtx:matrix);//����� �������
var
  i,j,k:integer;
  num:string;
begin
  for i:=1 to N do
  begin
    for j:=1 to M do
    begin
      str(mtx[i,j],num);//��������� ����� � ������, ����� ������ ���-�� ����
      write(mtx[i,j]);//�������� �����
      for k:=1 to (LEN-length(num)) do//�������� �������, ����� ����� ����� LEN
        write(' ');
    end;  
    writeln;
  end;
end;
    
var
  mtx:matrix;//�������

begin
  Filing(mtx);//���������� �������
  Output(mtx);//����� �������
end.