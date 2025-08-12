
Unit unit_tipoeventos;

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

  Teventoaux = Record
    cant: integer;
    posiciones: array[1..200] Of integer;
  End;

Implementation
End.
