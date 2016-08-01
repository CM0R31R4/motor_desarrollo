CREATE OR REPLACE FUNCTION public.actualiza_control_motor(varchar,varchar)
returns integer as
$$
declare
        proceso1	alias for $1;
	activos1	alias for $2;
	stProceso	control_motor%ROWTYPE;
	
begin
	if (is_number(activos1) is false) then
		return 1;
	end if;
	select * into stProceso from control_motor where proceso=proceso1;
	if not found then
		insert into control_motor (proceso,max_hilos_en_uso_dia,fecha) values (proceso1,activos1,now());
	else
		if (is_number(stProceso.max_hilos_en_uso_dia)) then
			if (activos1::integer>stProceso.max_hilos_en_uso_dia::integer) then
				update control_motor set max_hilos_en_uso_dia=activos1,fecha=now() where proceso=proceso1;
			end if;
		end if;
	end if;
	return 0;
end;
$$
LANGUAGE plpgsql;
