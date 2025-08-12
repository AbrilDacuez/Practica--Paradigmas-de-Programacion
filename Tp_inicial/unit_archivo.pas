
Unit unit_archivo;

Interface

Uses unit_tipoeventos;

Type 
  TListaEventos = Record
    eventos: File Of TEvento;
    cant: integer;
  End;

Procedure CREARLISTA (Var L: TListaEventos);
Procedure AGREGAR (Var L:TListaEventos; E:TEvento; Var id: integer);
Procedure BUSCARPORID(L: TListaEventos; id: integer; Var pos: Integer);
Procedure ELIMINAREVENTO (Var L: TListaEventos; id: integer;Var encontrado:
                          boolean);
Procedure BUSCAR_titulo(L: TListaEventos; BUSCADO: String; Var L_aux:
                        Teventoaux);
Procedure BUSCAR_entre_fechas(L: TListaEventos; fecha1, fecha2: String; Var
                              L_aux: Teventoaux);
Procedure BUSCAR_tipo(L: TListaEventos; tipo: TTipoEvento; Var L_aux:
                      Teventoaux);
Procedure RECUPERAPOS (L: TListaEventos; Var E: TEvento; pos: Integer);

Implementation
Procedure CREARLISTA (Var L: TListaEventos);

Var 
  nombreArchivo: string;
Begin
  nombreArchivo := 'eventos.dat';
  Assign(L.eventos, nombreArchivo);
  {$I-}
  Reset(L.eventos);
  {$I+}
  If IOResult <> 0 Then Rewrite(L.eventos);
  L.cant := FileSize(L.eventos);
End;

Procedure AGREGAR (Var L:TListaEventos; E:TEvento; Var id: integer);
Begin
  Reset(L.eventos);
  // o Rewrite si es nuevo
  Seek(L.eventos, L.cant);
  id := FileSize(L.eventos) + 1;
  // Asignar un ID único
  E.id := id;
  // Asignar ID al evento
  Write(L.eventos, E);
  inc(L.cant);
  Close(L.eventos);
End;

Procedure BUSCARPORID(L: TListaEventos; id: integer; Var pos: Integer);

Var 
  enc: Boolean;
  i: Integer;
  eventoTemp: TEvento;
Begin
  enc := false;
  i := 0;
  pos := -1;
  While (i < L.cant) And Not enc Do
    Begin
      Seek(L.eventos, i);
      Read(L.eventos, eventoTemp);

      If eventoTemp.id = id Then
        enc := True
      Else
        Inc(i);
    End;
  If enc Then pos := i;
End;

Procedure ELIMINAREVENTO (Var L: TListaEventos; id: integer;Var encontrado:
                          boolean);

Var 
  i, pos: Integer;
  eventoTemp: TEvento;
Begin
  Reset(L.eventos);

  BUSCARPORID(L, id, pos);

  If pos <> -1 Then
    Begin
      For i:= pos To L.cant Do
        Begin
          Seek(L.eventos, i + 1);
          read(L.eventos, eventoTemp);
          Seek(L.eventos, i);
          Write(L.eventos, eventoTemp);
        End;
      Truncate(L.eventos);
      Dec(L.cant);
    End
  Else
    encontrado := false;

  Close(L.eventos);
End;

Procedure BUSCAR_titulo(L: TListaEventos; BUSCADO: String; Var L_aux:
                        Teventoaux);

Var 
  aux, i: integer;
  E: TEvento;
Begin
  Reset(L.eventos);
  L_aux.cant := 0;
  For i:= 0 To (L.cant - 1) Do
    Begin
      Seek(L.eventos, i);
      Read(L.eventos, E);
      aux := Pos(LowerCase(BUSCADO), LowerCase(E.titulo));
      If aux > 0 Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;
  Close(L.eventos);
End;


Procedure BUSCAR_entre_fechas(L: TListaEventos; fecha1, fecha2: String; Var
                              L_aux: Teventoaux);

Var 
  i: integer;
  E: TEvento;
Begin
  Reset(L.eventos);
  L_aux.cant := 0;
  For i:= 0 To (L.cant - 1) Do
    Begin
      Seek(L.eventos, i);
      Read(L.eventos, E);
      If (E.fechainicio >= fecha1) And (E.fechainicio <= fecha2) And
         (E.fechafin   >= fecha1) And (E.fechafin   <= fecha2) Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;

  Close(L.eventos);
End;


Procedure BUSCAR_tipo(L: TListaEventos; tipo: TTipoEvento; Var L_aux:
                      Teventoaux);

Var 
  i: integer;
  E: TEvento;
Begin
  Reset(L.eventos);
  L_aux.cant := 0;
  For i:= 0 To (L.cant - 1) Do
    Begin
      Seek(L.eventos, i);
      Read(L.eventos, E);
      If E.t_evento = tipo Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;

  Close(L.eventos);
End;

Procedure RECUPERAPOS (L: TListaEventos; Var E: TEvento; pos: Integer);
Begin
  Reset(L.eventos);
  Seek(L.eventos, pos);
  Read(L.eventos, E);
  Close(L.eventos);
End;
End.
