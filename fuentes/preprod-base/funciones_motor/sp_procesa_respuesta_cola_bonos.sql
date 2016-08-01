CREATE OR REPLACE FUNCTION public.sp_procesa_respuesta_cola_bonos(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1    alias for $1;
        xml2    varchar;
        id1     varchar;
        cola1   varchar;
	xml3	varchar;
begin
        xml2:=xml1;
        id1:=get_campo('__ID_DTE__',xml2);
        cola1:=get_campo('__COLA_MOTOR__',xml2);

        --Si me fue bien..
        if (get_campo('STATUS_BONO',xml2) in ('OK','BONO_RECHAZO')) then
                execute 'insert into respaldo_envbonis (fecha,xml_in) select fecha,xml_in from confirma_bono_'||cola1||' where id='||id1;
                xml2:=logapp(xml2,'Borra Id de Bono');
                execute 'delete from confirma_bono_'||cola1||' where id='||id1;
                return xml2;
	else
	        --Si falla la respuesta...
		--Volvemos a poner el INPUT en INPUT_ORI
                if (length(get_campo('INPUT_ORI',xml2))>0) then
                        xml2:=put_campo(xml2,'INPUT',get_campo('INPUT_ORI',xml2));
                        xml2:=put_campo(xml2,'INPUT_ORI','');
                end if;
		--Sacamos el _LOG_ del xml que molesta visualmente
		xml3:=put_campo(xml2,'_LOG_','');
                xml2:=logapp(xml2,'Aumenta Reintentos');
                execute 'update confirma_bono_'||cola1||' set reintentos=reintentos+1,xml_in='||quote_literal(xml3)||' where id='||id1;
                return xml2;
	end if;

end;
$function$

