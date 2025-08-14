
Unit unit_lista;

Interface

Uses unit_tipoeventos;

Type 
  Lista = Object
    datos: array[0..200] Of TDato;
    cant: integer;
    Procedure CREAR;
    Procedure AGREGAR (Var  X:TEvento; Var id: integer);
    Procedure BUSCARPORID( id: integer; Var pos: Integer);
    Procedure ELIMINAR (id: integer; Var encontrado:boolean);
    Procedure RECUPERAPOS (Var E: TEvento; pos: Integer);
    Function TAMANO: integer;
    Procedure FINALIZAR;
    Function LISTA_LLENA : BOOLEAN;
    Procedure BUSCAR_titulo( BUSCADO: String; Var L_aux:
                            Teventoaux);
    Procedure BUSCAR_entre_fechas(fecha1, fecha2: String; Var
                                  L_aux: Teventoaux);
    Procedure BUSCAR_tipo( tipo: TTipoEvento; Var L_aux:
                          Teventoaux);

  End;


Implementation

Function Lista.TAMANO: Integer;
Begin
  self.TAMANO := cant;
End;

Procedure Lista.FINALIZAR;
Begin

End;

Procedure Lista.CREAR;

Var i: integer;
Begin
  cant := 0;
  // Inicializar la cantidad de datos a 0
End;

Procedure Lista.BUSCARPORID( id: integer; Var pos: Integer);

Var 
  enc: Boolean;
  i: Integer;
Begin
  enc := false;
  i := 0;
  While (i <= cant) And (Not enc) Do
    Begin
      If datos[i].id = id Then enc := true
      Else inc(i);
    End;
  If enc Then
    pos := i
End;

Procedure Lista.ELIMINAR (id: integer; Var encontrado:
                          boolean);

Var 
  i, pos: integer;
Begin
  encontrado := false;
  pos := 0;
  self.BUSCARPORID(id, pos);
  If pos <> 0 Then
    Begin
      encontrado := true;
      For i:= pos To cant Do
        Begin
          datos[i] := datos[i+1];
        End;
      dec(cant);
    End
  Else
    encontrado := false;
End;

Function Lista.LISTA_LLENA : BOOLEAN;
Begin
  self.LISTA_LLENA := cant=200;
End;

Procedure Lista.AGREGAR (Var  X:TEvento; Var id: integer);
Begin
  If Not self.LISTA_LLENA Then
    Begin
      datos[cant] := X;
      // Agregar el nuevo evento al final del array
      id := cant + 1;
      datos[cant].id := id;
      // Incrementar la cantidad de datos
      inc(cant);
    End;
End;

Procedure Lista.RECUPERAPOS (Var E: TEvento; pos: Integer);
Begin
  E := datos[pos];
End;

Procedure Lista.BUSCAR_titulo( BUSCADO: String; Var L_aux:
                              Teventoaux);

Var 
  aux, i: integer;
  E: TEvento;
Begin
  L_aux.cant := 0;

  For i:=0 To (cant - 1) Do
    Begin
      E := datos[i];
      // datos es un array
      aux := Pos(LowerCase(BUSCADO), LowerCase(E.titulo));
      If aux > 0 Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;
End;



Procedure Lista.BUSCAR_entre_fechas(fecha1, fecha2: String; Var
                                    L_aux: Teventoaux);

Var 
  i: integer;
  E: TEvento;
Begin
  L_aux.cant := 0;

  For i:=0 To (cant - 1) Do
    Begin
      E := datos[i];
      If (E.fechainicio >= fecha1) And (E.fechainicio <= fecha2) And
         (E.fechafin   >= fecha1) And (E.fechafin   <= fecha2) Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;
End;


Procedure Lista.BUSCAR_tipo( tipo: TTipoEvento; Var L_aux:
                            Teventoaux);

Var 
  i: integer;
  E: TEvento;
Begin
  L_aux.cant := 0;

  For i:=0 To (cant - 1) Do
    Begin
      E := datos[i];
      If E.t_evento = tipo Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;
End;

End.
