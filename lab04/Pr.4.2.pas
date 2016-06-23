{ВЫЧИСЛЕНИЕ ПЛОЩАДИ И МЕДИАН ТРЕУГОЛЬНИКА}
{Данная программа по введенным координатам 3 точек, ищет площадь и медианы треугольника с вершинами в этих точках}
program TheTriangle;

procedure InputCoor(var xA,yA,xB,yB,xC,yC,lenAB,lenAC,lenBC:real);                           {Процедура ввода координат и вычисления по ним длин сторон}
begin
  writeln('You must enter coordinates of apex of the triangle!!!');
  writeln('Enter coordinates of apex A in form (xA,yA separated by a space)');
  readln(xA,yA);
  writeln('Enter coordinates of apex B in form (xA,yA separated by a space');
  readln(xB,yB);
  writeln('Enter coordinates of apex C in form (xA,yA separated by a space');
  readln(xC,yC);
  lenAC:=sqrt(sqr(xC-xA)+sqr(yC-yA));                                                        {Вычисляем длины сторон}
  lenAB:=sqrt(sqr(xB-xA)+sqr(yB-yA));
  lenBC:=sqrt(sqr(xC-xB)+sqr(yC-yB));
end;

procedure SolveSqr(lenAB,lenAC,lenBC:real; var square:real);                                 {Процедура вычисления площади по теореме Герона }
var
  p:real;                                                                                    {Полупериметр}
begin
  p:=(lenAB+lenBC+lenAC)/2;
  square:=sqrt(p*(p-lenAB)*(p-lenAC)*(p-lenBC));
end;

procedure SolveMedian(lenAB,lenAC,lenBC:real; var medA,medB,medC:real);                      {Процедура вычисления медиан}
begin
  medA:=(sqrt(2*sqr(lenAB)+2*sqr(lenAC)-sqr(lenBC)))/2;
  medB:=(sqrt(2*sqr(lenAB)+2*sqr(lenBC)-sqr(lenAC)))/2;
  medC:=(sqrt(2*sqr(lenBC)+2*sqr(lenAC)-sqr(lenAB)))/2;
end;

procedure OutputSqrMedian(square,medA,medB,medC:real);                                       {Процедура вывода площади и медиан}
begin
  writeln('Square of triangle=',square:7:5);
  writeln('Median from point A=',medA:7:5);
  writeln('Median from point B=',medB:7:5);
  writeln('Median from point C=',medC:7:5);
end;

var
  xA,yA,xB,yB,xC,yC:real;                                                        {Координаты вершин}
  lenAB,lenAC,lenBC:real;                                                        {Длины сторон}
  Square:real;                                                                   {Площадь}
  medA,medB,medC:real;                                                           {Медианы}

begin
  InputCoor(xA,yA,xB,yB,xC,yC,lenAB,lenAC,lenBC);                                {Ввод координат точек}
  SolveSqr(lenAB,lenAC,lenBC,Square);                                            {Нахождение площади}
  SolveMedian(lenAB,lenAC,lenBC,medA,medB,medC);                                 {Нахождение медиан}
  OutputSqrMedian(Square,medA,medB,medC);                                        {Вывод}
end.