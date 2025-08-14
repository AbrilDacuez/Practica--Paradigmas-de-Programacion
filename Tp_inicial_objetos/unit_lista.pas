
Unit unit_lista;

Interface

Uses unit_tipoeventos;

Type 
  Lista = Object
    datos: array[0..200] Of TDato;
    cant: integer;
    Procedure CREAR(var NombreLista: string);
    Procedure AGREGAR (E:TDato; Var id: integer);
    Procedure BUSCARPORID(id: integer; Var pos: Integer);
    Procedure ELIMINAR (Var id: integer;Var encontrado: boolean);
    Procedure RECUPERAPOS (Var E: TDato; pos: Integer);
    Function TAMANO: integer;
    Procedure FINALIZAR;
    Procedure DESTRUIR (L_aux: Lista);
    Function LISTA_LLENA : BOOLEAN;
    Procedure BUSCAR_titulo(BUSCADO: string; Var L_aux:Lista);
    Procedure BUSCAR_entre_fechas(fecha1, fecha2: String; Var L_aux:Lista);
    Procedure BUSCAR_tipo(tipo: TTipoEvento; var L_aux:Lista);
  End;


Implementation

Procedure Lista.CREAR(var NombreLista: string);
Begin
  cant := 0;
End;

Procedure Lista.AGREGAR (E:TDato; Var id: integer);

Begin
  If Not self.LISTA_LLENA Then
    Begin
      datos[cant] := E;
      id := cant + 1;
      datos[cant].id := id;
      inc(cant);
    End;
End;

Procedure Lista.BUSCARPORID(id: integer; Var pos: Integer);

var
  i: Integer;
begin
  pos := -1;                      
  for i := 0 to cant - 1 do       
    if datos[i].id = id then
    begin
      pos := i;
      Exit;
    end;
end;

Procedure Lista.ELIMINAR (Var id: integer;Var encontrado: boolean);

var
  i, pos: integer;
begin
  self.BUSCARPORID(id, pos);
  if pos = -1 then
  begin
    encontrado := False;
    Exit;
  end;

  // Desplazar a la izquierda desde 'pos' hasta el penúltimo
  for i := pos to cant - 2 do
    datos[i] := datos[i+1];

  Dec(cant);
  encontrado := True;
end;

Procedure Lista.RECUPERAPOS (Var E: TDato; pos: Integer);
Begin
  E := datos[pos];
End;


Function Lista.TAMANO: Integer;
Begin
  TAMANO := cant;
End;

Procedure Lista.FINALIZAR;
Begin
End;

Procedure Lista.DESTRUIR (L_aux: Lista);
Begin
  L_aux.cant := 0;
End;

Function Lista.LISTA_LLENA : BOOLEAN;
Begin
  LISTA_LLENA := cant=200;
End;

Procedure Lista.BUSCAR_titulo( BUSCADO: String; Var L_aux: Lista);

Var 
  aux, i: integer;
  E: TDato;
Begin
  L_aux.cant := 0;

  For i:=0 To (cant - 1) Do
    Begin
      E := datos[i];
      aux := Pos(LowerCase(BUSCADO), LowerCase(E.titulo));
      If aux > 0 Then
        Begin
          L_aux.datos[L_aux.cant] := E;
          inc(L_aux.cant);
        End;
    End;
End;



Procedure Lista.BUSCAR_entre_fechas(fecha1, fecha2: String; Var L_aux: Lista);

Var 
  i: integer;
  E: TDato;
Begin
  L_aux.cant := 0;

  For i:=0 To (cant - 1) Do
    Begin
      E := datos[i];
      If (E.fechainicio >= fecha1) And (E.fechainicio <= fecha2) And
         (E.fechafin   >= fecha1) And (E.fechafin   <= fecha2) Then
        Begin
          L_aux.datos[L_aux.cant] := E;
          inc(L_aux.cant);
        End;
    End;
End;


Procedure Lista.BUSCAR_tipo( tipo: TTipoEvento; Var L_aux: Lista);

Var 
  i: integer;
  E: TDato;
Begin
  L_aux.cant := 0;

  For i:=0 To (cant - 1) Do
    Begin
      E := datos[i];
      If E.t_evento = tipo Then
        Begin
          L_aux.datos[L_aux.cant] := E;
          inc(L_aux.cant);
        End;
    End;
End;

End.
