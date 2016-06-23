                                        {����� �������}
{��������� ������� ��� ������������ ��������� ����� �����}
type
  Tten=0..10;//��� ��� ����
  Tbig=string;//��� ��������� �����

procedure Input(var num,num_wihtout_changes:tbig);//���� �����
begin
  writeln('Enter number without spaces:');
  read(num);
  num_wihtout_changes:=num;//� ���������� ����� ����� ���������� � ��������. ��� ������ ������� ��� �������������� ��� � ��������� ����������
  if length(num) mod 3<> 0 then//�� ����� ������������ �� 3 �������, ������� ���� ���-�� �������� �� ������ ����, ������� � ������ �����
  begin
    if length(num) mod 3=1 then
      num:='00'+num
    else
      num:='0'+num;
  end;
end;

procedure Output(Num_in_words,num_wihtout_changes:string;lbl:boolean);//�����
begin
  if lbl then//����� ���������� ������� ������ �����
    writeln('Incorrect Input. Error!!!')
  else
  begin
    writeln(num_wihtout_changes,' is read in Russian as');
    writeln(Num_in_words);
  end;
end;

function Translation_of_3(num:integer;var code:Tten):string;//������� � ������ ������������ �����
var
  num_hun,num_ten,num_one:Tten;//����� �����, ����� ��������, ����� ������
  Num_in_words:string;
begin
  Num_in_words:='';
  num_one:=num mod 10;
  num_ten:=(num div 10) mod 10;
  num_hun:=num div 100;
  case num_hun of
    1:Num_in_words:=Num_in_words+'��� ';
    2:Num_in_words:=Num_in_words+'������ ';
    3:Num_in_words:=Num_in_words+'������ ';
    4:Num_in_words:=Num_in_words+'��������� ';
    5:Num_in_words:=Num_in_words+'������� ';
    6:Num_in_words:=Num_in_words+'�������� ';
    7:Num_in_words:=Num_in_words+'������� ';
    8:Num_in_words:=Num_in_words+'��������� ';
    9:Num_in_words:=Num_in_words+'��������� ';
  end;
  if num_ten=1 then
  begin
    case num_one of
      0:Num_in_words:=Num_in_words+'������ ';
      1:Num_in_words:=Num_in_words+'����������� ';
      2:Num_in_words:=Num_in_words+'���������� ';
      3:Num_in_words:=Num_in_words+'���������� ';
      4:Num_in_words:=Num_in_words+'������������ ';
      5:Num_in_words:=Num_in_words+'���������� ';
      6:Num_in_words:=Num_in_words+'����������� ';
      7:Num_in_words:=Num_in_words+'���������� ';
      8:Num_in_words:=Num_in_words+'������������ ';
      9:Num_in_words:=Num_in_words+'������������ ';
    end;
  end
  else
  begin
    case num_ten of
      2:Num_in_words:=Num_in_words+'�������� ';
      3:Num_in_words:=Num_in_words+'�������� ';
      4:Num_in_words:=Num_in_words+'����� ';
      5:Num_in_words:=Num_in_words+'��������� ';
      6:Num_in_words:=Num_in_words+'���������� ';
      7:Num_in_words:=Num_in_words+'��������� ';
      8:Num_in_words:=Num_in_words+'����������� ';
      9:Num_in_words:=Num_in_words+'��������� ';
    end;
    case num_one of
      1:Num_in_words:=Num_in_words+'���� ';
      2:Num_in_words:=Num_in_words+'��� ';
      3:Num_in_words:=Num_in_words+'��� ';
      4:Num_in_words:=Num_in_words+'������ ';
      5:Num_in_words:=Num_in_words+'���� ';
      6:Num_in_words:=Num_in_words+'����� ';
      7:Num_in_words:=Num_in_words+'���� ';
      8:Num_in_words:=Num_in_words+'������ ';
      9:Num_in_words:=Num_in_words+'������ ';
    end;
  end;
  if num_ten=1 then//� ���������� ��� �������� ��������� ����� ��� 10,���� ����� ���� � 10-19, ����� ������ ���������
    code:=10
  else
    code:=num_one;
  Translation_of_3:=Num_in_words;
end;
  
function Power(i:tten):string;//��� ������� ��������,����� ���������, �� �������������� �������� ��� tten
begin
   case i of
  1:power:='�������';
  2:power:='��������';
  3:power:='��������';
  4:power:='�����������';
  5:power:='�����������';
  6:power:='�����������';
  7:power:='����������';
  8:power:='���������';
  9:power:='���������';
  10:power:='���������';
  end;
end;

function MainTranslation(num:tbig;var lbl:boolean):string;//�������� �������
var
  real_num,ercode:integer;//� ��� ���������� �������� ������������ � ����� ������, ercode ��� ������ val
  num_in_words,Main_Num_in_words:string;//���������� ��� �������� �������������� ����������
  code,i:tten;
begin
  lbl:=false;//���� ������ ���
  val(copy(num,1,length(num)),real_num,ercode);
  if (ercode=0) and (real_num=0) then
    Main_Num_in_words:='����'
  else
  begin
    val(copy(num,length(num)-2,3),real_num,ercode);//��������� ��������� 3 ������� � ������ 
    if ercode<>0 then
      lbl:=true;//���� ����� �� �����, �� ������
    Main_Num_in_words:=Translation_of_3(real_num,code);//��������� ��� ��� �� ������
    delete(num,length(num)-2,3);//���������� ��� ��������
    if length(num)>0 then//���� ����� �� ������ ������
    begin
      val(copy(num,length(num)-2,3),real_num,ercode);//����� ����� ����� 
      if ercode<>0 then//����� ������
        lbl:=true; 
      begin
        Num_in_words:=Translation_of_3(real_num,code);//��������� ������
        case code of//������ ��������� � ����������� �� ������
          1: Num_in_words:=copy(Num_in_words,1,length(Num_in_words)-3)+'�� ������ ';
          2: Num_in_words:=copy(Num_in_words,1,length(Num_in_words)-2)+'� ������ ';
          3,4:Num_in_words:=Num_in_words+'������ ';
        else Num_in_words:=Num_in_words+'����� ';
        end;
        if real_num<>0 then//��������� ������ ������ ���� �� 0 �����
          Main_Num_in_words:=Num_in_words+Main_Num_in_words;
        delete(num,length(num)-2,3);
        i:=1;
        while length(num)>0 do//��������� �������� ��� ��������,��������� � �.�.
        begin
          val(copy(num,length(num)-2,3),real_num,ercode);//����� ������ 
          if ercode<>0 then//����� ������
            lbl:=true;
          Num_in_words:=Translation_of_3(real_num,code);//��������� �����
          case code of
            1: Num_in_words:=Num_in_words+power(i)+' ';
            2,3,4: Num_in_words:=Num_in_words+power(i)+'� ';
            else Num_in_words:=Num_in_words+power(i)+'�� ';
          end;
          if real_num<>0 then//���� ������ �� �����������
            Main_Num_in_words:=Num_in_words+Main_Num_in_words;
          i:=i+1;//����������� ������
          delete(num,length(num)-2,3);//������� ��������� 3 �����
        end;
      end;
    end;
  end;
  MainTranslation:=Main_num_in_words;//������� �������
end;

var
  num:tbig;//�����
  Num_in_words,num_wihtout_changes:string;//��� ���������
  lbl:boolean;

begin
  Input(num,num_wihtout_changes);//����
  Num_in_words:=MainTranslation(num,lbl);//�������
  Output(Num_in_words,num_wihtout_changes,lbl);//�����
end.