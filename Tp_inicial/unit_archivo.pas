
Unit unit_archivo;

Interface

Type 
  TEvento = Record
    id: integer;
    fechainicio: string[10];
    fechafin: string[10];
    horainicio: string;
    horafin: string;
    ubicacion: string;
    titulo: string;
    descripcion: string;
    t_evento: (cumple, reunion, otro);
  End;

  Teventos = file Of TEvento;

  TListaEventos = Record
    cant: integer;
    eventos: Teventos;
  End;

Procedure CREARLISTA (Var L:TListaEventos);
Procedure ELIMINAREVENTO (Var L:TListaEventos; buscado: integer; Var X:TEvento);
// Function LISTA_LLENA (Var L:TListaEventos): BOOLEAN;
// Function LISTA_VACIA (Var L:TListaEventos): BOOLEAN;
// Procedure AGREGAR (Var L:TListaEventos; X:TEvento);
// Procedure pedir_datos (Var E:TEvento);
// Procedure Muestra_datos (E:TEvento);
// Procedure MUESTRA_LISTA(L:TListaEventos);
// //LISTADO
// Procedure BUSCAR_titulo (L:TListaEventos; BUSCADO:String; Var ENC:BOOLEAN);
// Procedure BUSCAR_entre_fechas(L:TListaEventos; fecha1,fecha2:String; Var ENC:
//                               BOOLEAN);
// //SI BUSCA POR CAMPO CLAVE O TIPO SIMPLE EN INFO
// Procedure BUSCAR_tipo (L:TListaEventos; BUSCADO:String; Var ENC:BOOLEAN);

Implementation
Procedure CREARLISTA (Var L:TListaEventos_arc);
Begin
  Reset(L.cant);
End;

Procedure ELIMINAREVENTO (Var L: TListaEventos_arc; buscado: integer; Var X:
                          TEvento_arc);

Var i: integer;
  enc: Boolean;
Begin
  i := 0;
  enc := false;
  While (i < L.cant) And (Not enc) Do
    Begin
      seek(L.eventos, i);
      read(L.eventos, X);
      inc(i);
      If (X.id = buscado) Then enc := true;
    End;
  writeln('id: ', x.id);
  writeln('nombre: ', x.nombre);
  While (i < L.cant) And (Not Eof(L.eventos)) Do
    Begin

    End;


End;

End.
