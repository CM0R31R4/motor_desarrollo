drop FUNCTION hex_to_string(text);
create or replace FUNCTION hex_to_string(text) RETURNS text as '/home/motor/fuentes/enc_dec_c/dec_hex.so','hex_to_string' LANGUAGE C STRICT;

