
Unit unit_menu_y_aux;

Interface

Uses 
unit_lista;
// unit_archivo;

Procedure menu();

Implementation

Procedure cargar_datos(Var L:TListaEventos; Var id: integer);

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
  writeln('Ingrese fecha de fin (dd/mm/yyyy):');
  readln(E.fechafin);
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

  AGREGAR(L, E, id);
  // lo agrego a la lista
End;

Procedure eliminar(Var L: TListaEventos);

Var 
  id: integer;
Begin
  Write('Ingrese el id a eliminar: ');
  ReadLn(id);

  ELIMINAREVENTO(L, id);
End;

Procedure busquedasubcad(L: TListaEventos);

Var 
  sub: string;
Begin
  Write('Ingrese la palabra del titulo: ');
  ReadLn(sub);

  BUSCAR_titulo(L, sub);
End;

Procedure buscarfechas(L: TListaEventos);

Var fe1,fe2: string;
Begin
  write('Ingrese fecha 1: ');
  ReadLn(fe1);
  write('Ingrese fecha 2: ');
  ReadLn(fe2);

  BUSCAR_entre_fechas(L, fe1, fe2);
End;

Procedure buscartipo(L: TListaEventos);

Var 
  op: integer;
Begin
  write('Ingrese tipo de evento (1: cumple, 2: reunion, 3: otro): ');
  ReadLn(op);

  Case op Of 
    1: BUSCAR_tipo(L, cumple);
    2: BUSCAR_tipo(L, reunion);
    3: BUSCAR_tipo(L, otro);
  End;
End;

Procedure menu();

Var 
  op, ident: integer;
  L: TListaEventos;
Begin
  CREARLISTA(L);
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
      1: cargar_datos(L, ident);
      2: MUESTRA_LISTA(L);
      3: eliminar(L);
      4: busquedasubcad(L);
      5: buscarfechas(L);
      6: buscartipo(L);
    End;
  Until op = 0;
End;

End.
