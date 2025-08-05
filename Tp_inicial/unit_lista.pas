unit unit_lista;

interface


type
  t_evento = (cumple, reunion, otro); // <-- Declarar primero

  TEvento = record
    id: integer;
    fechainicio: string[10];
    fechafin: string[10];
    horainicio: string;
    horafin: string;
    ubicacion: string;
    titulo: string;
    descripcion: string;
    t_evento: t_evento; // <-- Usar el tipo global aquí
  end;

  TListaEventos = record
    eventos: array[1..200] of TEvento ;
    cant:integer;
  end;

PROCEDURE CREARLISTA (VAR L:TListaEventos);
PROCEDURE ELIMINAREVENTO (VAR L:TListaEventos; buscado: integer; VAR X:TEvento);
FUNCTION LISTA_LLENA (VAR L:TListaEventos): BOOLEAN;
FUNCTION LISTA_VACIA (VAR L:TListaEventos): BOOLEAN;
PROCEDURE AGREGAR (VAR L:TListaEventos; X:TEvento);
procedure pedir_datos (var E:TEvento);
procedure Muestra_datos (E:TEvento);
PROCEDURE MUESTRA_LISTA(L:TListaEventos); //LISTADO
PROCEDURE BUSCAR_titulo (L:TListaEventos; BUSCADO:string; VAR ENC:BOOLEAN); 
PROCEDURE BUSCAR_entre_fechas(L:TListaEventos; fecha1,fecha2:string; VAR ENC:BOOLEAN); //SI BUSCA POR CAMPO CLAVE O TIPO SIMPLE EN INFO
PROCEDURE BUSCAR_tipo (L:TListaEventos; BUSCADO:STRING; VAR ENC:BOOLEAN); 

implementation

PROCEDURE CREARLISTA (VAR L:TListaEventos);
var i:integer;
begin
for i:=1 to 200 do
  begin
    L.eventos[i].id := i;
    L.eventos[i].fechainicio := '';
    L.eventos[i].fechafin := '';
    L.eventos[i].horainicio := '';
    L.eventos[i].horafin := '';
    L.eventos[i].ubicacion := '';
    L.eventos[i].titulo := '';
    L.eventos[i].descripcion := '';
    L.eventos[i].t_evento := otro; 
    //inc(i);
     end;
L.cant := 0; // Inicializar la cantidad de eventos a 0
end;

PROCEDURE ELIMINAREVENTO (VAR L:TListaEventos; buscado: integer; VAR X:TEvento);
VAR
i:integer;
BEGIN
i:=1;
IF L.eventos[i].id = buscado THEN
      BEGIN
      X:= L.eventos[i];
        for i:=i to L.cant do
        begin
        L.eventos[i].fechainicio := L.eventos[i+1].fechainicio;
        L.eventos[i].fechafin := L.eventos[i+1].fechafin;
        L.eventos[i].horainicio := L.eventos[i+1].horainicio;
        L.eventos[i].horafin := L.eventos[i+1].horafin;
        L.eventos[i].ubicacion := L.eventos[i+1].ubicacion;
        L.eventos[i].titulo := L.eventos[i+1].titulo;
        L.eventos[i].descripcion := L.eventos[i+1].descripcion;
        end;
      dec(L.cant); // Reducir el tamaño del array
    end
    ELSE
    inc(i);
    ELIMINAREVENTO(L,buscado,X);
    if i=201 then
      begin
        writeln('Evento no encontrado');
    end;
end;

FUNCTION LISTA_LLENA (VAR L:TListaEventos): BOOLEAN;
BEGIN
LISTA_LLENA:= L.cant=200;
END;

FUNCTION LISTA_VACIA (VAR L:TListaEventos): BOOLEAN;
BEGIN
LISTA_VACIA:= L.cant=0;
END;

PROCEDURE AGREGAR (VAR L:TListaEventos; X:TEvento);
begin
if not lista_llena(L) then
  begin
    L.eventos[L.cant] := X; // Agregar el nuevo evento al final del array
    L.eventos[L.cant].id := L.cant+1; 
    inc(L.cant); // Incrementar la cantidad de eventos
  end;
end;

procedure pedir_datos (var E:TEvento);
var tipo: byte;
begin
writeln('Ingrese titulo del evento:');
readln(E.titulo);
writeln('Ingrese descripcion del evento:');
readln(E.descripcion); 
writeln('Ingrese fecha de inicio (dd/mm/yyyy):');
readln(E.fechainicio);
writeln('Ingrese fecha de fin (dd/mm/yyyy):');
readln(E.fechafin);
writeln('Ingrese hora de inicio (hh:mm):');
readln(E.horainicio);
writeln('Ingrese hora de fin (hh:mm):');
readln(E.horafin);
writeln('Ingrese ubicacion del evento:');
readln(E.ubicacion);
writeln('Ingrese tipo de evento (1: cumple, 2: reunion, 3: otro):');
readln(tipo);
case tipo of
  1: E.t_evento := cumple;
  2: E.t_evento := reunion;
  else E.t_evento := otro;
end;
end;

procedure Muestra_datos (E:TEvento);
begin
writeln('ID: ', E.id);
writeln('Fecha Inicio: ', E.fechainicio);
writeln('Fecha Fin: ', E.fechafin);
writeln('Hora Inicio: ', E.horainicio);
writeln('Hora Fin: ', E.horafin);
writeln('Ubicación: ', E.ubicacion);
writeln('Título: ', E.titulo);
writeln('Descripción: ', E.descripcion);
writeln('Tipo de Evento: ', E.t_evento);
end; 


PROCEDURE MUESTRA_LISTA(L:TListaEventos); //LISTADO
VAR
E:TEvento;
i:integer;
BEGIN
i:=1;
WHILE (i <= L.cant) DO
    BEGIN
    E := L.eventos[i];
    MUESTRA_DATOS(E);
    i:=i+1;
    END;
end;


PROCEDURE BUSCAR_titulo (L:TListaEventos; BUSCADO:string; VAR ENC:BOOLEAN); 
VAR
E:TEvento; aux:BYTE; i:integer;
BEGIN
i:=1;  ENC:=FALSE;
WHILE (i <= L.cant) AND enc=false DO
      BEGIN
      for i:=1 to L.cant do 
          begin
          E:= L.eventos[i];
          aux:= Pos(BUSCADO, E.titulo);
          IF aux > 0 then
            begin
              enc:= true;
              Muestra_datos(E);
            end;
        end;
      end;
END;

PROCEDURE BUSCAR_entre_fechas(L:TListaEventos; fecha1,fecha2:string; VAR ENC:BOOLEAN); //SI BUSCA POR CAMPO CLAVE O TIPO SIMPLE EN INFO
VAR
E:TEvento; POS:BYTE; i:integer;
BEGIN
i:=1;  ENC:=FALSE;
WHILE (i <= L.cant) AND enc=false DO
BEGIN
for i:=1 to L.cant do
    begin
    E:= L.eventos[i];
    IF (E.fechainicio >= fecha1) AND (E.fechafin <= fecha2) THEN
        Muestra_datos(E);
            // END ELSE
            // inc(i);
            end;
    END;
end;

PROCEDURE BUSCAR_tipo (L:TListaEventos; BUSCADO:STRING; VAR ENC:BOOLEAN);
VAR
  E: TEvento;
  i: integer;
  tipo: t_evento; // Usar el tipo global
BEGIN
  ENC := FALSE;
  // Convertir string a tipo enumerado
  if LowerCase(BUSCADO) = 'cumple' then
    tipo := cumple
  else if LowerCase(BUSCADO) = 'reunion' then
    tipo := reunion
  else
    tipo := otro;

  for i := 1 to L.cant do
  begin
    E := L.eventos[i];
    if E.t_evento = tipo then
    begin
      ENC := TRUE;
      Muestra_datos(E);
    end;
  end;
END;


end.
