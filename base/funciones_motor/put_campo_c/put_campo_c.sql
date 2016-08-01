drop FUNCTION put_campo_c(text, text,text);
create or replace FUNCTION put_campo_c(text ,text,text) RETURNS text as '/home/motor/base/funciones_motor/put_campo_c/put_campo_c.so','put_campo_c' LANGUAGE C STRICT;

