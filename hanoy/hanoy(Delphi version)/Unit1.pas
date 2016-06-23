                                    {Hanoys Towers}
{
���� ����������:
  1.������� �������� ��������(�����)
  2.������� ������ �� �� ����� � ���� �����
  3.������� �������������� ������ ����� �� ������
  4.�������� ����������� �������
  5.������� � ������ �����
}
unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Start: TButton; //������ ������-����
    LDisks: TLabel; //������� ���-�� ������
    Lautor: TLabel;
    LSpeed: TLabel;
    Bpause: TButton; //������ �����
    TrackBar1: TTrackBar; //�����
    TrackBar2: TTrackBar; //��������
    Timer1: TTimer;
    procedure FormPaint(Sender: TObject);
    procedure StartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BpauseClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  speed:integer;
  play,pause:boolean;

implementation

{$R *.dfm}
const
  MAX=21;

type
  Ttower=array[0..MAX] of integer;//�����
  Ttowers=array[1..3] of Ttower;//3 �����


procedure Input(var a:Ttowers;n:integer);//������� �������� ��������(�����)
var
  i,k:integer;//��������
begin
  for i:=1 to MAX do//�������������� ����� ��� ������
  begin
    a[1][i]:=0;
    a[2][i]:=0;
    a[3][i]:=0;
  end;
  if (n<MAX) and (n>=1) then
  begin
    k:=1;
    for i:=n downto 1 do//��������� ������ �����
    begin
      a[1][k]:=i;
      inc(k);
    end;
  end;
end;





procedure Delay(dwMilliseconds: Longint);//��������-����������� �� �����(��� �������� �� ����)
 var
   iStart, iStop: DWORD;
 begin
   iStart := GetTickCount;
   repeat
     iStop := GetTickCount;
     Application.ProcessMessages;
   until (iStop - iStart) >= dwMilliseconds;
 end;




procedure Output(a:Ttowers;n:integer);//���������
var
  i:integer;
  h,dif,len:integer;//������ 1 �����, ������� ��������, ������ �������
begin
  Form1.Repaint;
  with form1.Canvas do begin
  //������������ ����� ���
  brush.color:=clskyblue;
  fillrect(bounds(0,529,0,250));
  //������ �����
  brush.Color:=clblack;
  rectangle(bounds(97,50,6,200));
  rectangle(bounds(257,50,6,200));
  rectangle(bounds(417,50,6,200));
  //��������� ���������
  if (n>=3) then
    h:=200 div n
  else
    h:=200 div 3;
  dif:=75 div n;
  //������������ �����
  brush.color:=clred;
  pen.color:=clblack;
  for i:=1 to n do//����� �
  if a[1][i]<>0 then
    begin
      len:=a[1][i]*dif;
      rectangle(bounds(100-len,250-h*i,2*len,h));
    end;
  for i:=1 to n do//����� b
  if a[2][i]<>0 then
    begin
      len:=a[2][i]*dif;
      rectangle(bounds(260-len,250-h*i,2*len,h));
    end;
  for i:=1 to n do//����� c
  if a[3][i]<>0 then
    begin
      len:=a[3][i]*dif;
      rectangle(bounds(420-len,250-h*i,2*len,h));
    end;
  end;

end;



procedure Shift(var a:Ttowers;t_from,t_to:integer);//����������� �������� ����� � ����� t_from �� t_to
var
  i:integer;
  num_to,num_from:integer;//������ ������� ������
begin
  i:=1;
  while (a[t_from][i]<>0)and(i<>MAX) do
    inc(i);
  num_from:=i-1;//���� ������� ���������������� �����
  i:=1;
  while (a[t_to][i]<>0)and(i<>MAX) do
    inc(i);
  num_to:=i;//���� ���� ��� ���������
  a[t_to][num_to]:=a[t_from][num_from];//�������������
  a[t_from][num_from]:=0;
end;



procedure Hanoys_Towers(var a:Ttowers; t_from,t_to,t_ext,m,n:integer);//����������� ���� ������ ���-� m � ����� t_from �� t_to (�������� ���������).
var
  i:integer;
begin
  while pause do  //���� ����� ����
    delay(10);
  if (m>0)and (play) then//����� �� ��������
  begin
    Hanoys_Towers(a,t_from,t_ext,t_to,m-1,n);//������������� ���� ��� 1 �� ��� �����
    if (play) then
      Shift(a,t_from,t_to);//������������� ������
    if play then
      delay(speed);
    Output(a,n);//������������
    Hanoys_Towers(a,t_ext,t_to,t_from,m-1,n);//������������� ���� � ��� ���� ����
  end;
end;



procedure TForm1.BpauseClick(Sender: TObject); //�����
begin
  if (not pause) and (play)  then   //���� ���� ���� � �� �� ����� �� ������ �����
  begin
    pause:=true;
    Bpause.Caption:='Continue';
  end
  else   //������������ ����
  begin
    pause:=false;
    Bpause.Caption:='Pause';
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);   //������
begin
  play:=false;
  pause:=false;
  speed:=10*Trackbar2.Position;
  Lspeed.Caption:='Delay = '+Inttostr(10*trackbar2.Position)+' ms';
  Ldisks.Caption:='Rings = '+Inttostr(trackbar1.Position);
end;

procedure TForm1.FormPaint(Sender: TObject);//��������� �����
begin
  canvas.Brush.Color:=clblack;
  Canvas.Rectangle(Bounds(0, 250, 729,300));
  canvas.Brush.Color:=clsilver;
  canvas.Fillrect(bounds(530,0,600,331));
  canvas.MoveTo(530,0);
  canvas.LineTo(530,300);
  canvas.Font.Size:=30;
  canvas.Font.Color:=clmaroon;
  TextOut(canvas.Handle,540,20,'HANOYS',6);
  TextOut(canvas.Handle,550,60,'TOWERS',6);
end;




procedure TForm1.StartClick(Sender: TObject); //������ ����
var
  a:Ttowers;//�����
  n,j,k,i:integer;//�����
begin
  if play=false then//���� �� ����
  begin
  n:=Trackbar1.Position;  //��������� n
  pause:=false;     //����� ���
  Bpause.Caption:='Pause';
  play:=true;   //���� �����
  Start.Caption:='Stop'; //������ ��� ������ ��� ���������
  Input(a,n); //����
  Output(a,n); //�����
  Hanoys_towers(a,1,2,3,n,n); //����
  Output(a,n);   //������������� �����
  Start.Caption:='Start';   //���� ���������
  if not play then  //���� ���� �������� ������
  begin
     input(a,trackbar1.Position); //������� 1� �����
     output(a,trackbar1.Position);
  end;
  play:=false;  //���� ����
  end
  else
  begin     //����������
    pause:=false;
    Bpause.Caption:='Pause';
    play:=false;
    Start.Caption:='Start';
    form1.Repaint;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject); //������ ��� �������������� ��������� (��� ���� �� ��������)
var
  a:ttowers;
begin
  timer1.Enabled:=false;
  timer1.Interval:=10;
  input(a,trackbar1.Position);
  output(a,trackbar1.Position);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);//����� ������
begin
  LDisks.Caption:= 'Rings = '+Inttostr(trackbar1.Position);
  if not play then  //���� �� �� ����� ���� �� ���� ����������
    timer1.Enabled:=true;
end;

procedure TForm1.TrackBar2Change(Sender: TObject); //��������
begin
  speed:=10*trackbar2.Position;
  Lspeed.Caption:='Delay = '+Inttostr(10*trackbar2.Position)+' ms';
end;

end.
