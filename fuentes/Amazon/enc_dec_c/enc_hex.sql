drop FUNCTION string_to_hex(text);
create or replace FUNCTION string_to_hex(text) RETURNS text as '/home/motor/fuentes/enc_dec_c/enc_hex.so','string_to_hex' LANGUAGE C STRICT;

