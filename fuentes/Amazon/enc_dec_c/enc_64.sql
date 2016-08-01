drop FUNCTION string_to_64(text);
create or replace FUNCTION string_to_64(text) RETURNS text as '/home/motor/fuentes/enc_dec_c/enc_64.so','string_to_64' LANGUAGE C STRICT;

