
Unit unit_archivo;

Interface

Uses unit_tipoeventos;

Type 
  Lista = Object
    datos: File Of TDato;
    Procedure CREAR;
    Procedure AGREGAR (E:TDato; Var id: integer);
    Procedure BUSCARPORID(id: integer; Var pos: Integer);
    Procedure ELIMINAR (Var id: integer;Var encontrado:
                        boolean);
    Procedure RECUPERAPOS (Var E: TDato; pos: Integer);
    Function TAMANO: integer;
    Procedure FINALIZAR;
    Procedure BUSCAR_titulo(BUSCADO: String; Var L_aux:
                            Teventoaux);
    Procedure BUSCAR_entre_fechas(fecha1, fecha2: String; Var
                                  L_aux: Teventoaux);
    Procedure BUSCAR_tipo(tipo: TTipoEvento; Var L_aux:
                          Teventoaux);
  End;

Implementation
Function Lista.TAMANO: Integer;
Begin
  self.TAMANO := FileSize(datos);
End;

Procedure Lista.FINALIZAR;
Begin
  Close(datos);
End;

Procedure Lista.CREARLISTA;

Var 
  nombreArchivo: string;
Begin
  nombreArchivo := 'datos.dat';
  Assign(datos, nombreArchivo);
  {$I-}
  Reset(datos);
  {$I+}
  If IOResult <> 0 Then Rewrite(datos);
End;

Procedure Lista.AGREGAR (E:TDato; Var id: integer);
Begin
  Seek(datos, self.TAMANO);
  id := self.TAMANO + 1;
  // Asignar un ID único
  E.id := id;
  // Asignar ID al evento
  Write(datos, E);
End;

Procedure Lista.BUSCARPORID(id: integer; Var pos: Integer);

Var 
  enc: Boolean;
  i: Integer;
  eventoTemp: TDato;
Begin
  enc := false;
  i := 0;
  pos := -1;
  While (i < self.TAMANO) And Not enc Do
    Begin
      Seek(datos, i);
      Read(datos, eventoTemp);

      If eventoTemp.id = id Then
        enc := True
      Else
        Inc(i);
    End;
  If enc Then pos := i;
End;

Procedure Lista.ELIMINAREVENTO (Var id: integer; Var encontrado:
                                boolean);

Var 
  i, pos: Integer;
  eventoTemp: TDato;
Begin
  Lista.BUSCARPORID(id, pos);

  If pos <> -1 Then
    Begin
      encontrado := true;
      If pos = (self.TAMANO - 1) Then
        Truncate(datos)
      Else
        Begin
          For i:= pos To (self.TAMANO - 1) Do
            Begin
              Seek(datos, i + 1);
              read(datos, eventoTemp);
              Seek(datos, i);
              Write(datos, eventoTemp);
            End;
          Truncate(datos);
        End;
    End
  Else
    encontrado := false;
End;


Procedure Lista.RECUPERAPOS (Var E: TDato; pos: Integer);
Begin
  Seek(datos, pos);
  Read(datos, E);
End;

Procedure Lista.BUSCAR_titulo(BUSCADO: String; Var L_aux:
                              Teventoaux);

Var 
  aux, i: integer;
  E: TDato;
Begin
  Reset(datos);
  L_aux.cant := 0;
  For i:= 0 To (cant - 1) Do
    Begin
      Seek(datos, i);
      Read(datos, E);
      aux := Pos(LowerCase(BUSCADO), LowerCase(E.titulo));
      If aux > 0 Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;
  Close(datos);
End;


Procedure Lista.BUSCAR_entre_fechas(fecha1, fecha2: String; Var
                                    L_aux: Teventoaux);

Var 
  i: integer;
  E: TDato;
Begin
  Reset(datos);
  L_aux.cant := 0;
  For i:= 0 To (cant - 1) Do
    Begin
      Seek(datos, i);
      Read(datos, E);
      If (E.fechainicio >= fecha1) And (E.fechainicio <= fecha2) And
         (E.fechafin   >= fecha1) And (E.fechafin   <= fecha2) Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;

  Close(datos);
End;


Procedure Lista.BUSCAR_tipo(tipo: TTipoEvento; Var L_aux:
                            Teventoaux);

Var 
  i: integer;
  E: TDato;
Begin
  Reset(datos);
  L_aux.cant := 0;
  For i:= 0 To (cant - 1) Do
    Begin
      Seek(datos, i);
      Read(datos, E);
      If E.t_evento = tipo Then
        Begin
          inc(L_aux.cant);
          L_aux.posiciones[L_aux.cant] := i;
        End;
    End;

  Close(datos);
End;
End.
