CREATE OR REPLACE FUNCTION public.motor_formato_rut(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        data1 		alias for $1;
	campo1		varchar;
	len_campo1	integer;
	len_rut1	integer;
	rut1		varchar;
	dig_rut1	varchar;
	dig_aux1	varchar;
	
begin
	campo1:=data1;
	len_campo1:= length(campo1);
	--Si no viene data.
	if (len_campo1=0) then
                return '';
	end if;

	--Si el Rut es 0000000000-0. Lo dejo pasar
	if (campo1 = '0000000000-0') then
                return campo1;
        end if; 

	--Si el formato no es XXXXXXXX-X. Rechazo
        if strpos(campo1,'-')>0 then
		rut1:=split_part(campo1,'-',1);
		len_rut1:= length(rut1);
		
		--Cuando el campo de la Izquierda, no sea numerico
		if motor_isnumber(rut1)=0 then
			return '';
		end if;
		
		--Cuando el campo de la Izquierda, sea mayor a 10. Rechazo 
		if (len_rut1>10) then
                	return '';
        	end if;

		--Validacion de Modulo11
		dig_rut1:=split_part(campo1,'-',2);
                dig_aux1:=motor_modulo11(rut1);

                --Comparo ambos Digitos.El recibido v/s calculado
                if dig_rut1 <> dig_aux1 then
                        return '';
                end if;
                --Rut OK.
                rut1:=lpad(rut1,10,'0');
        else
                return '';
        end if;
	
	return rut1||'-'||dig_rut1;
end;
$function$

