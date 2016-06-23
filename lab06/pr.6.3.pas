                           {������������ � �������� �������}
{����� ������� ������������ ��������� ������� � ������� �������� �� �������}
const
  N=3;//���� �������

type
  matrix=array[1..N,1..N] of real;//�������� �������
  arr=array[1..N] of boolean;//������ ��� ��������� ���� � ���, ��������� �� �������

function determinant(mtx:matrix;i:integer;j:arr):real;//���������� ������������
var
  a1,a2,a3,a4:real;//��� ������� �������
  k,m:integer;//��������
  deter:real;
begin
  if (N-i)=2 then//���� �������� ������� �������
    begin
      k:=1;
      while not j[k] do
        k:=k+1;
      a1:=mtx[i+1,k];//���� mtx[1,1] ��� �������� �������
      k:=k+1;
      while not j[k] do
        k:=k+1;
      a2:=mtx[i+1,k];//���� mtx[1,2] ��� �������� �������
      k:=1;
      while not j[k] do
        k:=k+1;
      a3:=mtx[i+2,k];//���� mtx[2,1] ��� �������� �������
      k:=k+1;
      while not j[k] do
        k:=k+1;
      a4:=mtx[i+2,k];//���� mtx[2,2] ��� �������� �������
      Deter:=a1*a4-a2*a3;//��������� ������������
    end
  else//���� ������� �� �������
    begin
      i:=i+1;//��������� �� ���� ������
      Deter:=0;
      m:=1;//������� �������
      for k:=1 to N do//���������� �� ���� ��������
        if j[k] then//���� ������� �� �������
        begin
          if (m mod 2)=1 then//���� �������� ������� ����� � ������
          begin
            j[k]:=false;//����������� ������� �������
            Deter:=Deter+mtx[i,k]*Determinant(mtx,i,j);//����������� �����
            j[k]:=true//���������� ��������� �������
          end
          else//���� ������ ������� ����� � �������
          begin
            j[k]:=false;//����������� ������� �������
            Deter:=Deter-mtx[i,k]*Determinant(mtx,i,j);//����������� �����
            j[k]:=true;//���������� ��������� �������
          end;
          m:=m+1;//������� ���� ���������
        end;
    end;
  Determinant:=Deter;
end;



procedure Input(var mtx:matrix);//���� �������
var
  i,j:integer;
begin
  for i:=1 to N do
  begin
    writeln('Enter ',i,' string');
    for j:=1 to N do
      read(mtx[i,j]);
  end;
end;  

procedure Output(Det:real;mtx:matrix);//����
var
  i,j:integer;
begin  
  writeln('Determinant is ',det);
  if det=0 then
    writeln('Reverse matrix is not defined')
  else
  begin
    writeln('Reverse matrix:');
    for i:=1 to N do
    begin
      for j:=1 to N do
        write(mtx[i,j]:5:3,' ');
      writeln;
    end;
  end;
end;

function reverse(mtx:matrix):matrix;//�-� ������������ �������, �������� ������
var
  main_mtx,rev_mtx:matrix;//������������� �������
  i,k,p:integer;//�������� ������
  det:real;//������������ �������� �������
  j:arr;//������ ������� ��� ��� �����
  extra_arr:array[1..N] of real;//�������������� ������ ��� �������� ������
begin
  main_mtx:=mtx;//������ ��������� ��� ������� � ���������
  for i:=1 to N do//���� ��� ������� ������
    j[i]:=true;
  det:=determinant(mtx,0,j);//������� ������������ �������� �������
  for i:=1 to N do//��� ���� �����
  begin
    for k:=1 to N do//�������� ������ � �������� ������
      extra_arr[k]:=mtx[i,k];
    for p:=i downto 2 do//�������� ������ ����
    begin
      for k:=1 to N do
        mtx[p,k]:=mtx[p-1,k];
    end;
    for k:=1 to N do//������ ������ �������� �� ���������
      mtx[1,k]:=extra_arr[k];
    for k:=1 to N do//��� ������� ������
      j[k]:=true;
    for k:=1 to N do
    begin
      j[k]:=false;
      rev_mtx[i,k]:=determinant(mtx,1,j);//������ ������� �������
      j[k]:=true;
    end;
    mtx:=main_mtx;//�� �������� �������, ��� ��� ������ �� ��������� ��������
  end;
  //������� ������� ���������
  for i:=1 to N do
    for k:=1 to N do
      if (i+k) mod 2<>0 then 
        rev_mtx[i,k]:=-rev_mtx[i,k];
  //��� ���� ���� �������
  for i:=1 to N do
    for k:=1 to N do 
      mtx[i,k]:=rev_mtx[k,i]/det;   
  //������� ����������������� ������� ���. ���������� �������� �� ������������� �.� ��������
  reverse:=mtx;//������
end;  
  
var
  mtx,rev_mtx:matrix;//������� � �������� �������
  i:integer;//������������ � �������
  j:arr;//������ �����.����������, ������������ ��������� �� ������ �������
  det:real;

begin
  Input(mtx);//����
  for i:=1 to N do//���� �� ���� ������� �� ���������
    j[i]:=true;
  Det:=Determinant(mtx,0,j);//���� ������������
  
  if det=0 then
  begin
    writeln('Determinant is ',det);
    writeln('Reverse matrix is not defined')
  end
  else
  begin
    rev_mtx:=reverse(mtx);//���� �������� �������
    Output(Det,rev_mtx);//������� ����
  end;
end.