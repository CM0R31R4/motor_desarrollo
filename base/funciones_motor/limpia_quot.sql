CREATE OR REPLACE FUNCTION limpia_quot(string text)
RETURNS text AS
$BODY$

import re
s = string
t = re.sub(r'\&.*?\;', '"', s)

return t

$BODY$
  LANGUAGE plpythonu VOLATILE
  COST 100;

