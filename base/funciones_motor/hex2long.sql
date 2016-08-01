CREATE or replace FUNCTION hex2long(varchar) RETURNS bigint
LANGUAGE plpgsql
AS
$function$
DECLARE
    hex1        alias for $1;
        i       integer;
        ch      char;
        hex2    varchar;
        total1  bigint;
        j       integer;
        exp1    integer;
BEGIN
        --Partimos con el ultimo
        i:=length(hex1);
        hex2:=upper(hex1);
        total1:=0;
        exp1:=0;
        while (i>0) loop
                ch:=substring(hex2,i,1);
                if (ch>='A' and ch <='F') then j:=ascii(ch)-ascii('A')+10;
                else j:=ascii(ch)-ascii('0');
                end if;
                total1:=total1+j*(16^exp1);
                --raise notice 'j=% ch=% ascci(ch)=% total1=% i=%',j,ch,ascii(ch),total1,i;
                exp1:=exp1+1;
                i:=i-1;
        end loop;
        return total1;
END;
$function$

