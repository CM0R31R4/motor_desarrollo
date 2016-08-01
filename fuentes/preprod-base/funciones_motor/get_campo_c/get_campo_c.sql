drop FUNCTION get_campo_c(text, text);
create or replace FUNCTION get_campo_c(text ,text) RETURNS text as '/home/motor/base/funciones_motor/get_campo_c/get_campo_c.so','get_campo_c' LANGUAGE C STRICT;

