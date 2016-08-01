CREATE OR REPLACE FUNCTION convert_escape(data text)
  RETURNS text AS
$BODY$

import re

matches = {}
data1= data;
for octc in re.findall(r'\\(\d{3})', data1):
    matches[octc] = None
for octc in matches:
    data1 = data1.replace(r'\%s' % octc, chr(int(octc, 8)))
return data1
$BODY$
  LANGUAGE plpython2u VOLATILE
  COST 100;
