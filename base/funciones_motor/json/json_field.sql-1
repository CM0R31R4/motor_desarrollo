CREATE OR REPLACE FUNCTION json_field(json_struct text, field_name text)
  RETURNS text AS
$BODY$

try:
	import simplejson as json
	struct = json.loads(json_struct)
	if type(struct) == dict:
		return json.dumps(struct[field_name]).replace('"','')
	if type(struct) == list:
		list_index = int(field_name)
		return json.dumps(struct[list_index]).replace('"','')
except:
	return None
$BODY$
  LANGUAGE plpython2u VOLATILE
  COST 100;
