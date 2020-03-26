const
  N=100000;
type
  T_matrix = array [,] of integer;
  T_array = array of integer;
var
  graph:T_matrix;
  us_vert,weight,way:T_array;
  start_vert,amount_graph_vertex,i,j:integer;
procedure Print_way(way:T_array; vert,last:integer);
  
  begin
    if way[vert]<>0 then 
      Print_way(way,way[vert]-1,last);
    write(vert+1);
    if vert<>last 
      then write(' --> ');
  end;


procedure Dijkstra(graph:T_matrix; var us,weight,way:T_array; start:integer);
  var
    i,j,min_weight,index_min_weight,vertex:integer;
  begin
    for i:=0 to high(weight) do
      weight[i]:=N;
    weight[start]:=0;
    way[start]:=0;
    for i:=0 to high(graph) do
      begin
        vertex:=-1;
        for j:=0 to high(graph) do
          if (us[j]=0) and ((vertex=-1) or (weight[j]<weight[vertex])) then
            vertex:=j;
        if weight[vertex]=N then
          break;
        us[vertex]:=1;
        for j:=0 to high(graph) do
          if (weight[j]>weight[vertex]+graph[vertex,j]) and (graph[vertex,j]<>0) then
            begin
              weight[j]:=weight[vertex]+graph[vertex,j];
              way[j]:=vertex+1;
            end; 
      end;
  end;

begin
  writeln('Введите количество вершин в графе');
  readln(amount_graph_vertex);
  //при объяв. дин.масс. не указ-ся диапазон индексов,размер задается setlength в кач-ве параметров переменную-массив и размер, который следует установить
  setlength(us_vert,amount_graph_vertex);
  setlength(weight,amount_graph_vertex);
  setlength(way,amount_graph_vertex);
  setlength(graph,amount_graph_vertex,amount_graph_vertex);
  writeln('Введите граф');
  for i:=0 to amount_graph_vertex-1 do
    begin
      for j:=0 to amount_graph_vertex-1 do
        read(graph[i,j]);
      readln;
    end;
  writeln('Введите вершину, из которой нужно найти кратчайшее расстояние до всех остальных');
  readln(start_vert);
  Dijkstra(graph,us_vert,weight,way,start_vert-1);
  for i:=0 to high(way) do
    begin
      Print_way(way,i,i);
      writeln( '  Путь: ',weight[i]);
    end;
end.