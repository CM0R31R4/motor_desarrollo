CREATE OR REPLACE FUNCTION reemplaza_caracteres_escape_utf8(varchar)
returns varchar as
$$
declare
        data1 alias for $1;
	campo	record;
	salida1	varchar;
begin
	salida1:=data1;
	--Recorre la tabla para transformar el texto si corresponde
	for campo in select * from convert_octal_ascii loop
		if (campo.symbol is null) then
			--raise notice 'paso1 % % %',salida1,campo.octal,campo.ascii;
			salida1:=replace(salida1,campo.octal,'');
			--raise notice 'paso1.1';
		else
			--raise notice 'paso2';
			salida1:=replace(salida1,campo.octal,campo.symbol);
		end if;
	end loop;
	return salida1;
end;
$$ 
LANGUAGE plpgsql;
