CREATE OR REPLACE FUNCTION cuenta_palabras(string text,  word text)
RETURNS text AS
$BODY$

try:
	sentence = string
	return sentence.count(word)
	
except:
	return 1

$BODY$
  LANGUAGE plpythonu VOLATILE
  COST 100;
