drop FUNCTION b64_to_string(text);
create or replace FUNCTION b64_to_string(text) RETURNS text as '/home/motor/fuentes/enc_dec_c/dec_64.so','b64_to_string' LANGUAGE C STRICT;

