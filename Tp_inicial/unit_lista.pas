
Unit unit_lista;

Interface
uses unit_tipoeventos;

Type 
 Tipo_evento= TTipoEvento;

  TListaEventos = Record
    eventos: array[1..200] Of TEvento ;
    cant: integer;
  End;

Procedure CREARLISTA (Var L:TListaEventos);
Procedure BUSCARPORID(L: TListaEventos; id: integer; Var pos: Integer);
Procedure ELIMINAREVENTO (Var L:TListaEventos; id: integer; var encontrado:boolean);
Function LISTA_LLENA (Var L:TListaEventos): BOOLEAN;
Function LISTA_VACIA (Var L:TListaEventos): BOOLEAN;
Procedure AGREGAR (Var L:TListaEventos; X:TEvento; Var id: integer);
Procedure BUSCAR_titulo(L: TListaEventos; BUSCADO: String; var poss: integer; var encontrado: boolean; var E: TEvento);
Procedure BUSCAR_entre_fechas(L: TListaEventos; fecha1, fecha2: String; var encontrado: boolean; var pos: integer; var E: TEvento);
Procedure BUSCAR_tipo(L: TListaEventos; tipo: TTipoEvento; var encontrado: boolean; var pos: integer; var E: TEvento);



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

Procedure ELIMINAREVENTO (Var L:TListaEventos; id: integer; var encontrado:boolean);

Var 
  i, pos: integer;
Begin
  encontrado := false;
  pos := 0;
  BUSCARPORID(L, id, pos);
  If pos <> 0 Then
    Begin
      encontrado := true;
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
    End
  Else
    encontrado := false;
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


Procedure BUSCAR_titulo(L: TListaEventos; BUSCADO: String; var poss: integer; var encontrado: boolean; var E: TEvento);
Var
  aux: integer;
Begin
  encontrado := False;
  while (poss <= L.cant) and (not encontrado) do
  begin
    E := L.eventos[poss]; // L.eventos es un array
    aux := Pos(LowerCase(BUSCADO), LowerCase(E.titulo));
    if aux > 0 then
      encontrado := True;
  end;
end;



Procedure BUSCAR_entre_fechas(L: TListaEventos; fecha1, fecha2: String; var encontrado: boolean; var pos: integer; var E: TEvento);
begin
  encontrado := false;
  while (pos <= L.cant) and (not encontrado) do
  begin
    E := L.eventos[pos];
    if (E.fechainicio >= fecha1) and (E.fechainicio <= fecha2) and
       (E.fechafin   >= fecha1) and (E.fechafin   <= fecha2) then
      encontrado := true
    else
      Inc(pos);
  end;

  if encontrado then
    Inc(pos); // dejar lista para la próxima búsqueda
end;


Procedure BUSCAR_tipo(L: TListaEventos; tipo: TTipoEvento; var encontrado: boolean; var pos: integer; var E: TEvento);
begin
  encontrado := false;
  while (pos <= L.cant) and (not encontrado) do
  begin
    E := L.eventos[pos];  // acceder al evento en el array
    if E.t_evento = tipo then
      encontrado := true
    else
      Inc(pos);
  end;

  if encontrado then
    Inc(pos); // avanzar para que la siguiente búsqueda arranque después
end;


End.
