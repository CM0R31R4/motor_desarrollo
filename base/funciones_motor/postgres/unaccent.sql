create or replace function unaccent(text) 
returns text language plpythonu as $$

import unicodedata
rv = plpy.execute("select setting from pg_settings where name = 'server_encoding'");
encoding = rv[0]["setting"]
s = args[0].decode(encoding)
s = unicodedata.normalize("NFKD", s)
s = ''.join(c for c in s if ord(c) < 127)

return s
$$;
