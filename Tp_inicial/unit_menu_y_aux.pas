
Unit unit_menu_y_aux;

Interface

Uses 
unit_lista, unit_tipoeventos;

procedure escribir_muestradatos(E: TEvento);
procedure escribir_tiposeventos(var E: TEvento; tipo:integer);
Procedure no_se_encontroevento();
procedure nocoincidencia();
procedure escribirTevento(E:TEvento);
Function cambia_fecha(fecha:string):string;
Procedure cargar_datos(Var L:TListaEventos; Var id: integer);
Procedure eliminar(Var L: TListaEventos);
  Procedure Muestra_datos (E:TEvento);
Procedure busqueda_titulo(var L: TListaEventos);
Procedure buscarfechas(L: TListaEventos);
Procedure buscartipo(L: TListaEventos);
Procedure menu();


Implementation

procedure escribir_muestradatos(E: TEvento);
begin
  Writeln('ID: ', E.id);
  Writeln('Título: ', E.titulo);
  Writeln('Descripción: ', E.descripcion);
  Writeln('Ubicación: ', E.ubicacion);
  Writeln('Fecha Inicio: ', E.fechainicio, '  Hora Inicio: ', E.horainicio);
  Writeln('Fecha Fin: ', E.fechafin, '  Hora Fin: ', E.horafin);
  Write('Tipo de evento: ');
end;
procedure escribir_tiposeventos(var E: TEvento; tipo:integer);
begin
  Write('Título: '); Readln(E.titulo);
  Write('Descripción: '); Readln(E.descripcion);
  Write('Ubicación: '); Readln(E.ubicacion);
  Write('Fecha inicio (YYYY-MM-DD): '); Readln(E.fechainicio);
  Write('Fecha fin (YYYY-MM-DD): '); Readln(E.fechafin);
  Write('Hora inicio (HH:MM): '); Readln(E.horainicio);
  Write('Hora fin (HH:MM): '); Readln(E.horafin);
  Write('Tipo de evento (0: cumple, 1: reunión, 2: otro): '); Readln(tipo);
end;
Procedure no_se_encontroevento();
begin
  writeln('No se encontro el evento');
  writeln('Presione una tecla para continuar...');
  readln;
end;
procedure nocoincidencia();
begin
  writeln('No se encontraron coincidencias');
  writeln('Presione una tecla para continuar...');
  readln;
end;
procedure escribirTevento(E:TEvento);
begin
   Case E.t_evento of
    cumple: Writeln('Cumpleaños');
    reunion: Writeln('Reunión');
    otro: Writeln('Otro');
  End;
  Writeln('------------------------');
end;
Function cambia_fecha(fecha:string):string;
var 
dia,mes,anio:string;
begin
  dia:=copy(fecha,1,2);
  mes:=copy(fecha,4,2);
  anio:=copy(fecha,7,4);
  cambia_fecha:=anio+'/'+mes+'/'+dia;
end;

Procedure cargar_datos(Var L:TListaEventos; Var id: integer);

Var 
  tipo: byte;
  E: TEvento;
Begin
  writeln('Ingrese titulo del evento:');
  readln(E.titulo);
  writeln('Ingrese descripcion del evento:');
  readln(E.descripcion);
  writeln('Ingrese fecha de inicio (dd/mm/yyyy):');
  readln(E.fechainicio);
  E.fechainicio := cambia_fecha(E.fechainicio);
  writeln('Ingrese fecha de fin (dd/mm/yyyy):');
  readln(E.fechafin);
  E.fechafin := cambia_fecha(E.fechafin);
  writeln('Ingrese hora de inicio (hh:mm):');
  readln(E.horainicio);
  writeln('Ingrese hora de fin (hh:mm):');
  readln(E.horafin);
  writeln('Ingrese ubicacion del evento:');
  readln(E.ubicacion);
  writeln('Ingrese tipo de evento (1: cumple, 2: reunion, 3: otro):');
  readln(tipo);
  Case tipo Of 
    1: E.t_evento := cumple;
    2: E.t_evento := reunion;
    Else E.t_evento := otro;
  End;

  AGREGAR(L, E, id);
  // lo agrego a la lista
End;

Procedure eliminar(Var L: TListaEventos);

Var 
  id: integer; encontrado:boolean;
Begin
  Write('Ingrese el id a eliminar: ');
  ReadLn(id);

  ELIMINAREVENTO(L, id, encontrado);
  If encontrado Then
    Writeln('Evento eliminado con exito')
  Else
    Writeln('No se encontro el evento con ID: ', id);
End;

  Procedure Muestra_datos (E:TEvento);
  Begin
    writeln('ID: ', E.id);
    writeln('Fecha Inicio: ', E.fechainicio);
    writeln('Fecha Fin: ', E.fechafin);
    writeln('Hora Inicio: ', E.horainicio);
    writeln('Hora Fin: ', E.horafin);
    writeln('Ubicación: ', E.ubicacion);
    writeln('Título: ', E.titulo);
    writeln('Descripción: ', E.descripcion);
    writeln('Tipo de Evento: ', E.t_evento);
  End;

Procedure busqueda_titulo(var L: TListaEventos);
Var
  sub: string;
  pos: integer;
  enc: boolean;
  E: TEvento;
Begin
  Write('Ingrese la palabra del título: ');
  ReadLn(sub);

  pos := 1; // arrancamos desde el primero
  BUSCAR_titulo(L, sub, pos, enc, E);

  if not enc then
    Writeln('No se encontró ningún evento con ese título.')
  else
  begin
    while enc do
    begin
      Muestra_datos(E);       // mostramos el encontrado
      pos := pos + 1;         // siguiente búsqueda arranca después
      BUSCAR_titulo(L, sub, pos, enc, E);
    end;
  end;
end;

Procedure buscarfechas(L: TListaEventos);
var
  fe1, fe2: string;
  pos: integer;
  E: TEvento;
  enc: boolean;
begin
  write('Ingrese fecha 1: ');
  ReadLn(fe1);
  fe1 := cambia_fecha(fe1);

  write('Ingrese fecha 2: ');
  ReadLn(fe2);
  fe2 := cambia_fecha(fe2);

  pos := 1;
  BUSCAR_entre_fechas(L, fe1, fe2, enc, pos, E);

  if not enc then
    Writeln('No se encontraron eventos en el rango de fechas.')
  else
  begin
    while enc do
    begin
      Muestra_datos(E);
      BUSCAR_entre_fechas(L, fe1, fe2, enc, pos, E);
    end;
  end;
end;


Procedure buscartipo(L: TListaEventos);
var
  op: integer;
  pos: integer;
  E: TEvento;
  encontrado: boolean;
  tipo: TTipoEvento;
begin
  Write('Ingrese tipo de evento (1: cumple, 2: reunion, 3: otro): ');
  ReadLn(op);

  case op of
    1: tipo := cumple;
    2: tipo := reunion;
    3: tipo := otro;
  end;
  pos := 1;
  BUSCAR_tipo(L, tipo, encontrado, pos, E);
  if not encontrado then
    Writeln('No se encontró ningún evento de ese tipo.')
  else
  begin
    while encontrado do
    begin
      Muestra_datos(E);
      BUSCAR_tipo(L, tipo, encontrado, pos, E);
    end;
  end;
end;


Procedure menu();

Var 
  op, ident: integer;
  L: TListaEventos;
Begin
  CREARLISTA(L);
  ident := 1;
  Repeat
    writeln('Sistema de eventos');
    WriteLn;
    writeln('1. Registrar evento');
    writeln('2. Mostrar todos los eventos');
    writeln('3. Eliminar evento');
    writeln('4. Buscar eventos por subcadena');
    writeln('5. Buscar eventos por fechas');
    writeln('6. Buscar eventos por tipo');
    writeln;
    writeln('0. Salir');
    WriteLn;
    Write('Ingrese una opcion: ');
    readln(op);

    Case op Of 
      1: cargar_datos(L, ident);
      2: MUESTRA_LISTA(L);
      3: eliminar(L);
      4: busqueda_titulo(L);
      5: buscarfechas(L);
      6: buscartipo(L);
    End;
  Until op = 0;
End;

End.
