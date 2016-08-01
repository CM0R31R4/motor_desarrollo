drop FUNCTION hex_64_hex(text);
create or replace FUNCTION hex_64_hex(text) RETURNS text as '/home/motor/fuentes/enc_dec_c/enc_hex_64.so','hex_64_hex' LANGUAGE C STRICT;

