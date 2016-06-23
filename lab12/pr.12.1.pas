                       {ГРАФИК ФУНКЦИИ}


uses graphABC;

const
  TOPX=650;//коор-ты вершины по оси х
  TOPY=350;//коорты вершины по оси y;
  EY=100;//длина единичного вектора по y;
  EX=50;//длина единичного вектора по x;
  LENX=500;//длина оси х(половины)
  LENY=250;//длина оси y(половины)
  EPS=0.02;//шаг
  STARTX=10;//какую часть х строим



function func(x:real):real;//функция, чей график мы строим. При изменении НЕ ЗАБУДЬТЕ изменить процедуру name!!!
begin
  func:=cos(x);
end;

procedure Name();//выводит название ф-ии.
begin
  SetfontSize(100);
  SetfontColor(clred);
  TextOut(20,20,'y=cos(x)');
end;

function NewY(y0:real): integer;//перевод у-ой коорд. в номер пикселя
var
  y:integer;
begin
  y0:=y0*10000;
  y:=trunc(y0);
  y:=y div (10000 div EY);
  y:=TOPY-y;
  NewY:=y;
end;

function NewX(x0:real): integer;//перевод х-ой коорд. в номер пикселя
var
  x:integer;
begin
  x0:=x0*10000;
  x:=trunc(x0);
  x:=x div (10000 div EX);
  x:=TOPx+x;
  NewX:=x;
end;

procedure Start();//подготовка экрана
var
  x,y:integer;
begin
  InitgraphABC();
  SetWindowSize(1300,700);
  SetWindowPos(10,10);
  line(TOPX-LENX,TOPY,TOPX+LENX,TOPY);//ось х
  line(TOPX,TOPY-LENY,TOPX,TOPY+LENY);//ось y
  //рисуем стрелочки
  line(TOPX-5,TOPY-LENY+5,TOPX,TOPY-LENY);//y
  line(TOPX+5,TOPY-LENY+5,TOPX,TOPY-LENY);
  line(TOPX+LENX-5,TOPY-5,TOPX+LENX,TOPY);//x
  line(TOPX+LENX-5,TOPY+5,TOPX+LENX,TOPY);
  //подписываем х и у
  textout(TOPX+5,TOPY-LENY-5,'y');
  textout(TOPX+LENX+5,TOPY-10,'x'); 
  textout(TOPX+5,TOPY+5,'0');
  //пишем название
  Name();
end;

procedure doey();//расставление ед отрезков по у
var
  y:integer;
begin
    y:=0;
  while (y<LENY) do
  begin
    line(TOPX-2,TOPY-y,TOPX+2,TOPY-y);
    line(TOPX-2,TOPY+y,TOPX+2,TOPY+y);
    y:=y+EY;
  end;
end;

procedure doex();//расставление ед отрезков по х
var
  x:integer;
begin
  x:=0;
  while (x<LENX) do
  begin
    line(TOPX+x,TOPY-2,TOPX+x,TOPY+2);
    line(TOPX-x,TOPY-2,TOPX-x,TOPY+2);
    x:=x+EX;
  end;
end;

procedure Dopi();//расставление пи по х. Для косинуса только
var
  x,k,s:integer;
  stri:string;
begin
  setfontsize(10);//шрифт менялся
  setfontcolor(clblack);
  s:=1;//счетчик пи
  k:=NewX(pi)-TOPX;//перевод пи в пиксели
  x:=k;//начало
  while (x<LENX) do//пока есть куда рисовать
  begin
    line(TOPX+x,TOPY-2,TOPX+x,TOPY+2);//чертим рисочку
    str(s,stri);//переводим номер пи в строку
    textout(TOPX+x-5,TOPY+6,stri+'П');//выводим  номер пи
    line(TOPX-x,TOPY-2,TOPX-x,TOPY+2);//аналогично для отрицательных
    textout(TOPX-x-5,TOPY+6,'-'+stri+'П');
    x:=x+k;//шагаем
    s:=s+1;//увеличивам счетчик пи
  end;
end;

procedure DoGraph();//построение графика. График строится по линиям от 1 точки к следующей
var
  x,y:real;//коор-ты
  xn,yn,xp,yp:integer;//они в пмкселях(новые и предыдущие)
begin
  x:=-STARTX;//начинаем идти
  y:=func(x);//вычисляем у
  xp:=newx(x);//переводим в пиксели
  yp:=newy(y);
  x:=x+EPS;//шагаем
  while (x<STARTX) do//пока не дошли до конца
  begin
    y:=func(x);//вычисляем у
    yn:=NewY(y);//переводим в пиксели
    xn:=NewX(x);
    line(xn,yn,xp,yp);//чертим линию от новой точки к предыдущей
    xp:=xn;//новая точка будет старой
    yp:=yn;
    x:=x+EPS;//шагаем
  end;
end;

begin
  Start();//подготавливаем полотно
  Dograph();//строим график
  doey();//расставляем ед отрезки по у
  Dopi();//добавляем пи
end.  