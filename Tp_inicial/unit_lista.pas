
Unit unit_lista;

Interface

Uses unit_tipoeventos;

Type 
  Tipo_evento = TTipoEvento;

  TListaEventos = Record
    eventos: array[0..200] Of TEvento ;
    cant: integer;
  End;

Procedure CREARLISTA (Var L:TListaEventos);
Procedure BUSCARPORID(L: TListaEventos; id: integer; Var pos: Integer);
Procedure ELIMINAREVENTO (Var L:TListaEventos; id: integer; Var encontrado:
                          boolean);
// Function LISTA_VACIA (Var L:TListaEventos): BOOLEAN;
Procedure AGREGAR (Var L:TListaEventos; X:TEvento; Var id: integer);
Procedure BUSCAR_titulo(L: TListaEventos; BUSCADO: String; Var L_aux:
                        Teventoaux);
Procedure BUSCAR_entre_fechas(L: TListaEventos; fecha1, fecha2: String; Var
                              L_aux: Teventoaux);
Procedure BUSCAR_tipo(L: TListaEventos; tipo: TTipoEvento; Var L_aux:
                      Teventoaux);
Procedure RECUPERAPOS (L: TListaEventos; Var E: TEvento; pos: Integer);



Implementation

Procedure CREARLISTA (Var L:TListaEventos);

Var i: integer;
Begin
  For i:=0 To 200 Do
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
  i := 0;
  While (i <= L.cant) And (Not enc) Do
    Begin
      If L.eventos[i].id = id Then enc := true
      Else inc(i);
    End;
  If enc Then
    pos := i
End;

Procedure ELIMINAREVENTO (Var L:TListaEventos; id: integer; Var encontrado:
                          boolean);

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

// Function LISTA_VACIA (Var L:TListaEventos): BOOLEAN;
// Begin
//   LISTA_VACIA := L.cant=0;
// End;

Procedure AGREGAR (Var L:TListaEventos; X:TEvento; Var id: integer);
Begin
  If Not lista_llena(L) Then
    Begin
      L.eventos[L.cant] := X;
      // Agregar el nuevo evento al final del array
      id := L.cant + 1;
      L.eventos[L.cant].id := id;
      // Incrementar la cantidad de eventos
      inc(L.cant);
    End;
End;


Procedure BUSCAR_titulo(L: TListaEventos; BUSCADO: String; Var L_aux:
                        Teventoaux);

Var 
  aux, i: integer;
  E: TEvento;
Begin
  L_aux.cant := 0;

  For i:=0 To (L.cant - 1) Do
    Begin
      E := L.eventos[i];
      // L.eventos es un array
      aux := Pos(LowerCase(BUSCADO), LowerCase(E.titulo));
      If aux > 0 Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;
End;



Procedure BUSCAR_entre_fechas(L: TListaEventos; fecha1, fecha2: String; Var
                              L_aux: Teventoaux);

Var 
  i: integer;
  E: TEvento;
Begin
  L_aux.cant := 0;

  For i:=0 To (L.cant - 1) Do
    Begin
      E := L.eventos[i];
      If (E.fechainicio >= fecha1) And (E.fechainicio <= fecha2) And
         (E.fechafin   >= fecha1) And (E.fechafin   <= fecha2) Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;
End;


Procedure BUSCAR_tipo(L: TListaEventos; tipo: TTipoEvento; Var L_aux:
                      Teventoaux);

Var 
  i: integer;
  E: TEvento;
Begin
  L_aux.cant := 0;

  For i:=0 To (L.cant - 1) Do
    Begin
      E := L.eventos[i];
      If E.t_evento = tipo Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;
End;

Procedure RECUPERAPOS (L: TListaEventos; Var E: TEvento; pos: Integer);
Begin
  E := L.eventos[pos];
End;

End.
