CREATE OR REPLACE FUNCTION motor_modulo11 (varchar)
returns varchar as
$$
declare
        data 		varchar;
        data1 		varchar;
        len_rut 	integer;
        lTotal 		integer;
        lResto 		integer;
        lMultiplo 	integer;
        achRut 		integer;
begin
        data1 := ltrim(trim($1),'0');
        if (motor_isnumber(data1)=0) then
                return 'X';
        end if;
        data := lpad(data1,9,'0');
        len_rut := 9;
        lTotal  := 0;
        lMultiplo := 2;
        while  len_rut > 1 loop
                achRut := substring(data,len_rut,1);
                lTotal := lTotal + (lMultiplo*achRut);
                if lMultiplo = 7 then lMultiplo :=2;
                else lMultiplo := lMultiplo + 1;
                end if;
                len_rut := len_rut -1;
        end loop;
        lResto := lTotal%11;
        if lResto=0 then return '0';
        end if;
        if lResto=1 then return 'K';
        end if;
        return 11-lResto+'0';
end;
$$ 
LANGUAGE plpgsql;

