
Unit unit_lista;

Interface

Type 
  t_evento = (cumple, reunion, otro);

  TEvento = Record
    id: integer;
    fechainicio: string[10];
    fechafin: string[10];
    horainicio: string;
    horafin: string;
    ubicacion: string;
    titulo: string;
    descripcion: string;
    t_evento: t_evento;
  End;

  TListaEventos = Record
    eventos: array[1..200] Of TEvento ;
    cant: integer;
  End;

Procedure CREARLISTA (Var L:TListaEventos);
Procedure ELIMINAREVENTO (Var L:TListaEventos; id: integer);
Function LISTA_LLENA (Var L:TListaEventos): BOOLEAN;
Function LISTA_VACIA (Var L:TListaEventos): BOOLEAN;
Procedure AGREGAR (Var L:TListaEventos; X:TEvento; Var id: integer);
Procedure MUESTRA_LISTA(L:TListaEventos);
Procedure BUSCAR_titulo (L:TListaEventos; BUSCADO:String);
Procedure BUSCAR_entre_fechas(L:TListaEventos; fecha1,fecha2:String);
Procedure BUSCAR_tipo (L:TListaEventos; tipo:t_evento);

Implementation

Procedure CREARLISTA (Var L:TListaEventos);

Var i: integer;
Begin
  For i:=1 To 200 Do
    Begin
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
    End;
  L.cant := 0;
  // Inicializar la cantidad de eventos a 0
End;

Procedure BUSCARPORID(L: TListaEventos; id: integer; Var pos: Integer);

Var 
  enc: Boolean;
  i: Integer;
Begin
  enc := false;
  i := 1;
  While (i <= L.cant) And (Not enc) Do
    Begin
      If L.eventos[i].id = id Then enc := true
      Else inc(i);
    End;
  If enc Then
    pos := i
End;

Procedure ELIMINAREVENTO (Var L:TListaEventos; id: integer);

Var 
  i, pos: integer;
Begin
  pos := 0;
  BUSCARPORID(L, id, pos);
  If pos <> 0 Then
    Begin
      For i:= pos To L.cant Do
        Begin
          L.eventos[i].id := L.eventos[i+1].id;
          L.eventos[i].fechainicio := L.eventos[i+1].fechainicio;
          L.eventos[i].fechafin := L.eventos[i+1].fechafin;
          L.eventos[i].horainicio := L.eventos[i+1].horainicio;
          L.eventos[i].horafin := L.eventos[i+1].horafin;
          L.eventos[i].ubicacion := L.eventos[i+1].ubicacion;
          L.eventos[i].titulo := L.eventos[i+1].titulo;
          L.eventos[i].descripcion := L.eventos[i+1].descripcion;
        End;
      dec(L.cant);
      // Reducir el tamaño del array
      WriteLn('Evento ', id, ' borrado');
    End
  Else
    writeln('Evento no encontrado');
End;

Function LISTA_LLENA (Var L:TListaEventos): BOOLEAN;
Begin
  LISTA_LLENA := L.cant=200;
End;

Function LISTA_VACIA (Var L:TListaEventos): BOOLEAN;
Begin
  LISTA_VACIA := L.cant=0;
End;

Procedure AGREGAR (Var L:TListaEventos; X:TEvento; Var id: integer);
Begin
  If Not lista_llena(L) Then
    Begin
      inc(L.cant);
      // Incrementar la cantidad de eventos
      L.eventos[L.cant] := X;
      // Agregar el nuevo evento al final del array
      id:= L.cant + 1;
      L.eventos[L.cant].id := id;
    End;
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

Procedure MUESTRA_LISTA(L:TListaEventos);
//LISTADO

Var 
  E: TEvento;
  i: integer;
Begin
  i := 1;
  While (i <= L.cant) Do
    Begin
      E := L.eventos[i];
      MUESTRA_DATOS(E);
      i := i+1;
    End;
End;


Procedure BUSCAR_titulo (L:TListaEventos; BUSCADO:String);

Var 
  E: TEvento;
  aux: BYTE;
  i, cont: integer;
Begin
  i := 1;
  cont := 0;
  For i:=1 To L.cant Do
    Begin
      E := L.eventos[i];
      aux := Pos(BUSCADO, E.titulo);
      If aux > 0 Then
        Begin
          Muestra_datos(E);
          inc(cont);
        End;
    End;
  If cont = 0 Then WriteLn('No hay coincidencias');
End;

Procedure BUSCAR_entre_fechas(L:TListaEventos; fecha1,fecha2:String);
// hay que corregir porque no sirve la comparacion de fechas con string

Var 
  E: TEvento;
  POS: BYTE;
  i, cont: integer;
Begin
  i := 1;
  cont := 0;
  For i:=1 To L.cant Do
    Begin
      E := L.eventos[i];
      If (E.fechainicio >= fecha1) And (E.fechainicio <= fecha2) And (E.
         fechafin >= fecha1) And (E.fechafin <= fecha2)Then
        Begin
          Muestra_datos(E);
          inc(cont);
        End;
    End;
  If cont = 0 Then WriteLn('No hay coincidencias');
End;

Procedure BUSCAR_tipo (L:TListaEventos; tipo:t_evento);

Var 
  E: TEvento;
  i, cont: integer;
Begin
  cont := 0;
  For i := 1 To L.cant Do
    Begin
      E := L.eventos[i];
      If E.t_evento = tipo Then
        Begin
          Muestra_datos(E);
          inc(cont);
        End;
    End;
  If cont = 0 Then WriteLn('No hay coincidencias');
End;


End.
