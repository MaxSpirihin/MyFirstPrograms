{ВЫЧИСЛЕНИЕ ПЛОЩАДИ И МЕДИАН ТРЕУГОЛЬНИКА}
{Данная программа по длинам 3 сторон, ищет площадь и медианы треугольника с вершинами в этих точках}
program TheTriangle;

procedure InputCoor(var lenAB,lenAC,lenBC:real);                                 {Процедура ввода длин сторон}
begin
  writeln('You must enter lengths of sides of the triangle!!!');
  writeln('Enter length of side AB:');
  readln(lenAB);
  writeln('Enter length of side AC:');
  readln(lenAC);
  writeln('Enter length of side BC:');
  readln(lenBC); 
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
  lenAB,lenAC,lenBC:real;                                                        {Длины сторон}
  Square:real;                                                                   {Площадь}
  medA,medB,medC:real;                                                           {Медианы}

begin
  InputCoor(lenAB,lenAC,lenBC);                                                  {Ввод длин сторон}
  if (lenAB>=lenAC+lenBC) or (lenAC>=lenBC+lenAB) or (lenBC>=lenAC+lenAB) then
    writeln('Error!!! Inequality of triangle is not confirmed!!!') 
  else
    begin
    SolveSqr(lenAB,lenAC,lenBC,Square);                                            {Нахождение площади}
    SolveMedian(lenAB,lenAC,lenBC,medA,medB,medC);                                 {Нахождение медиан}
    OutputSqrMedian(Square,medA,medB,medC);                                        {Вывод}
    end;
end.