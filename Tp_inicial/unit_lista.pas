unit uniTListaEventos;

interface

type
  TEvento = record
    id:integer;
    fechainicio:string[10];
    fechafin:string[10];
    horainicio:string;
    horafin:string;
    ubicacion:string;
    titulo: string;
    descripcion:string;
    t_evento: (cumpleaños,reunion,otro);
  end;

  TListaEventos = record
    eventos: array[1..200] of TEvento ;
    cant:integer;
  end;

PROCEDURE CREARLISTA (VAR L:TListaEventos);
PROCEDURE ELIMINARLISTA (VAR L:TListaEventos; buscado: integer; VAR X:TEvento;);
FUNCTION LISTA_LLENA (VAR L:TListaEventos): BOOLEAN;
FUNCTION LISTA_VACIA (VAR L:TListaEventos): BOOLEAN;
PROCEDURE AGREGAR (VAR L:TListaEventos; X:TEvento);
procedure Muestra_datos (E:TEvento);
procedure fin (L:TListaEventos):boolean;
PROCEDURE MUESTRA_LISTA(L:TListaEventos); 
procedure recuperar (L:TListaEventos; var E:TEvento; i:integer);
PROCEDURE BUSCAR_titulo (L:TListaEventos; BUSCADO:string; VAR ENC:BOOLEAN); 
PROCEDURE BUSCAR_entre_fechas(L:TListaEventos; fecha1,fecha2:string[10]; VAR ENC:BOOLEAN); 
PROCEDURE BUSCAR_tipo (L:TListaEventos; BUSCADO:STRING; VAR ENC:BOOLEAN); 


implementation

PROCEDURE CREARLISTA (VAR L:TListaEventos);
var i:integer;
begin
for i:=1 to 200 do
  begin
    SetLength(L, i);
    L[i-1].id := 0;
    L[i-1].Tfecha.fechainicio := '';
    L[i-1].Tfecha.fechafin := '';
    L[i-1].Thora.horainicio := '';
    L[i-1].Thora.horafin := '';
    L[i-1].ubicacion := '';
    L[i-1].titulo := '';
    L[i-1].descripcion := '';
    L[i-1].t_evento := 'otro'; 
  end;

PROCEDURE ELIMINARLISTA (VAR L:TListaEventos; buscado: integer; VAR X:TEvento;);
VAR
i:integer;
BEGIN
FOR i:=0 TO L.cant DO
BEGIN
IF L.eventos[i].id = buscado THEN
    BEGIN
    X:= L.eventos[i];
    for i:=i to L.eventos[i].id=0 do
    begin
    L.eventos[i].Tfecha.fechainicio := L.eventos[i+1].Tfecha.fechainicio;
    L.eventos[i].Tfecha.fechafin := L.eventos[i+1].Tfecha.fechafin;
    L.eventos[i].Thora.horainicio := L.eventos[i+1].Thora.horainicio;
    L.eventos[i].Thora.horafin := L.eventos[i+1].Thora.horafin;
    L.eventos[i].ubicacion := L.eventos[i+1].ubicacion;
    L.eventos[i].titulo := L.eventos[i+1].titulo;
    L.eventos[i].descripcion := L.eventos[i+1].descripcion;
    end;
    dec(L.cant); // Reducir el tamaño del array
    end
    ELSE
    inc(i);
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


procedure Muestra_datos (E:TEvento);
begin
writeln('ID: ', E.id);
writeln('Fecha Inicio: ', E.Tfecha.fechainicio);
writeln('Fecha Fin: ', E.Tfecha.fechafin);
writeln('Hora Inicio: ', E.Thora.horainicio);
writeln('Hora Fin: ', E.Thora.horafin);
writeln('Ubicación: ', E.ubicacion);
writeln('Título: ', E.titulo);
writeln('Descripción: ', E.descripcion);
writeln('Tipo de Evento: ', E.t_evento);
end; 

procedure fin (L:TListaEventos):boolean;
begin
fin:= L.cant=200;
end;

PROCEDURE MUESTRA_LISTA(L:TListaEventos); //LISTADO
VAR
E:TEvento;
i:integer;
BEGIN
i:=1;
WHILE NOT FIN(L) DO
    BEGIN
    RECUPERAR(L,E,i);
    MUESTRA_DATOS(E);
    i:=i+1;
    END;
end;

procedure recuperar (L:TListaEventos; var E:TEvento; i:integer);
begin
E:=L.eventos[i]; // Recuperar el último evento agregado
end;

PROCEDURE BUSCAR_titulo (L:TListaEventos; BUSCADO:string; VAR ENC:BOOLEAN); //SI BUSCA POR CAMPO CLAVE O TIPO SIMPLE EN INFO
VAR
E:TEvento; POS:BYTE; i:integer;
BEGIN
i:=1; POS:=0; ENC:=FALSE
WHILE NOT FIN(L) AND (POS=0) DO
    BEGIN
    for i:=1 to L.cant do begin
    RECUPERAR(L[i].evento,E,i);
    IF BUSCADO in E.titulo then pos:=1;
    Muestra_datos(E); end
    ELSE inc(i);
    end;
END;

PROCEDURE BUSCAR_entre_fechas(L:TListaEventos; fecha1,fecha2:string[10]; VAR ENC:BOOLEAN); //SI BUSCA POR CAMPO CLAVE O TIPO SIMPLE EN INFO
VAR
E:TEvento; POS:BYTE; i:integer;
BEGIN
i:=1; POS:=0; ENC:=FALSE
WHILE NOT FIN(L) AND (POS=0) DO
BEGIN
for i:=1 to L.cant do
    begin
    RECUPERAR(L,E,i);
    IF (E.Tfecha.fechainicio >= fecha1) AND (E.Tfecha.fechafin <= fecha2) THEN
        BEGIN
        Muestra_datos(E);
            END ELSE
            inc(i);
            end;
    END;
end;

PROCEDURE BUSCAR_tipo (L:TListaEventos; BUSCADO:STRING; VAR ENC:BOOLEAN); 
VAR
E:TEvento; POS:BYTE;i:integer;
BEGIN
i:=1; POS:=0; ENC:=FALSE;
WHILE NOT FIN(L) AND (POS=0) DO
    BEGIN
    for i:=1 to L.cant do
        begin
        RECUPERAR(L,E,i);
        IF E.T_evento = BUSCADO THEN 
            begin
            MUESTRA_DATOS(E);
            end
            ELSE inc(i);
            END;
        end;
    end;
END;


end.
