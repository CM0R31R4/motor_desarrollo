CREATE OR REPLACE FUNCTION motor_isnumber(varchar)
returns integer as
$$
declare
        data alias for $1;
        data1  varchar;
        n integer;
        i       integer;
        ch      varchar;
begin
        data1 := trim(data);
        n :=length(data1);
        if (n=0) then return 0;
        end if;
        i := 1;
        while i <= n loop
                ch := substring(data1,i,1);
                if ((ascii(ch)<48) or (ascii(ch)>57)) then return 0;
                end if;
                i := i + 1;
        end loop;
        return 1;
end;
$$ 
LANGUAGE plpgsql;
