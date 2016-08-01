CREATE OR REPLACE FUNCTION traductor_in_envbonis_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	declare_params	varchar;
        exec_sp		varchar;
	select1		varchar;
        out_params  	varchar;
        exec_end  	varchar;

	cod_fin1 	varchar;
	num_conv1	varchar;
	lugar_conv1	varchar;
	suc_venta1	varchar;
	rut_conv1	varchar;
	rut_asoc1	varchar;
	nom_prest1	varchar;
	rut_tratante1	varchar;
	especialidad1	varchar;
	rut_benef1	varchar;
	rut_cotiza1	varchar;
	rut_acomp1	varchar;
	rut_emisor1	varchar;
	rut_cajero1	varchar;
	cod_diag1	varchar;
	dscto_planilla1	varchar;
	monto_exec1	varchar;
	fecha_emision1	varchar;
	nivel_conv1	varchar;
	folio_financ1	varchar;
	monto_valor1	varchar;
	monto_aporte1	varchar;
	monto_copago1	varchar;
	num_opera1	varchar;
	corr_presta1	varchar;
	tipo_solic1	varchar;
	fecha_inicio1	varchar;
	urgencia1	varchar;	
	plan1		varchar;	
	lista1		varchar;
	lista2		varchar;
	lista3		varchar;

/*
      @extCodFinanciador              int
    , @extHomNumeroConvenio           char(15)
    , @extHomLugarConvenio            char(10)
    , @extSucVenta                    char(10)
    , @extRutConvenio                 char(12)
    , @extRutAsociado                 char(12)
    , @extNomPrestador                char(40)
    , @extRutTratante                 char(12)
    , @extEspecialidad                char(10)
    , @extRutBeneficiario             char(12)
    , @extRutCotizante                char(12)
    , @extRutAcompanante              char(12)
    , @extRutEmisor                   char(12)
    , @extRutCajero                   char(12)
    , @extCodigoDiagnostico           char(10)
    , @extDescuentoxPlanilla          char(1)
    , @extMontoExcedente              numeric(10,0)
    , @extFechaEmision                datetime
    , @extNivelConvenio               tinyint
    , @extFolioFinanciador            numeric(10,0)
    , @extMontoValorTotal             numeric(10,0)
    , @extMontoAporteTotal            numeric(10,0)
    , @extMontoCopagoTotal            numeric(10,0)
    , @extNumOperacion                numeric(10,0)
    , @extCorrPrestacion              numeric(10,0)
    , @extTipoSolicitud               tinyint
    , @extFechaInicio                 datetime
    , @extUrgencia                    char(1)
    , @extPlan                        char(15)
    , @extLista1                      char(255)
    , @extLista2                      char(255)
    , @extLista3                      char(255)
    , @extCodError                    char(1)         Output
    , @extMensajeError                char(30)        Output
*/
	
begin
        xml2	:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        cod_fin1	:=get_campo('EXTCODFINANCIADOR',xml2);
	num_conv1   	:=split_part(get_campo('EXTHOMNUMEROCONVENIO',xml2),'-',1);/*NO DEBE VENIR CON "-"*/
	lugar_conv1 	:=get_campo('EXTHOMLUGARCONVENIO',xml2);  
	suc_venta1  	:=get_campo('EXTSUCVENTA',xml2);	 -- char(10),             
	rut_conv1   	:=get_campo('EXTRUTCONVENIO',xml2);	-- char(12),             
	rut_asoc1	:=get_campo('EXTRUTASOCIADO',xml2);      	-- char(12),
	nom_prest1	:=get_campo('EXTNOMPRESTADOR',xml2);      -- char(40),	
	rut_tratante1   :=get_campo('EXTRUTTRATANTE',xml2); 	-- char(12),             
	especialidad1   :=get_campo('EXTESPECIALIDAD',xml2);	 -- char(10), 
	rut_benef1	:=get_campo('EXTRUTBENEFICIARIO',xml2);	-- char(12),             
	rut_cotiza1	:=get_campo('EXTRUTCOTIZANTE',xml2);      	-- char(12),
	rut_acomp1 	:=get_campo('EXTRUTACOMPANANTE',xml2);    	-- char(12),
	rut_emisor1	:=get_campo('EXTRUTEMISOR',xml2);         	-- char(12),
	rut_cajero1	:=get_campo('EXTRUTCAJERO',xml2);         	-- char(12),
	cod_diag1       :=get_campo('EXTCODIGODIAGNOSTICO',xml2); -- char(10),             
	dscto_planilla1	:=get_campo('EXTDESCUENTOXPLANILLA',xml2);-- char(1),
	monto_exec1	:=get_campo('EXTMONTOEXCEDENTE',xml2);    -- numeric(10),

	fecha_emision1	:=replace(get_campo('EXTFECHAEMISION',xml2),'-','');--YYYYMMDD
	--fecha_emision1  :=substr(replace(to_date(lpad(fecha_emision1,8,'0'),'YYYYMMD')::varchar,'-',''),1,8);

	nivel_conv1     :=get_campo('EXTNIVELCONVENIO',xml2);	 -- tinyint,              
	folio_financ1	:=get_campo('EXTFOLIOFINANCIADOR',xml2);  -- numeric(10),
	monto_valor1	:=get_campo('EXTMONTOVALORTOTAL',xml2);   -- numeric(10),
	monto_aporte1	:=get_campo('EXTMONTOAPORTETOTAL',xml2);  -- numeric(10),
	monto_copago1	:=get_campo('EXTMONTOCOPAGOTOTAL',xml2);  -- numeric(10),
	num_opera1	:=get_campo('EXTNUMOPERACION',xml2);      -- numeric(10),
	corr_presta1	:=get_campo('EXTCORRPRESTACION',xml2);    -- numeric(10),
	tipo_solic1	:=get_campo('EXTTIPOSOLICITUD',xml2);     -- numeric(10),
	fecha_inicio1	:=replace(get_campo('EXTFECHAINICIO',xml2),'-','');	--Formato YYYYMMDD
	urgencia1       :=get_campo('EXTURGENCIA',xml2);		 -- char(1),              
	plan1		:=get_campo('EXTPLAN',xml2);        	 -- char(15),
	lista1          :=get_campo('EXTLISTA1',xml2);		 -- char(255),            
	lista2          :=get_campo('EXTLISTA2',xml2);		 -- char(255),            
	lista3          :=get_campo('EXTLISTA3',xml2);		 -- char(255),            

	--Valida formato del Rut
        rut_conv1	:=motor_formato_rut(rut_conv1);
        rut_asoc1	:=motor_formato_rut(rut_asoc1);
        rut_tratante1	:=motor_formato_rut(rut_tratante1);
        rut_benef1	:=motor_formato_rut(rut_benef1);
        rut_cotiza1	:=motor_formato_rut(rut_cotiza1);
        rut_acomp1	:=motor_formato_rut(rut_acomp1);
        rut_emisor1	:=motor_formato_rut(rut_emisor1);
        rut_cajero1	:=motor_formato_rut(rut_cajero1);
        
        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_conv1='') 	or (rut_asoc1='') 	or 
           (rut_tratante1='') 	or (rut_benef1='') 	or 
           (rut_cotiza1='') 	or (rut_acomp1='') 	or 
           (rut_emisor1='') 	or (rut_cajero1='') 	then
           
		xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;
        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

	declare_params:=' DECLARE @extCodFinanciador	numeric(5);
		DECLARE @extHomNumeroConvenio  char(15);
		DECLARE @extHomLugarConvenio   char(10);
		DECLARE @extSucVenta           char(10);
		DECLARE @extRutConvenio        char(12);
		DECLARE @extRutAsociado        char(12);
		DECLARE @extNomPrestador       char(40);
		DECLARE @extRutTratante        char(12);
		DECLARE @extEspecialidad       char(10);
		DECLARE @extRutBeneficiario    char(12);
		DECLARE @extRutCotizante       char(12);
		DECLARE @extRutAcompanante     char(12);
		DECLARE @extRutEmisor          char(12);
		DECLARE @extRutCajero          char(12);
		DECLARE @extCodigoDiagnostico  char(10);
		DECLARE @extDescuentoxPlanilla char(1);
		DECLARE @extMontoExcedente     numeric(10);
		DECLARE @extFechaEmision       datetime;
		DECLARE @extNivelConvenio      numeric(1);
		DECLARE @extFolioFinanciador   numeric(10);
		DECLARE @extMontoValorTotal    numeric(10);
		DECLARE @extMontoAporteTotal   numeric(10);
		DECLARE @extMontoCopagoTotal   numeric(10);
		DECLARE @extNumOperacion       numeric(10);
		DECLARE @extCorrPrestacion     numeric(10);
		DECLARE @extTipoSolicitud      numeric(1);
		DECLARE @extFechaInicio        datetime;
		DECLARE @extUrgencia           char(1);
		DECLARE @extPlan               char(15);
		DECLARE @extLista1             char(255);
		DECLARE @extLista2             char(255);
		DECLARE @extLista3             char(255);
		DECLARE @extCodError           char(1);
		DECLARE @extMensajeError       char(30);';				
        	
		exec_sp:= 'execute dbo.MASenvBonIs '||cod_fin1||',"'||num_conv1||'","'||lugar_conv1||'","'||suc_venta1||'","'||rut_conv1||'","'||rut_asoc1||'","'||nom_prest1||'","'||rut_tratante1||'","'||especialidad1||'","'||rut_benef1||'","'||rut_cotiza1||'","'||rut_acomp1||'","'||rut_emisor1||'","'||rut_cajero1||'","'||cod_diag1||'","'||dscto_planilla1||'",'||monto_exec1||',"'||fecha_emision1||'",'||nivel_conv1||','||folio_financ1||','||monto_valor1||','||monto_aporte1||','||monto_copago1||','||num_opera1||','||corr_presta1||','||tipo_solic1||',"'||fecha_inicio1||'","'||urgencia1||'","'||plan1||'","'||lista1||'","'||lista2||'","'||lista3||'", @extCodError output, @extMensajeError output; ';

		/*Ejemplo 2 Prestaciones GES. Dos Listas*/
		--exec_sp:= 'execte dbo.MASenvBonIs 078,'45940-0','75600','130600','0096942400-2','0000000000-0','Integramedica','0000000000-0','','0004684532-3', '0003588817-9','00000000000-0','0000000000-0','0011316248-1', '','N',0000000000,'20110930',0,986290576, 000009020,0000004270,0000004750,0000000001,0000000001,1,'20110930','','ICS010606B', '0302034000|0 |*G*-021-2-0003 |N|01 |006940|0004270|0002670|104GES MB006940|0|0000000|0|0000000|0|0000000|0|0000000|0|0000000|0309022000|0 |*G*-021-2-0003|N|01|002080|0000000|0002080|104GES MB000000|0|0000000|0|0000000|0|0000000|0|0000000|0|0000000|', '', '', @extCodError output, @extMensajeError output;

	out_params:='select @extCodError as extCodError, @extMensajeError as extMensajeError; ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_envbonis_masvida(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	i		integer='1';
	cod_resp1       varchar;
        mensaje_resp1   varchar;	

begin
        xml2	:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Parseo la Respuesta
        cod_resp1	:=trim(get_campo('EXTCODERROR_'||i::varchar,xml2));
        mensaje_resp1	:=substring(unaccent(trim(get_campo('EXTMENSAJEERROR_'||i::varchar,xml2))) FROM 1 FOR 30);

	EXECUTE 'SELECT REGEXP_REPLACE('||chr(39)||mensaje_resp1||chr(39)||', '||chr(39)||'[^a-zA-Z0-9 ]'||chr(39)||', '||chr(39)||''||chr(39)||', '||chr(39)||'g'||chr(39)||');' INTO mensaje_resp1;

	xml2:=logapp(xml2,'MASVIDA: RSP_ENVBONIS -> extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1);

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;

	xml2:=put_campo(xml2,'EXTCODERROR_'||i::varchar,cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR_'||i::varchar,mensaje_resp1);

	xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);
	
	xml2:=put_campo(xml2,'SQLOUTPUT','{'||get_campo('ERRORMSG',xml2)||', '||get_campo('EXTCODERROR',xml2)||', '||get_campo('EXTMENSAJEERROR',xml2)||'}');

        return xml2;
end;
$$
LANGUAGE plpgsql;
