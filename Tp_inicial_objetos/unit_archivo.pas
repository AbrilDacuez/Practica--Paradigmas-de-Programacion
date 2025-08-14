
Unit unit_archivo;

Interface

Uses unit_tipoeventos;

Type 
  ListaEventos = Object
    eventos: File Of TEvento;
    cant: integer;
    Procedure CREARLISTA;
    Procedure AGREGAR (E:TEvento; Var id: integer);
    Procedure BUSCARPORID(id: integer; Var pos: Integer);
    Procedure ELIMINAREVENTO (Var id: integer;Var encontrado:
                              boolean);
    Procedure BUSCAR_titulo(BUSCADO: String; Var L_aux:
                            Teventoaux);
    Procedure BUSCAR_entre_fechas(fecha1, fecha2: String; Var
                                  L_aux: Teventoaux);
    Procedure BUSCAR_tipo(tipo: TTipoEvento; Var L_aux:
                          Teventoaux);
    Procedure RECUPERAPOS (Var E: TEvento; pos: Integer);
  End;



Implementation
Procedure ListaEventos.CREARLISTA;

Var 
  nombreArchivo: string;
Begin
  nombreArchivo := 'eventos.dat';
  Assign(eventos, nombreArchivo);
  {$I-}
  Reset(eventos);
  {$I+}
  If IOResult <> 0 Then Rewrite(eventos);
  cant := FileSize(eventos);
End;

Procedure ListaEventos.AGREGAR (E:TEvento; Var id: integer);
Begin
  Reset(eventos);
  // o Rewrite si es nuevo
  Seek(eventos, cant);
  // id := FileSize(eventos);
  id := cant + 1;
  // Asignar un ID único
  E.id := id;
  // Asignar ID al evento
  Write(eventos, E);
  inc(cant);
  Close(eventos);
End;

Procedure ListaEventos.BUSCARPORID(id: integer; Var pos: Integer);

Var 
  enc: Boolean;
  i: Integer;
  eventoTemp: TEvento;
Begin
  enc := false;
  i := 0;
  pos := -1;
  While (i < cant) And Not enc Do
    Begin
      Seek(eventos, i);
      Read(eventos, eventoTemp);

      If eventoTemp.id = id Then
        enc := True
      Else
        Inc(i);
    End;
  If enc Then pos := i;
End;

Procedure ListaEventos.ELIMINAREVENTO (Var id: integer; Var encontrado:
                                       boolean);

Var 
  i, pos: Integer;
  eventoTemp: TEvento;
Begin
  Reset(eventos);

  ListaEventos.BUSCARPORID(id, pos);

  If pos <> -1 Then
    Begin
      encontrado := true;
      If pos = (cant - 1) Then
        Begin
          Truncate(eventos);
          Dec(cant);
        End
      Else
        Begin
          For i:= pos To (cant - 1) Do
            Begin
              Seek(eventos, i + 1);
              read(eventos, eventoTemp);
              Seek(eventos, i);
              Write(eventos, eventoTemp);
            End;
          Truncate(eventos);
          Dec(cant);
        End;
    End
  Else
    encontrado := false;

  Close(eventos);
End;

Procedure ListaEventos.BUSCAR_titulo(BUSCADO: String; Var L_aux:
                                     Teventoaux);

Var 
  aux, i: integer;
  E: TEvento;
Begin
  Reset(eventos);
  L_aux.cant := 0;
  For i:= 0 To (cant - 1) Do
    Begin
      Seek(eventos, i);
      Read(eventos, E);
      aux := Pos(LowerCase(BUSCADO), LowerCase(E.titulo));
      If aux > 0 Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;
  Close(eventos);
End;


Procedure ListaEventos.BUSCAR_entre_fechas(fecha1, fecha2: String; Var
                                           L_aux: Teventoaux);

Var 
  i: integer;
  E: TEvento;
Begin
  Reset(eventos);
  L_aux.cant := 0;
  For i:= 0 To (cant - 1) Do
    Begin
      Seek(eventos, i);
      Read(eventos, E);
      If (E.fechainicio >= fecha1) And (E.fechainicio <= fecha2) And
         (E.fechafin   >= fecha1) And (E.fechafin   <= fecha2) Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;

  Close(eventos);
End;


Procedure ListaEventos.BUSCAR_tipo(tipo: TTipoEvento; Var L_aux:
                                   Teventoaux);

Var 
  i: integer;
  E: TEvento;
Begin
  Reset(eventos);
  L_aux.cant := 0;
  For i:= 0 To (cant - 1) Do
    Begin
      Seek(eventos, i);
      Read(eventos, E);
      If E.t_evento = tipo Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;

  Close(eventos);
End;

Procedure ListaEventos.RECUPERAPOS (Var E: TEvento; pos: Integer);
Begin
  Reset(eventos);
  Seek(eventos, pos);
  Read(eventos, E);
  Close(eventos);
End;
End.
