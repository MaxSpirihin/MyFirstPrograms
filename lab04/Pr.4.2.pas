{���������� ������� � ������ ������������}
{������ ��������� �� ��������� ����������� 3 �����, ���� ������� � ������� ������������ � ��������� � ���� ������}
program TheTriangle;

procedure InputCoor(var xA,yA,xB,yB,xC,yC,lenAB,lenAC,lenBC:real);                           {��������� ����� ��������� � ���������� �� ��� ���� ������}
begin
  writeln('You must enter coordinates of apex of the triangle!!!');
  writeln('Enter coordinates of apex A in form (xA,yA separated by a space)');
  readln(xA,yA);
  writeln('Enter coordinates of apex B in form (xA,yA separated by a space');
  readln(xB,yB);
  writeln('Enter coordinates of apex C in form (xA,yA separated by a space');
  readln(xC,yC);
  lenAC:=sqrt(sqr(xC-xA)+sqr(yC-yA));                                                        {��������� ����� ������}
  lenAB:=sqrt(sqr(xB-xA)+sqr(yB-yA));
  lenBC:=sqrt(sqr(xC-xB)+sqr(yC-yB));
end;

procedure SolveSqr(lenAB,lenAC,lenBC:real; var square:real);                                 {��������� ���������� ������� �� ������� ������ }
var
  p:real;                                                                                    {������������}
begin
  p:=(lenAB+lenBC+lenAC)/2;
  square:=sqrt(p*(p-lenAB)*(p-lenAC)*(p-lenBC));
end;

procedure SolveMedian(lenAB,lenAC,lenBC:real; var medA,medB,medC:real);                      {��������� ���������� ������}
begin
  medA:=(sqrt(2*sqr(lenAB)+2*sqr(lenAC)-sqr(lenBC)))/2;
  medB:=(sqrt(2*sqr(lenAB)+2*sqr(lenBC)-sqr(lenAC)))/2;
  medC:=(sqrt(2*sqr(lenBC)+2*sqr(lenAC)-sqr(lenAB)))/2;
end;

procedure OutputSqrMedian(square,medA,medB,medC:real);                                       {��������� ������ ������� � ������}
begin
  writeln('Square of triangle=',square:7:5);
  writeln('Median from point A=',medA:7:5);
  writeln('Median from point B=',medB:7:5);
  writeln('Median from point C=',medC:7:5);
end;

var
  xA,yA,xB,yB,xC,yC:real;                                                        {���������� ������}
  lenAB,lenAC,lenBC:real;                                                        {����� ������}
  Square:real;                                                                   {�������}
  medA,medB,medC:real;                                                           {�������}

begin
  InputCoor(xA,yA,xB,yB,xC,yC,lenAB,lenAC,lenBC);                                {���� ��������� �����}
  SolveSqr(lenAB,lenAC,lenBC,Square);                                            {���������� �������}
  SolveMedian(lenAB,lenAC,lenBC,medA,medB,medC);                                 {���������� ������}
  OutputSqrMedian(Square,medA,medB,medC);                                        {�����}
end.