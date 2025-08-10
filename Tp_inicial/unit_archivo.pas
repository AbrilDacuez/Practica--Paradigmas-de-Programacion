
Unit unit_archivo;

Interface

Uses unit_tipoeventos;

Procedure CREARLISTA (Var L: TListaEventos);
Procedure AGREGAR (Var L:TListaEventos; E:TEvento; Var id: integer);
Procedure ELIMINAREVENTO (Var L: TListaEventos; id: integer, flag:boolean);
Function LISTA_LLENA(Var L: TListaEventos): BOOLEAN;
Function Lista_vacia (Var L: TListaEventos): boolean;
Function TTipoEventoF(tipo:Integer): TTipoEvento;
Procedure pedir_datos (Var E:TEvento, tipo:integer);
Procedure Muestra_datos(E: TEvento);
Procedure MUESTRA_LISTA(L: TListaEventos);
Procedure BUSCAR_titulo(L: TListaEventos; BUSCADO: String);
Procedure BUSCAR_entre_fechas(L: TListaEventos; fecha1, fecha2: String);
Procedure BUSCAR_tipo(L: TListaEventos; tipo: TTipoEvento);



Implementation
Procedure CREARLISTA (Var L: TListaEventos);
var 
nombreArchivo: string;
Begin
  nombreArchivo := 'eventos.dat';
  L.cant:=0;
  Assign(L.eventos, nombreArchivo);
  {$I-}
  Reset(L.eventos);
  {$I+}
  If IOResult <> 0 Then Rewrite(L.eventos);  
End;

Procedure AGREGAR (Var L:TListaEventos; E:TEvento; Var id: integer);
Begin
  Reset(L.eventos);  // o Rewrite si es nuevo
  Seek(L.eventos, FileSize(L.eventos)); 
  id := FileSize(L.eventos) + 1; // Asignar un ID único
  E.id := id; // Asignar ID al evento
  Write(L.eventos, E);
  Close(L.eventos);
End;

Procedure ELIMINAREVENTO (Var L: TListaEventos; id: integer,var encontrado:boolean);
Var
  i, total: Integer;
  eventoTemp: TEvento;
Begin
  encontrado := False;

  Reset(L.eventos);
  total := FileSize(L.eventos);

  i := 0;
  While (i < total) Do
  Begin
    Seek(L.eventos, i);
    Read(L.eventos, eventoTemp);

    If (not encontrado) and (eventoTemp.id = id) Then
    Begin
      encontrado := True;
      // No copiamos este registro (se "elimina")
    End
    Else If encontrado Then
    Begin
      // Solo desplazamos registros si no es el último registro
      If i < total - 1 Then
      Begin
        Seek(L.eventos, i + 1);
        Read(L.eventos, eventoTemp);
        Seek(L.eventos, i);
        Write(L.eventos, eventoTemp);
      End;
    End;

    Inc(i);
  End;

  If encontrado Then
  Begin
    Seek(L.eventos, total - 1);
    Truncate(L.eventos);
    Dec(L.cant);
  End;

  Close(L.eventos);
End;





Function LISTA_LLENA(Var L: TListaEventos): BOOLEAN;
Begin
  Reset(L.eventos);
  LISTA_LLENA := False;
  Close(L.eventos);
End;

Function Lista_vacia (Var L: TListaEventos): boolean;
Begin
  Reset(L.eventos);
  Lista_Vacia := FileSize(L.eventos) = 0;
  Close(L.eventos);
End;

Function TTipoEventoF(tipo:Integer): TTipoEvento;
begin
  Case tipo Of 
    0: TTipoEventoF := cumple;
    1: TTipoEventoF := reunion;
    Else TTipoEventoF := otro;
  End;
end;

Procedure MUESTRA_LISTA(L: TListaEventos);
Var
  E: TEvento;
Begin
  Reset(L.eventos);
  While Not Eof(L.eventos) Do
  Begin
    Read(L.eventos, E);
    Muestra_datos(E);
  End;
  Close(L.eventos);
End;

Procedure BUSCAR_titulo(L: TListaEventos; BUSCADO: String; var pos: integer; var encontrado: boolean; var E: TEvento);
Var
  aux: integer;
Begin
  encontrado := False;
  Reset(L.eventos);
  if pos = 0 then
  Seek(L.eventos, pos - 1) else Seek(L.eventos,pos);
  while (FilePos(L.eventos) < FileSize(L.eventos)) and (not encontrado) do
  begin
    Read(L.eventos, E);
    aux := Pos(LowerCase(BUSCADO), LowerCase(E.titulo));
    if aux > 0 then
    begin
      encontrado := True;
      pos := FilePos(L.eventos); 
    end;
  end;
  Close(L.eventos);
end;


Procedure BUSCAR_entre_fechas(L: TListaEventos; fecha1, fecha2: String; var encontrado: boolean; var pos: integer; var E: TEvento);
begin
  encontrado := false;
  Reset(L.eventos);
  Seek(L.eventos, pos - 1); // convertir índice humano a índice de archivo (0-based)

  while (FilePos(L.eventos) < FileSize(L.eventos)) and (not encontrado) do
  begin
    Read(L.eventos, E);
    if (E.fechainicio >= fecha1) and (E.fechainicio <= fecha2) and
       (E.fechafin   >= fecha1) and (E.fechafin   <= fecha2) then
    begin
      encontrado := true;
      pos := FilePos(L.eventos) + 1; // dejar lista para la próxima búsqueda
    end;
  end;

  Close(L.eventos);
end;


Procedure BUSCAR_tipo(L: TListaEventos; tipo: TTipoEvento; var encontrado: boolean; var pos: integer; var E: TEvento);
begin
  encontrado := false;
  Reset(L.eventos);
  if pos = 0 then
  Seek(L.eventos, pos - 1) else 
  Seek(L.eventos,pos);
  while (FilePos(L.eventos) < FileSize(L.eventos)) and (not encontrado) do
  begin
    Read(L.eventos, E);
    if E.t_evento = tipo then
    begin
      encontrado := true;
      pos := FilePos(L.eventos) + 1; 
    end;
  end;

  Close(L.eventos);
end;


end.





End.