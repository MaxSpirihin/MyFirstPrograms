                                    {Hanoys Towers}
{
План разработки:
  1.Функция создания массивов(башен)
  2.Функция вывода их на экран в виде башен
  3.Функция перекладывания адного диска на другой
  4.Основная рекурсивная функция
  5.Бегунки и прочая хрень
}
unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Start: TButton; //кнопка старот-стоп
    LDisks: TLabel; //выводит кол-во дисков
    Lautor: TLabel;
    LSpeed: TLabel;
    Bpause: TButton; //кнопка пауза
    TrackBar1: TTrackBar; //диски
    TrackBar2: TTrackBar; //задержка
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
  Ttower=array[0..MAX] of integer;//башня
  Ttowers=array[1..3] of Ttower;//3 башни


procedure Input(var a:Ttowers;n:integer);//Функция создания массивов(башен)
var
  i,k:integer;//счетчики
begin
  for i:=1 to MAX do//инициализируем башни как пустые
  begin
    a[1][i]:=0;
    a[2][i]:=0;
    a[3][i]:=0;
  end;
  if (n<MAX) and (n>=1) then
  begin
    k:=1;
    for i:=n downto 1 do//заполняем первую башню
    begin
      a[1][k]:=i;
      inc(k);
    end;
  end;
end;





procedure Delay(dwMilliseconds: Longint);//задержка-скопировано из инета(как работает не знаю)
 var
   iStart, iStop: DWORD;
 begin
   iStart := GetTickCount;
   repeat
     iStop := GetTickCount;
     Application.ProcessMessages;
   until (iStop - iStart) >= dwMilliseconds;
 end;




procedure Output(a:Ttowers;n:integer);//отрисовка
var
  i:integer;
  h,dif,len:integer;//высота 1 диска, разница радиусов, радиус каждого
begin
  Form1.Repaint;
  with form1.Canvas do begin
  //отрисовываем синий фон
  brush.color:=clskyblue;
  fillrect(bounds(0,529,0,250));
  //рисуем башни
  brush.Color:=clblack;
  rectangle(bounds(97,50,6,200));
  rectangle(bounds(257,50,6,200));
  rectangle(bounds(417,50,6,200));
  //вычисляем параметры
  if (n>=3) then
    h:=200 div n
  else
    h:=200 div 3;
  dif:=75 div n;
  //отрисовываем диски
  brush.color:=clred;
  pen.color:=clblack;
  for i:=1 to n do//башня а
  if a[1][i]<>0 then
    begin
      len:=a[1][i]*dif;
      rectangle(bounds(100-len,250-h*i,2*len,h));
    end;
  for i:=1 to n do//башня b
  if a[2][i]<>0 then
    begin
      len:=a[2][i]*dif;
      rectangle(bounds(260-len,250-h*i,2*len,h));
    end;
  for i:=1 to n do//башня c
  if a[3][i]<>0 then
    begin
      len:=a[3][i]*dif;
      rectangle(bounds(420-len,250-h*i,2*len,h));
    end;
  end;

end;



procedure Shift(var a:Ttowers;t_from,t_to:integer);//переложение верхнего диска с башни t_from на t_to
var
  i:integer;
  num_to,num_from:integer;//номера крайних дисков
begin
  i:=1;
  while (a[t_from][i]<>0)and(i<>MAX) do
    inc(i);
  num_from:=i-1;//ищем позицию перекладываемого диска
  i:=1;
  while (a[t_to][i]<>0)and(i<>MAX) do
    inc(i);
  num_to:=i;//ищем куда его пичкануть
  a[t_to][num_to]:=a[t_from][num_from];//перекладываем
  a[t_from][num_from]:=0;
end;



procedure Hanoys_Towers(var a:Ttowers; t_from,t_to,t_ext,m,n:integer);//переложение кучи дисков кол-м m с башни t_from на t_to (ОСНОВНАЯ ПРОЦЕДУРА).
var
  i:integer;
begin
  while pause do  //если пауза стоп
    delay(10);
  if (m>0)and (play) then//выход из рекурсии
  begin
    Hanoys_Towers(a,t_from,t_ext,t_to,m-1,n);//перекладываем кучу без 1 на доп башню
    if (play) then
      Shift(a,t_from,t_to);//перекладываем нижний
    if play then
      delay(speed);
    Output(a,n);//отрисовываем
    Hanoys_Towers(a,t_ext,t_to,t_from,m-1,n);//перекладываем кучу с доп куда надо
  end;
end;



procedure TForm1.BpauseClick(Sender: TObject); //пауза
begin
  if (not pause) and (play)  then   //если игра идет т не на паузе то ставим паузу
  begin
    pause:=true;
    Bpause.Caption:='Continue';
  end
  else   //возобновляем игру
  begin
    pause:=false;
    Bpause.Caption:='Pause';
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);   //запуск
begin
  play:=false;
  pause:=false;
  speed:=10*Trackbar2.Position;
  Lspeed.Caption:='Delay = '+Inttostr(10*trackbar2.Position)+' ms';
  Ldisks.Caption:='Rings = '+Inttostr(trackbar1.Position);
end;

procedure TForm1.FormPaint(Sender: TObject);//отрисовка формы
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




procedure TForm1.StartClick(Sender: TObject); //начало игры
var
  a:Ttowers;//башни
  n,j,k,i:integer;//диски
begin
  if play=false then//игра не идет
  begin
  n:=Trackbar1.Position;  //считываем n
  pause:=false;     //паузы нет
  Bpause.Caption:='Pause';
  play:=true;   //игра пошла
  Start.Caption:='Stop'; //теперь это кнопка для остановки
  Input(a,n); //ввод
  Output(a,n); //вывод
  Hanoys_towers(a,1,2,3,n,n); //игра
  Output(a,n);   //окончательный вывод
  Start.Caption:='Start';   //игра закончена
  if not play then  //если игра прервана юзером
  begin
     input(a,trackbar1.Position); //выводим 1ю башню
     output(a,trackbar1.Position);
  end;
  play:=false;  //игра стоп
  end
  else
  begin     //прерывание
    pause:=false;
    Bpause.Caption:='Pause';
    play:=false;
    Start.Caption:='Start';
    form1.Repaint;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject); //таймер для первоначальной отрисовки (без него не выходило)
var
  a:ttowers;
begin
  timer1.Enabled:=false;
  timer1.Interval:=10;
  input(a,trackbar1.Position);
  output(a,trackbar1.Position);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);//выбор дисков
begin
  LDisks.Caption:= 'Rings = '+Inttostr(trackbar1.Position);
  if not play then  //если не во время игры то надо отрисовать
    timer1.Enabled:=true;
end;

procedure TForm1.TrackBar2Change(Sender: TObject); //скорость
begin
  speed:=10*trackbar2.Position;
  Lspeed.Caption:='Delay = '+Inttostr(10*trackbar2.Position)+' ms';
end;

end.
