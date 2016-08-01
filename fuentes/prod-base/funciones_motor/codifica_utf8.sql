CREATE OR REPLACE FUNCTION codifica_utf8(varchar)
returns varchar as
$$
declare
        data_hex      alias for $1;
        resp1   varchar;
        i       integer;
        len     integer;
        c       bigint;
	aux1	varchar;
	aux2	varchar;
begin
        i:=1;
	--Le sacamos los /n que no son UTF8
	aux2:=replace($1,'\n',chr(10));
	aux2:=replace(aux2,chr(92),'');
	aux1:=encode(aux2::bytea,'hex');
        len:=length(aux1);
        resp1:='';
        while (i<len) loop

                c:=('x'||lpad(substring(aux1,i,2),16,'0'))::bit(64)::bigint;
                --raise notice 'c=%',c;
                resp1:=resp1||encode(chr(c::integer)::bytea,'hex');
                --resp1:=resp1||chr(c::integer)::bytea;
                --raise notice 'resp1=% chr(c::integer)=%',resp1,chr(c::integer);
                i:=i+2;
        end loop;
        return resp1;
end;
$$
LANGUAGE plpgsql;

