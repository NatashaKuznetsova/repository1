# repository1
program djcstr;

type
  TMass = array of array of integer;
  TLines = array of array[1..2] of integer;

var
  Mmas: TMass;
  res: TLines;
  i, j, n: integer;

procedure Add(var Mmas: TMass; N: integer);
var
  i, j: integer;
begin
  setlength(Mmas, N);
  for i := 0 to N - 1 do
    setlength(Mmas[i], N);
  randomize;
  for i := 0 to N - 1 do
  begin
    for j := i to N - 1 do
      if (i = j) then Mmas[i, j] := 0
        else 
      begin
        Mmas[i, j] := (random(100) + 1);
        Mmas[j, i] := Mmas[i, j];
      end;
  end;
end;

procedure write_Mmas(Mmas: TMass);
var
  i, j: integer;

begin
  for i := 0 to length(Mmas) - 1 do
  begin
    for j := 0 to length(Mmas) - 1 do
      write(Mmas[i, j]:4);
    writeln;
  end;
end;

procedure algoritm_sam(Mmas: TMass; var res: TLines);

var
  i, j: integer;
  colors: array of integer;
  min, Len, k, l, r, color, N: integer;

begin
  
  k := 0;
  len := 0;
  N := length(Mmas);
  setlength(colors, N);
  setlength(res, N);
  for i := 0 to N - 1 do
    colors[i] := i;
  while k < N - 1 do
  begin
    min := 30000;
    l := 0;
    r := 1;
    
    for i := 0 to N - 2 do
      for j := i + 1 to N - 1 do       
        if (Mmas[i, j] < min) and (colors[i] <> colors[j]) then
        begin
          min := Mmas[i, j];
          l := i;
          r := j;
        end;
    k := k + 1;
    len := len + min;
    res[k - 1][1] := l;
    res[k - 1][2] := r;
    color := colors[l];
    for i := 0 to N - 1 do
      if (colors[i] = color) then
        colors[i] := colors[r];
  end;
end;

procedure print(res: TLines; Mmas: TMass);
var
  i, j: integer;

begin
  for i := 0 to length(Mmas) - 2 do
    writeln(res[i][1], '<---->', res[i][2], ' расстояние ', Mmas[res[i][1], res[i][2]]);
end;

begin
  writeln('Введите количество узлов графа');
  readln(N);
  Add(Mmas, N);
  write_Mmas(Mmas);
  algoritm_sam(Mmas, res);
  writeln('Кратчайшее расстояние:');
  print(res, Mmas);
end.
