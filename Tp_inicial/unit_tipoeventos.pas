unit unit_tipoeventos;
interface
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
  implementation
  end.