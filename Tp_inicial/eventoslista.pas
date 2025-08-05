program eventoslista;
uses unit_lista;
var
  L:TListaEventos;
  E:TEvento;
begin
  CREARLISTA(L);
  pedir_datos(E);
  AGREGAR(L,E);
  MUESTRA_LISTA(L);
 
//   BUSCAR_titulo(L,'Cumpleaños',ENC);
//   if ENC then
//     writeln('Evento encontrado')
//   else
//     writeln('Evento no encontrado');
end.