CREATE OR REPLACE FUNCTION public.sp_procesa_respuesta_cola_cia(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1    alias for $1;
        xml2    varchar;
        id1     varchar;
        cola1   varchar;
begin
        xml2:=xml1;
        id1:=get_campo('__ID_DTE__',xml2);
        cola1:=get_campo('__COLA_MOTOR__',xml2);

        --Si me fue bien..
        if (get_campo('STATUS_CIA',xml2) in ('OK','CIA_RECHAZO')) then
                BEGIN
                execute 'insert into respaldo_cia (fecha,xml_in) select fecha,xml_in from confirma_'||cola1||' where id='||id1;
                xml2:=logapp(xml2,'Borra Id de CIA');
                execute 'delete from confirma_'||cola1||' where id='||id1;
                return xml2;
	        /*EXCEPTION WHEN OTHERS THEN
                        raise notice '%--- %', SQLERRM, SQLSTATE;
                        execute 'CREATE TABLE respaldo_cia (fecha timestamp,xml_in varchar,cia varchar)';
                        execute 'CREATE INDEX respaldo_cia_01 on respaldo_cia(fecha)';
                        execute 'CREATE INDEX respaldo_cia_02 on respaldo_cia(cia)';
                        xml2:=logapp(xml2,'Crea Tabla respaldo_cia');
                        return xml2;
		*/
                END;
	elsif (get_campo('STATUS_CIA',xml2)='SOLO_SYBASE') then
		xml2:=logapp(xml2,'Aumenta Reintentos y falla sybase');
		xml2:=put_campo(xml2,'ESTADO_SYBASE','SOLO_SYBASE');
		execute 'update confirma_'||cola1||' set reintentos=reintentos+1,estado=''SOLO_SYBASE'',xml_in='||quote_literal(xml2)||' where id='||id1;
		return xml2;
	elsif (get_campo('STATUS_CIA',xml2)='SOLO_PERCONA') then
		xml2:=logapp(xml2,'Aumenta Reintentos y falla percona');
		xml2:=put_campo(xml2,'ESTADO_PERCONA','SOLO_PERCONA');
		execute 'update confirma_'||cola1||' set reintentos=reintentos+1,estado=''SOLO_PERCONA'',xml_in='||quote_literal(xml2)||' where id='||id1;
		return xml2;
	else
	        --Si falla la respuesta...
                xml2:=logapp(xml2,'Aumenta Reintentos');
                execute 'update confirma_'||cola1||' set reintentos=reintentos+1 where id='||id1;
                return xml2;
	end if;

end;
$function$

