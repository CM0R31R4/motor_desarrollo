CREATE OR REPLACE FUNCTION proc_parser_input_cerencprot(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	
	rut_pre1	varchar;
	rut_pac1	varchar;

begin
	xml2:=xml1;
	if length(get_campo('IDXTX',xml2)) = 0 then
                --Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','CME Sin Campo IdxTx');
                return xml2;
        end if;

	rut_pre1:=get_campo('PRORUTPRESTADOR',xml2);
	xml2:=  put_campo(xml2,'PROCODFINANCIADOR',	coalesce(nullif(get_campo('PROCODFINANCIADOR',xml2),''),'0'));   
	xml2:=  put_campo(xml2,'PRONUMCTA',		coalesce(nullif(get_campo('PRONUMCTA',xml2),''),'0'));           
	xml2:=  put_campo(xml2,'PRONUMCOBRO',		coalesce(nullif(get_campo('PRONUMCOBRO',xml2),''),'0'));         
	xml2:=  put_campo(xml2,'PROTIPENVIO',		coalesce(nullif(get_campo('PROTIPENVIO',xml2),''),'0'));         
	xml2:=  put_campo(xml2,'PROHOMNROCONVENIO',	coalesce(nullif(get_campo('PROHOMNROCONVENIO',xml2),''),'0'));   
	xml2:=  put_campo(xml2,'PROHOMLUGARCONVENIO',	coalesce(nullif(get_campo('PROHOMLUGARCONVENIO',xml2),''),'0')); 
	xml2:=  put_campo(xml2,'PROCORRELATIVO',	coalesce(nullif(get_campo('PROCORRELATIVO',xml2),''),'0'));      
	xml2:=  put_campo(xml2,'PROCODINTERVENPTD',	coalesce(nullif(get_campo('PROCODINTERVENPTD',xml2),''),'0'));   
	xml2:=  put_campo(xml2,'PRODESCPRESTA',		coalesce(nullif(get_campo('PRODESCPRESTA',xml2),''),'0'));       
	xml2:=  put_campo(xml2,'PRONOMBREMEDICO',	coalesce(nullif(get_campo('PRONOMBREMEDICO',xml2),''),'0'));     
	rut_pac1:=get_campo('PRORUTPACIENTE',xml2);      
	xml2:=  put_campo(xml2,'PROAPELLIDOPAT',	coalesce(nullif(get_campo('PROAPELLIDOPAT',xml2),''),'0'));      
	xml2:=  put_campo(xml2,'PROAPELLIDOMAT',	coalesce(nullif(get_campo('PROAPELLIDOMAT',xml2),''),'0'));      
	xml2:=  put_campo(xml2,'PRONOMBRES',		coalesce(nullif(get_campo('PRONOMBRES',xml2),''),'0'));          
	xml2:=  put_campo(xml2,'PROSEXO',		coalesce(nullif(get_campo('PROSEXO',xml2),''),'0'));             
	xml2:=  put_campo(xml2,'PROEDAD',		coalesce(nullif(get_campo('PROEDAD',xml2),''),'0'));             
	xml2:=  put_campo(xml2,'PROURGENCIA',		coalesce(nullif(get_campo('PROURGENCIA',xml2),''),'0'));         
	xml2:=  put_campo(xml2,'PROANESTESIA',		coalesce(nullif(get_campo('PROANESTESIA',xml2),''),'0'));        
	xml2:=  put_campo(xml2,'PROPABELLON',		coalesce(nullif(get_campo('PROPABELLON',xml2),''),'0'));         
	xml2:=  put_campo(xml2,'PROFECINGPABELLON',	coalesce(nullif(get_campo('PROFECINGPABELLON',xml2),''),'0'));   
	xml2:=  put_campo(xml2,'PROHORAINGPABELLON',	coalesce(nullif(get_campo('PROHORAINGPABELLON',xml2),''),'0'));  
	xml2:=  put_campo(xml2,'PROFECTERPABELLON',	coalesce(nullif(get_campo('PROFECTERPABELLON',xml2),''),'0'));   
	xml2:=  put_campo(xml2,'PROHORATERPABELLON',	coalesce(nullif(get_campo('PROHORATERPABELLON',xml2),''),'0'));  
	xml2:=  put_campo(xml2,'PRORIESGO',		coalesce(nullif(get_campo('PRORIESGO',xml2),''),'0'));           
	xml2:=  put_campo(xml2,'PROPIEZA',		coalesce(nullif(get_campo('PROPIEZA',xml2),''),'0'));            
	xml2:=  put_campo(xml2,'PROOBSERVACION',	coalesce(nullif(get_campo('PROOBSERVACION',xml2),''),'0'));      
	
	--Valida formato del Rut
        rut_pre1	:=motor_formato_rut(rut_pre1);
        rut_pac1      	:=motor_formato_rut(rut_pac1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_pre1='')	or (rut_pac1='')	then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
		--Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','Rut Incorrecto');
                return xml2;
        end if;
        --Retorno de datos.
        xml2    :=put_campo(xml2,'PRORUTPRESTADOR',rut_pre1);
        xml2    :=put_campo(xml2,'PRORUTPACIENTE',rut_pac1);

Return xml2;
end;
$$
LANGUAGE plpgsql;

