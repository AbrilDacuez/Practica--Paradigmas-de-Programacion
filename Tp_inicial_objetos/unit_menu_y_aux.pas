
Unit unit_menu_y_aux;

Interface

Uses 
//  unit_lista, unit_tipoeventos;
unit_archivo, unit_tipoeventos;

Type 
  interfacemenu = Object
    L: ListaEventos;
    Procedure cargar_datos( Var id: integer);
    Procedure eliminar;
    Procedure MUESTRA_LISTA;
    Procedure busqueda_titulo;
    Procedure buscarfechas;
    Procedure buscartipo;
    Procedure menu();

  End;


Implementation

Function cambia_fecha(fecha:String): string;

Var 
  dia,mes,anio: string;
Begin
  dia := copy(fecha,1,2);
  mes := copy(fecha,4,2);
  anio := copy(fecha,7,4);
  cambia_fecha := anio+'/'+mes+'/'+dia;
End;

Procedure interfacemenu.cargar_datos( Var id: integer);

Var 
  tipo: byte;
  E: TEvento;
Begin
  writeln('Ingrese titulo del evento:');
  readln(E.titulo);
  writeln('Ingrese descripcion del evento:');
  readln(E.descripcion);
  writeln('Ingrese fecha de inicio (dd/mm/yyyy):');
  readln(E.fechainicio);
  E.fechainicio := cambia_fecha(E.fechainicio);
  writeln('Ingrese fecha de fin (dd/mm/yyyy):');
  readln(E.fechafin);
  E.fechafin := cambia_fecha(E.fechafin);
  writeln('Ingrese hora de inicio (hh:mm):');
  readln(E.horainicio);
  writeln('Ingrese hora de fin (hh:mm):');
  readln(E.horafin);
  writeln('Ingrese ubicacion del evento:');
  readln(E.ubicacion);
  writeln('Ingrese tipo de evento (1: cumple, 2: reunion, 3: otro):');
  readln(tipo);
  Case tipo Of 
    1: E.t_evento := cumple;
    2: E.t_evento := reunion;
    Else E.t_evento := otro;
  End;

  L.AGREGAR(E, id);
  // lo agrego a la lista
End;

Procedure interfacemenu.eliminar;

Var 
  id: integer;
  encontrado: boolean;
Begin
  Write('Ingrese el id a eliminar: ');
  ReadLn(id);

  L.ELIMINAREVENTO( id, encontrado);
  If encontrado Then
    Writeln('Evento eliminado con exito')
  Else
    Writeln('No se encontro el evento con ID: ', id);
End;

Procedure Muestra_datos (E:TEvento);
Begin
  writeln('ID: ', E.id);
  writeln('Fecha Inicio: ', E.fechainicio);
  writeln('Fecha Fin: ', E.fechafin);
  writeln('Hora Inicio: ', E.horainicio);
  writeln('Hora Fin: ', E.horafin);
  writeln('Ubicación: ', E.ubicacion);
  writeln('Título: ', E.titulo);
  writeln('Descripción: ', E.descripcion);
  writeln('Tipo de Evento: ', E.t_evento);
End;

Procedure interfacemenu.MUESTRA_LISTA;

Var 
  i: Integer;
  E: TEvento;
Begin
  For i:= 0 To (L.cant - 1) Do
    Begin
      L.RECUPERAPOS( E, i);
      Muestra_datos(E);
    End;
End;

Procedure MUESTRA_LISTA_AUX (Var L:ListaEventos; Var L_aux: Teventoaux);

Var 
  i: Integer;
  E: TEvento;
Begin
  For i:= 1 To L_aux.cant Do
    Begin
      L.RECUPERAPOS( E, L_aux.posiciones[i]);
      Muestra_datos(E);
    End;
End;

Procedure interfacemenu.busqueda_titulo;

Var 
  sub: string;
  l_aux: Teventoaux;
Begin
  Write('Ingrese la palabra del título: ');
  ReadLn(sub);

  // arrancamos desde el primero
  L.BUSCAR_titulo( sub, l_aux);

  If l_aux.cant = 0 Then
    Writeln('No se encontró ningún evento con ese título.')
  Else
    MUESTRA_LISTA_AUX(L, l_aux);
End;

Procedure interfacemenu.buscarfechas;

Var 
  fe1, fe2: string;
  l_aux: Teventoaux;
Begin
  write('Ingrese fecha 1: ');
  ReadLn(fe1);
  fe1 := cambia_fecha(fe1);

  write('Ingrese fecha 2: ');
  ReadLn(fe2);
  fe2 := cambia_fecha(fe2);

  L.BUSCAR_entre_fechas( fe1, fe2, l_aux);

  If l_aux.cant = 0 Then
    Writeln('No se encontraron eventos en el rango de fechas.')
  Else
    MUESTRA_LISTA_AUX(L, l_aux);
End;


Procedure interfacemenu.buscartipo;

Var 
  op: integer;
  tipo: TTipoEvento;
  l_aux: Teventoaux;
Begin
  Write('Ingrese tipo de evento (1: cumple, 2: reunion, 3: otro): ');
  ReadLn(op);

  Case op Of 
    1: tipo := cumple;
    2: tipo := reunion;
    3: tipo := otro;
  End;
  L.BUSCAR_tipo( tipo, l_aux);

  If l_aux.cant = 0 Then
    Writeln('No se encontró ningún evento de ese tipo.')
  Else
    MUESTRA_LISTA_AUX(L, l_aux);
End;


Procedure interfacemenu.menu();

Var 
  op, ident: integer;
Begin
  L.CREARLISTA;
  ident := 1;
  Repeat
    writeln('Sistema de eventos');
    WriteLn;
    writeln('1. Registrar evento');
    writeln('2. Mostrar todos los eventos');
    writeln('3. Eliminar evento');
    writeln('4. Buscar eventos por subcadena');
    writeln('5. Buscar eventos por fechas');
    writeln('6. Buscar eventos por tipo');
    writeln;
    writeln('0. Salir');
    WriteLn;
    Write('Ingrese una opcion: ');
    readln(op);

    Case op Of 
      1: interfacemenu.cargar_datos( ident);
      2: interfacemenu.MUESTRA_LISTA;
      3: interfacemenu.eliminar;
      4: interfacemenu.busqueda_titulo;
      5: interfacemenu.buscarfechas;
      6: interfacemenu.buscartipo;
    End;
  Until op = 0;
End;

End.
