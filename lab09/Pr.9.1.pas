                       {������� ����������}
{C�������� ����� �� �����, ����� � ������ ������ N �����}
const
  N=84;//���������� �����, ����������� � ����������
  
type
  Tarr=array[1..N] of integer;//������


procedure sort(k:integer;var a:tarr);//����������� ���������� ������� � ����������
var
  i,j,r:integer;
begin
  for i:=k downto 2 do
    for j:=2 to i do
      if a[j]<a[j-1] then
      begin
        r:=a[j];
        a[j]:=a[j-1];
        a[j-1]:=r;
      end;
end;



procedure Create_Start_files(var j:int64);//��������� �������� ����� �� ���� ����� �������������� �� n ����� � ������
var
  input:text;//������� ����
  f:file of integer;//��� �������� ������
  strin,name:string;
  c:char;
  num,i,ercode:integer;
  arr:tarr;
  k:integer;//������� �������� � �������
begin
  assign(input,'input.txt');//������ ������
  append(input);//��������� � ���� ������, ���� �� ����������� ���
  write(input,' ');
  close(input);
  reset(input);//��������� ���� �� ������
  j:=1;//����� ������������ ����� � ��� ���
  k:=1;//������� ������ � �������
  strin:='';//�������� ������ � ������
  while not EoF(input) do
  begin
    read(input,c);//��������� ������
    if (c<>' ') and (ord(c)<>13) then//�� ������� ��� ������
      strin:=strin+c
    else//����� ��������
    begin
      val(strin,num,ercode);//��������� � �����
      if ercode=0 then
      begin//��������� � ������
        arr[k]:=num;
        k:=k+1;
      end;
      strin:='';  
    end;
    if k=N+1 then//������ �����������
    begin
      sort(N,arr);//���������
      str(j,name);
      name:=name+'.txt';
      assign(f,name);
      rewrite(f);//������ � ����
      for i:=1 to k-1 do
        write(f,arr[i]);
      close(f);
      j:=j+1;
      k:=1;
    end;
  end;
  close(input);
  if k<>1 then //���� ������� �������� ������
  begin
  //������� �������
    sort(k-1,arr);
    str(j,name);
    name:=name+'.txt';
    assign(f,name);
    rewrite(f);
    for i:=1 to k-1 do
      write(f,arr[i]);
      close(f);
  end
  else
    j:=j-1;
end;


{������� 2� ������ � ����}
procedure merg(name1,name2,newname:string);//����� ��������� ������ � ������
var
  flag:byte;
  num1,num2:integer;
  f1,f2,newfile:file of integer;
  ex:boolean;
begin
  assign(f1,name1);//1�
  assign(f2,name2);//2�
  assign(newfile,newname);//�����
  reset(f1);
  reset(f2);
  rewrite(newfile);
  read(f1,num1);//��������� ������ �����
  flag:=2;//���������� �� ������ ����� ��������� ������ �����
  ex:=false;//������� ������(����� 1 �� ������ � ������ ���������� �����)
  while not ex do//���� �� ����� �� ����� ������ �� ������
  begin
    if flag=2 then//��������� ���� �����
      read(f2,num2)
    else
      read(f1,num1);
    if num1<num2 then//���������� � ���� ������� ����� � ����������
    begin
      write(newfile,num1);
      flag:=1;
      if eof(f1) then//���������, �� ���� �� �����������
        ex:=true;
    end
    else
    begin
      write(newfile,num2);
      flag:=2;
      if eof(f2) then
        ex:=true;
    end;
  end;
  if not eof(f1) or not eof(f2) then//���� 1 �� ������ �� ����������
  begin
    if eof(f1) then//���� ���������� f1
    begin
      write(newfile,num2);
      while not eof(f2) do//���������� ������� f2
      begin
        read(f2,num2);
        write(newfile,num2);
      end;
    end
    else//���� ���������� f2 ��������� ����������
    begin
      write(newfile,num1);
      while not eof(f1) do
      begin
        read(f1,num1);
        write(newfile,num1);
      end;
    end;
  end
  else//���� ��� ����� �����������, ������ ������� 1 ����
    if num1>num2 then
      write(newfile,num1)
    else
      write(newfile,num2);
  close(newfile);
  close(f1);
  close(f2);
  erase(f1);
  erase(f2);
end;


procedure create_last_file(amount:int64; var lastf:string);//�������� �������� �����
var
  j:integer;//������� �����
  strin,newf,r:string;//���������� �������� ��� ������������ �����
begin
  j:=3;
  merg('1.txt','2.txt','a.txt');//������� 2 ������ �����
  lastf:='a.txt';
  newf:='b.txt';
  while j<=amount do//������� ��� �� �������, �������� �������
  begin
    str(j,strin);
    strin:=strin+'.txt';
    merg(strin,lastf,newf);
    r:=lastf;
    lastf:=newf;
    newf:=r;
    j:=j+1;
  end;
end;
    
    
procedure create_output(name:string); //������� ��������������� ����� � ���������
var
  f:file of integer;
  output:text;
  num:integer;
begin
  assign(f,name);
  assign(output,'output.txt');
  reset(f);
  rewrite(output);
  while not eof(f) do
  begin
    read(f,num);
    writeln(output,num);
  end;
  close(f);
  erase(f);
  close(output);
end;
  
      
       


  
var
  amount:int64;
  name:string;
  
begin
  Create_Start_files(amount);//��������� �������� ����
  if amount=1 then//���� ���������� ���� ������ ������ � ���������� �.� ��������� ���� �� 1 ����
    name:='1.txt'
  else
    create_last_file(amount,name);//������� ������������� ����
  create_output(name);//������� �������� ����
end.