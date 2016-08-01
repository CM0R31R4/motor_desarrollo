drop FUNCTION get_campo_c(text, text);
create or replace FUNCTION get_campo_c(text ,text) RETURNS text as '/home/motor/fuentes/get_campo/get_campo_c.so','get_campo_c' LANGUAGE C STRICT;

