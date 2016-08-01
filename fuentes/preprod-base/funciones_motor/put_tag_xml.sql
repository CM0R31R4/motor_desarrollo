CREATE OR REPLACE FUNCTION public.put_tag_xml(varchar,varchar)
returns varchar as
$$
declare
	tag1	alias for $1;
        xml1	alias for $2;
	xml2	varchar;
	input1	varchar;

	data1	varchar;
	campo1	varchar;
	valor1	varchar;

	cuenta1	integer;
	i	integer=1;

begin
	xml2:=xml1;
	/*Ejemplo*/
	--put_tag_xml('</item>',xml2);

        input1:=get_campo('RSP_XML',xml2);

	--Saca lo que viene entre este tag
	--input1:=get_tag_xml('<ns:salida-estandar>',xml2);

	--Repeticion del mismo Tag.
        cuenta1:=count_substring(input1,'</'||tag1||'>');

        --Lee tag: nombrecampo y valorcampo. Ingresando el Valor al XML
        while (i<=cuenta1) LOOP
                --raise notice 'JCCRSP_LOOP2';
                data1:=split_part(split_part(input1,'</'||tag1||'>',i),'<'||tag1||'>',2);

                campo1:=get_tag_xml('<name>',data1);
                valor1:=get_tag_xml('<value>',data1);

                --Integro en le bolsa
                xml2:=put_campo(xml2,'RSP_'||campo1,valor1);

                --Paso al sgte grupo <item>
                i:= i+1;
        END LOOP;


	--xml2:=put_campo(xml2,'INPUT','CLEAN');
	return xml2;
end;
$$
LANGUAGE plpgsql;
