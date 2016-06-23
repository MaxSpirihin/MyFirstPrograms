var
  f:text;
  i,r:integer;
begin
  assign(f,'input.txt');
  rewrite(f);
  for i:=1 to 10000 do
  begin
    r:=random(1000000);
    writeln(f,r);
  end;
  close(f);
end.
  