
Unit unit_archivo;

Interface

Type 

  TTipoEvento = (cumple, reunion, otro);

  TEvento = Record
    id: integer;
    fechainicio: string[10];
    fechafin: string[10];
    horainicio: string;
    horafin: string;
    ubicacion: string;
    titulo: string;
    descripcion: string;
    t_evento: TTipoEvento;
  End;

  Teventos = file Of TEvento;

  TListaEventos = Record
    cant: integer;
    eventos: Teventos;
  End;


Procedure CREARLISTA (Var L:TListaEventos);
Procedure ELIMINAREVENTO (Var L:TListaEventos; id: integer);
Function LISTA_LLENA (Var L:TListaEventos): BOOLEAN;
Function LISTA_VACIA (Var L:TListaEventos): BOOLEAN;
Procedure AGREGAR (Var L:TListaEventos; E:TEvento; Var id: integer);
Procedure MUESTRA_LISTA(L:TListaEventos);
Procedure BUSCAR_titulo (L:TListaEventos; BUSCADO:String);
Procedure BUSCAR_entre_fechas(L:TListaEventos; fecha1,fecha2:String);
Procedure BUSCAR_tipo (L:TListaEventos; tipo:TTipoEvento);


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

Procedure ELIMINAREVENTO (Var L: TListaEventos; id: integer);
Var
  i, total: Integer;
  eventoTemp: TEvento;
  encontrado: Boolean;
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
  End
  Else
    WriteLn('No se encontró el evento con ID ', id);

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

Procedure pedir_datos (Var E:TEvento);
Var
  tipo: Integer;
Begin
  //Write('ID: '); E.id:=0; ID se asigna en el agregar
  Write('Título: '); Readln(E.titulo);
  Write('Descripción: '); Readln(E.descripcion);
  Write('Ubicación: '); Readln(E.ubicacion);
  Write('Fecha inicio (YYYY-MM-DD): '); Readln(E.fechainicio);
  Write('Fecha fin (YYYY-MM-DD): '); Readln(E.fechafin);
  Write('Hora inicio (HH:MM): '); Readln(E.horainicio);
  Write('Hora fin (HH:MM): '); Readln(E.horafin);
  Write('Tipo de evento (0: cumple, 1: reunión, 2: otro): '); Readln(tipo);
  E.t_evento := TTipoEventoF(tipo);
End;

Procedure Muestra_datos(E: TEvento);
Begin
  Writeln('ID: ', E.id);
  Writeln('Título: ', E.titulo);
  Writeln('Descripción: ', E.descripcion);
  Writeln('Ubicación: ', E.ubicacion);
  Writeln('Fecha Inicio: ', E.fechainicio, '  Hora Inicio: ', E.horainicio);
  Writeln('Fecha Fin: ', E.fechafin, '  Hora Fin: ', E.horafin);
  Write('Tipo de evento: ');
  Case E.t_evento of
    cumple: Writeln('Cumpleaños');
    reunion: Writeln('Reunión');
    otro: Writeln('Otro');
  End;
  Writeln('------------------------');
End;

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

Procedure BUSCAR_titulo(L: TListaEventos; BUSCADO: String);
Var
  E: TEvento;
  aux:integer;
  ENC:BOOLEAN;
Begin
  ENC := False;
  Reset(L.eventos);
  While Not Eof(L.eventos) Do
  Begin
    Read(L.eventos, E);
    aux := Pos(LowerCase(BUSCADO), LowerCase(E.titulo));
    If aux > 0 Then
    Begin
      Muestra_datos(E);
      ENC := True;
    End;
  End;
  Close(L.eventos);
End;

Procedure BUSCAR_entre_fechas(L: TListaEventos; fecha1, fecha2: String);
Var
  E: TEvento;
  ENC:BOOLEAN;
Begin
  ENC := False;
  Reset(L.eventos);
  While Not Eof(L.eventos) Do
  Begin
    Read(L.eventos, E);
    If (E.fechainicio >= fecha1) And (E.fechafin <= fecha2) Then
    Begin
      Muestra_datos(E);
      ENC := True;
    End;
  End;
  Close(L.eventos);
End;

Procedure BUSCAR_tipo(L: TListaEventos; tipo: TTipoEvento);
Var
  E: TEvento;
  cont: Integer;
Begin
  cont := 0;
  Reset(L.eventos);  

  While Not EOF(L.eventos) Do
  Begin
    Read(L.eventos, E);
    If E.t_evento = tipo Then
    Begin
      Muestra_datos(E);
      Inc(cont);
    End;
  End;

  Close(L.eventos);

  If cont = 0 Then
    WriteLn('No hay coincidencias');
End;





End.