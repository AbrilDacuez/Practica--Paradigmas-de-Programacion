
Unit unit_lista;

Interface

Uses unit_tipoeventos;

Type 
  Tipo_evento = TTipoEvento;
  ListaEventos = object
    eventos: array[0..200] Of TEvento;
    cant: integer;
Procedure CREARLISTA;
Procedure BUSCARPORID( id: integer; Var pos: Integer);
Procedure ELIMINAREVENTO (id: integer; Var encontrado:boolean);
Function LISTA_LLENA : BOOLEAN;
Procedure AGREGAR (Var  X:TEvento; Var id: integer);
Procedure BUSCAR_titulo( BUSCADO: String; Var L_aux:
                        Teventoaux);
Procedure BUSCAR_entre_fechas(fecha1, fecha2: String; Var
                              L_aux: Teventoaux);
Procedure BUSCAR_tipo( tipo: TTipoEvento; Var L_aux:
                      Teventoaux);
Procedure RECUPERAPOS (Var E: TEvento; pos: Integer);

end;


Implementation

Procedure ListaEventos.CREARLISTA;

Var i: integer;
Begin
  For i:=0 To 200 Do
    Begin
      eventos[i].id := i;
      eventos[i].fechainicio := '';
      eventos[i].fechafin := '';
      eventos[i].horainicio := '';
      eventos[i].horafin := '';
      eventos[i].ubicacion := '';
      eventos[i].titulo := '';
      eventos[i].descripcion := '';
      eventos[i].t_evento := otro;
      //inc(i);
    End;
  cant := 0;
  // Inicializar la cantidad de eventos a 0
End;

Procedure ListaEventos.BUSCARPORID( id: integer; Var pos: Integer);

Var 
  enc: Boolean;
  i: Integer;
Begin
  enc := false;
  i := 0;
  While (i <= cant) And (Not enc) Do
    Begin
      If eventos[i].id = id Then enc := true
      Else inc(i);
    End;
  If enc Then
    pos := i
End;

Procedure ListaEventos.ELIMINAREVENTO (id: integer; Var encontrado:
                          boolean);

Var 
  i, pos: integer;
Begin
  encontrado := false;
  pos := 0;
  ListaEventos.BUSCARPORID(id, pos);
  If pos <> 0 Then
    Begin
      encontrado := true;
      For i:= pos To cant Do
        Begin
          eventos[i].id := eventos[i+1].id;
          eventos[i].fechainicio := eventos[i+1].fechainicio;
          eventos[i].fechafin := eventos[i+1].fechafin;
          eventos[i].horainicio := eventos[i+1].horainicio;
          eventos[i].horafin := eventos[i+1].horafin;
          eventos[i].ubicacion := eventos[i+1].ubicacion;
          eventos[i].titulo := eventos[i+1].titulo;
          eventos[i].descripcion := eventos[i+1].descripcion;
        End;
      dec(cant);
    End
  Else
    encontrado := false;
End;

Function ListaEventos.LISTA_LLENA : BOOLEAN;
Begin
  LISTA_LLENA := cant=200;
End;

Procedure ListaEventos.AGREGAR (Var  X:TEvento; Var id: integer);
Begin
  If Not ListaEventos.LISTA_LLENA Then
    Begin
      eventos[cant] := X;
      // Agregar el nuevo evento al final del array
      id := cant + 1;
      eventos[cant].id := id;
      // Incrementar la cantidad de eventos
      inc(cant);
    End;
End;


Procedure ListaEventos.BUSCAR_titulo( BUSCADO: String; Var L_aux:
                        Teventoaux);

Var 
  aux, i: integer;
  E: TEvento;
Begin
  L_aux.cant := 0;

  For i:=0 To (cant - 1) Do
    Begin
      E := eventos[i];
      // eventos es un array
      aux := Pos(LowerCase(BUSCADO), LowerCase(E.titulo));
      If aux > 0 Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;
End;



Procedure ListaEventos.BUSCAR_entre_fechas(fecha1, fecha2: String; Var
                              L_aux: Teventoaux);

Var 
  i: integer;
  E: TEvento;
Begin
  L_aux.cant := 0;

  For i:=0 To (cant - 1) Do
    Begin
      E := eventos[i];
      If (E.fechainicio >= fecha1) And (E.fechainicio <= fecha2) And
         (E.fechafin   >= fecha1) And (E.fechafin   <= fecha2) Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;
End;


Procedure ListaEventos.BUSCAR_tipo( tipo: TTipoEvento; Var L_aux:
                      Teventoaux);

Var 
  i: integer;
  E: TEvento;
Begin
  L_aux.cant := 0;

  For i:=0 To (cant - 1) Do
    Begin
      E := eventos[i];
      If E.t_evento = tipo Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;
End;

Procedure ListaEventos.RECUPERAPOS (Var E: TEvento; pos: Integer);
Begin
  E := eventos[pos];
End;

End.
