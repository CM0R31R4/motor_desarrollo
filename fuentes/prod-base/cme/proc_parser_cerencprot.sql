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
	xml2:=  put_campo(xml2,'PROCODFINANCIADOR',	coalesce(nullif(get_campo('CODFINANCIADOR',xml2),''),'0'));   
	xml2:=  put_campo(xml2,'PRONUMCTA',		coalesce(nullif(get_campo('NUMCTA',xml2),''),'0'));           
	xml2:=  put_campo(xml2,'PRONUMCOBRO',		coalesce(nullif(get_campo('NUMCOBRO',xml2),''),'0'));         
	xml2:=  put_campo(xml2,'PROTIPENVIO',		coalesce(nullif(get_campo('TIPENVIO',xml2),''),'0'));         
	xml2:=  put_campo(xml2,'PROHOMNROCONVENIO',	coalesce(nullif(get_campo('HOMNROCONVENIO',xml2),''),'0'));   
	xml2:=  put_campo(xml2,'PROHOMLUGARCONVENIO',	coalesce(nullif(get_campo('HOMLUGARCONVENIO',xml2),''),'0')); 
	xml2:=  put_campo(xml2,'PROCORRELATIVO',	coalesce(nullif(get_campo('CORRELATIVO',xml2),''),'0'));      
	xml2:=  put_campo(xml2,'PROCODINTERVENPTD',	coalesce(nullif(get_campo('CODINTERVENPTD',xml2),''),'0'));   
	xml2:=  put_campo(xml2,'PRODESCPRESTA',		coalesce(nullif(get_campo('DESCPRESTA',xml2),''),'0'));       
	xml2:=  put_campo(xml2,'PRONOMBREMEDICO',	coalesce(nullif(get_campo('NOMBREMEDICO',xml2),''),'0'));     
	rut_pac1:=get_campo('PRORUTPACIENTE',xml2);      
	xml2:=  put_campo(xml2,'PROAPELLIDOPAT',	coalesce(nullif(get_campo('APELLIDOPAT',xml2),''),'0'));      
	xml2:=  put_campo(xml2,'PROAPELLIDOMAT',	coalesce(nullif(get_campo('APELLIDOMAT',xml2),''),'0'));      
	xml2:=  put_campo(xml2,'PRONOMBRES',		coalesce(nullif(get_campo('NOMBRES',xml2),''),'0'));          
	xml2:=  put_campo(xml2,'PROSEXO',		coalesce(nullif(get_campo('SEXO',xml2),''),'0'));             
	xml2:=  put_campo(xml2,'PROEDAD',		coalesce(nullif(get_campo('EDAD',xml2),''),'0'));             
	xml2:=  put_campo(xml2,'PROURGENCIA',		coalesce(nullif(get_campo('URGENCIA',xml2),''),'0'));         
	xml2:=  put_campo(xml2,'PROANESTESIA',		coalesce(nullif(get_campo('ANESTESIA',xml2),''),'0'));        
	xml2:=  put_campo(xml2,'PROPABELLON',		coalesce(nullif(get_campo('PABELLON',xml2),''),'0'));         
	xml2:=  put_campo(xml2,'PROFECINGPABELLON',	coalesce(nullif(get_campo('FECINGPABELLON',xml2),''),'0'));   
	xml2:=  put_campo(xml2,'PROHORAINGPABELLON',	coalesce(nullif(get_campo('HORAINGPABELLON',xml2),''),'0'));  
	xml2:=  put_campo(xml2,'PROFECTERPABELLON',	coalesce(nullif(get_campo('FECTERPABELLON',xml2),''),'0'));   
	xml2:=  put_campo(xml2,'PROHORATERPABELLON',	coalesce(nullif(get_campo('HORATERPABELLON',xml2),''),'0'));  
	xml2:=  put_campo(xml2,'PRORIESGO',		coalesce(nullif(get_campo('RIESGO',xml2),''),'0'));           
	xml2:=  put_campo(xml2,'PROPIEZA',		coalesce(nullif(get_campo('PIEZA',xml2),''),'0'));            
	xml2:=  put_campo(xml2,'PROOBSERVACION',	coalesce(nullif(get_campo('OBSERVACION',xml2),''),'0'));      
	
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

