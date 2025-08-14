
Unit unit_archivo;

Interface

Uses unit_tipoeventos;

Type 
  Lista = Object
    datos: File Of TDato;
    Procedure CREAR(var nombreArchivo: string);
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

Procedure Lista.CREAR(var nombreArchivo: string);

Begin
  Assign(datos, nombreArchivo);
  {$I-}
  Reset(datos);
  {$I+}
  If IOResult <> 0 Then Rewrite(datos);
End;

Procedure Lista.AGREGAR (E:TDato; Var id: integer);
Begin
  if not self.LISTA_LLENA Then
  Begin
    Seek(datos, self.TAMANO);
    id := self.TAMANO + 1;
    E.id := id;
    Write(datos, E);
  End;
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

Procedure Lista.ELIMINAR (Var id: integer; Var encontrado: boolean);

Var 
  i, pos: Integer;
  eventoTemp: TDato;
Begin
  self.BUSCARPORID(id, pos);

  If pos <> -1 Then
    Begin
      If pos = (self.TAMANO - 1) Then
        begin
        seek(self.datos, self.TAMANO - 1);
        Truncate(self.datos);
        encontrado := true;
      end
      Else
        Begin
          For i:= pos To (self.TAMANO - 2) Do
            Begin
              Seek(self.datos, i + 1);
              read(self.datos, eventoTemp);
              Seek(self.datos, i);
              Write(self.datos, eventoTemp);
            End;
          Truncate(self.datos);
          encontrado := true;
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

Function Lista.TAMANO: Integer;
Begin
  TAMANO := FileSize(datos);
End;

Procedure Lista.FINALIZAR;
Begin
  Close(datos);
End;

Procedure Lista.DESTRUIR (L_aux: Lista);
begin
  L_aux.FINALIZAR;
  Erase(L_aux.datos);
End;

Function Lista.LISTA_LLENA : BOOLEAN;
Begin
  LISTA_LLENA := self.TAMANO = 200;
End;

Procedure Lista.BUSCAR_titulo(BUSCADO: string; Var L_aux:Lista);
Var 
  aux, i: integer;
  E: TDato;
  nombrearchaux:string;
Begin
  nombrearchaux := 'auxiliar.dat';
  L_aux.CREAR(nombrearchaux);

  for i := 0 to self.TAMANO - 1 do
  begin
    Seek(datos, i);
    Read(datos, E);
    aux := Pos(LowerCase(BUSCADO), LowerCase(E.titulo));
    if aux > 0 then
    begin
      Seek(L_aux.datos, FileSize(L_aux.datos));
      Write(L_aux.datos, E);
    end;
  end;
End;


Procedure Lista.BUSCAR_entre_fechas(fecha1, fecha2: String; Var L_aux: Lista);

Var 
  i: integer;
  E: TDato;
  nombrearchaux:string;
Begin
  
  nombrearchaux := 'auxiliar.dat';
  L_aux.CREAR(nombrearchaux);
  For i:= 0 To (self.TAMANO - 1) Do
    Begin
      Seek(datos, i);
      Read(datos, E);
      If (E.fechainicio >= fecha1) And (E.fechainicio <= fecha2) And
         (E.fechafin   >= fecha1) And (E.fechafin   <= fecha2) Then
        Begin
          Seek(L_aux.datos, FileSize(L_aux.datos));
          Write(L_aux.datos, E);
        End;
    End;
End;


Procedure Lista.BUSCAR_tipo(tipo: TTipoEvento; Var L_aux:Lista);

Var 
  i: integer;
  E: TDato;
  nombrearchaux:string;
Begin
  
  nombrearchaux := 'auxiliar.dat';
  L_aux.CREAR(nombrearchaux);
  For i:= 0 To (self.TAMANO - 1) Do
    Begin
      Seek(datos, i);
      Read(datos, E);
      If E.t_evento = tipo Then
        Begin
          Seek(L_aux.datos, FileSize(L_aux.datos));
          Write(L_aux.datos, E);
        End;
    End;
End;

End.
