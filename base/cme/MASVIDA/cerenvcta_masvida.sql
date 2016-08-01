CREATE OR REPLACE FUNCTION traductor_in_cerenvcta_masvida(varchar)
returns varchar as $$
declare
        xml1    alias for $1;
        xml2    varchar;
	declare_params	varchar;
        exec_sp		varchar;
        out_params  	varchar;

begin
        xml2:=xml1;
	--xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
	xml2    :=put_campo(xml2,'FECHA_IN_FIN',clock_timestamp()::varchar);

	--Llamo a la funcion input de parseo de datos.Si viene con error no sigue 
	xml2:=proc_parser_input_cerenvcta(xml2);
	if get_campo('ERR',xml2)='S' then
		xml2:=put_campo(xml2,'ESTADO_TX','FALLA_CME');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Error parser_input_'||get_campo('TX_WS',xml2));
		return xml2;
	end if;

	--Preparo la llamada al SP
	declare_params:='DECLARE @CtaCodError char(1)
		DECLARE @CtaMensajeError char(60) ';
	
	--Por ahora en duro
	--||get_campo('CTACODFINANCIADOR',xml2)||
	exec_sp:= 'EXECUTE dbo.cerenvcta '||88||',
			['||get_campo('CTANUMCTA',xml2)||'],
			'||get_campo('CTANUMCOBRO',xml2)||',
			'||get_campo('CTATIPENVIO',xml2)||',
			['||get_campo('CTAHOMNROCONVENIO',xml2)||'],
			['||get_campo('CTAHOMLUGARCONVENIO',xml2)||'],
			'||get_campo('CTATIPCTA',xml2)||',
			['||get_campo('CTAFECEMISION',xml2)||'],
			['||get_campo('CTAFECINGRESO',xml2)||'],
			['||get_campo('CTAHORAINGRESO',xml2)||'],
			['||get_campo('CTAFECCORTE',xml2)||'],
			['||get_campo('CTAFECALTA',xml2)||'],
			['||get_campo('CTAHORAALTA',xml2)||'],
			['||get_campo('CTAFECFUR',xml2)||'],
			['||get_campo('CTARUTCOTIZANTE',xml2)||'],
			['||get_campo('CTANOMBRECOTIZANTE',xml2)||'],
			['||get_campo('CTARUTBENEFICIARIO',xml2)||'],
			['||get_campo('CTAAPELLIDOPAT',xml2)||'],
			['||get_campo('CTAAPELLIDOMAT',xml2)||'],
			['||get_campo('CTANOMBRES',xml2)||'],
			['||get_campo('CTACODDIAGPRIN',xml2)||'],
			['||get_campo('CTAGLODIAGPRIN',xml2)||'],
			['||get_campo('CTACODDIAGSEC',xml2)||'],
			['||get_campo('CTAGLODIAGSEC',xml2)||'],
			['||get_campo('CTARUTCONVENIO',xml2)||'],
			['||get_campo('CTARUTTRATANTE',xml2)||'],
			['||get_campo('CTANOMBRETRATANTE',xml2)||'],
			'||get_campo('CTATIPCOBRO',xml2)||',
			'||get_campo('CTATIPSALA',xml2)||',
			['||get_campo('CTACARTARESGUARDO',xml2)||'],
			['||get_campo('CTALEYURGENCIA',xml2)||'],
			['||get_campo('CTAINDCAEC',xml2)||'],
			['||get_campo('CTAINDAUGE',xml2)||'],
			'||get_campo('CTANROCIRUGIAS',xml2)||',
			'||get_campo('CTANROEQUIPMED',xml2)||',
			['||get_campo('CTAINDENVIO',xml2)||'],
			'||get_campo('CTAMTOTOTAL',xml2)||',
			'||get_campo('CTANUMDETEQUIPO',xml2)||',
			'||get_campo('CTAMTODETEQUIPO',xml2)||',
			'||get_campo('CTANUMDETHOTELERIA',xml2)||',
			'||get_campo('CTAMTODETHOTELERIA',xml2)||',
			'||get_campo('CTANUMDETINSUMO',xml2)||',
			'||get_campo('CTAMTODETINSUMOS',xml2)||',
			'||get_campo('CTANUMDETPAQUETES',xml2)||',
			'||get_campo('CTAMTODETPAQUETES',xml2)||', @CtaCodError OUTPUT, @CtaMensajeError OUTPUT ';

	out_params:='SELECT @CtaCodError as CtaCodError, @CtaMensajeError as CtaMensajeError ';

	--Esta data se guarda en t_ctamed campo sp_request
        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_cerenvcta_masvida(varchar)
returns varchar as $$
declare
        xml1		alias for $1;
        xml2		varchar;
	i		integer ='1';
	cod_error1	varchar;
	msj_error1	varchar;

begin
        xml2:=xml1;
	--xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
       	--xml2:=put_campo(xml2,'CODIGO_RESP','1');
      	--xml2:=put_campo(xml2,'MENSAJE_RESP','Informada Financiador');
	xml2:=put_campo(xml2,'FECHA_OUT_FIN',clock_timestamp()::varchar);

	--Parseo respuesta
	cod_error1:=trim(get_campo('CTACODERROR_'||i::varchar,xml2));
	msj_error1:=trim(get_campo('CTAMENSAJEERROR_'||i::varchar,xml2));
	xml2:=logapp(xml2,upper(get_campo('TX_WS',xml2))||'_Receive CtaCodError='||cod_error1||' - CtaMensajeError='||msj_error1);

	--Se guarda el response del SP en t_ctamed, campo sp_return. Tal como llega
	xml2:=put_campo(xml2,'SQLOUTPUT','{'||cod_error1||', '||msj_error1||'}');
        
	if (cod_error1='') then
                --Si campo ctacoderror viene en vacio. Activa SpConcilacion por Api2
		xml2:=logapp(xml2,'Isapre Responde Sin Valor ctacoderror: '||get_campo('TX_WS',xml2));
		xml2:=put_campo(xml2,'LOOP_API','SI');
	        
		xml2:=put_campo(xml2,'ESTADO_TX','FALLA_API');
        	xml2:=put_campo(xml2,'CODIGO_RESP','2');
		xml2:=put_campo(xml2,'MENSAJE_RESP','No Viene Respuesta Financiador');
		
		--Respuesta a Sonda
		xml2:=put_campo(xml2,'ERR','S');
       	 	xml2:=put_campo(xml2,'GLOSA','No Viene Respuesta Financiador');
		return xml2;
		
	elsif (cod_error1='S') then 
                --Si Isapre responde Error. Activar SP ConciliacionCme con recursion de secuencia.
		--<STATUS>OK</STATUS><CtaCodError>S</CtaCodError><CtaMensajeError>Registro cargado anteriormente...
		xml2:=logapp(xml2,'Isapre Rechaza Cme: '||get_campo('TX_WS',xml2));
		
		xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        	xml2:=put_campo(xml2,'CODIGO_RESP','2');
	        xml2:=put_campo(xml2,'MENSAJE_RESP','Rechaza Financiador');
	
	else
		--Esta Aprobada. Viene "N"
		xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
       		xml2:=put_campo(xml2,'CODIGO_RESP','1');
      		xml2:=put_campo(xml2,'MENSAJE_RESP','Informada Financiador');
        
	end if;		

	--Responde a Sonda.
	xml2:=put_campo(xml2,'ERR',cod_error1);
        xml2:=put_campo(xml2,'GLOSA',msj_error1);
        
	return xml2;
end;
$$
LANGUAGE plpgsql;

