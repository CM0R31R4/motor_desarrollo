CREATE OR REPLACE FUNCTION traductor_in_envbonis_vidacamara(varchar)
returns varchar as

$$
declare
        xml1    alias for $1;
        xml2    varchar;
        declare_params varchar;
        out_params varchar;
        exec_med varchar;
        exec_end varchar;
        cod_fin1 varchar;
	ext_hom_numero_convenio varchar;
	ext_hom_lugar_convenio varchar;
	ext_suc_venta varchar;
	rut_conv1 varchar;	
	rut_asoc1 varchar;
	ext_nom_prestador varchar;
       	rut_tratante1 varchar;
	ext_especialidad varchar;	
	rut_benef1 varchar; --10
	rut_cotiza1 varchar;
	rut_acomp1 varchar;
	rut_emisor1 varchar;
	rut_cajero1 varchar;
	ext_codigo_diagnostico varchar;
	ext_descuento_x_planilla varchar;
	ext_montoexcendente varchar;	
	ext_fecha_emision varchar;
	ext_nivel_convenio varchar;
	ext_folio_financiador varchar; --20
	ext_monto_valor_total varchar;
	ext_monto_aporte_total varchar;
	ext_monto_copago_total varchar;
	ext_num_operacion varchar;
	ext_corr_prestacion varchar;
	ext_tipo_solicitud varchar;
	ext_fecha_inicio varchar;
	ext_urgencia varchar;
	ext_plan varchar;
	ext_lista_1 varchar; --30
	ext_lista_2 varchar;
	ext_lista_3 varchar;
	
begin

        xml2:=xml1;
        xml2	:=put_campo(xml2,'_SECUENCIA_','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1 		:=get_campo('EXTCODFINANCIADOR',xml2);
        ext_hom_numero_convenio :=get_campo('EXTHOMNUMEROCONVENIO',xml2);	--Acepta -
        ext_hom_lugar_convenio  :=get_campo('EXTHOMLUGARCONVENIO',xml2);
	ext_suc_venta		:=get_campo('EXTSUCVENTA',xml2);
	rut_conv1		:=get_campo('EXTRUTCONVENIO',xml2);
	rut_asoc1 		:=get_campo('EXTRUTASOCIADO',xml2);
	ext_nom_prestador 	:=elimina_tildes(convert_escape(get_campo('EXTNOMPRESTADOR',xml2)));
       	rut_tratante1		:=get_campo('EXTRUTTRATANTE',xml2);
	ext_especialidad	:=get_campo('EXTESPECIALIDAD',xml2);
	rut_benef1		:=get_campo('EXTRUTBENEFICIARIO',xml2);
	rut_cotiza1		:=get_campo('EXTRUTCOTIZANTE',xml2);
	rut_acomp1		:=get_campo('EXTRUTACOMPANANTE',xml2);
	rut_emisor1		:=get_campo('EXTRUTEMISOR',xml2); 
	rut_cajero1		:=get_campo('EXTRUTCAJERO',xml2);
	ext_codigo_diagnostico	:=get_campo('EXTCODIGODIAGNOSTICO',xml2);
	ext_descuento_x_planilla:=get_campo('EXTDESCUENTOXPLANILLA',xml2);
	ext_montoexcendente	:=get_campo('EXTMONTOEXCEDENTE',xml2);
	ext_fecha_emision	:=replace(get_campo('EXTFECHAEMISION',xml2),'-','');
	ext_nivel_convenio	:=get_campo('EXTNIVELCONVENIO',xml2);
	ext_folio_financiador	:=get_campo('EXTFOLIOFINANCIADOR',xml2);
	ext_monto_valor_total	:=get_campo('EXTMONTOVALORTOTAL',xml2);
	ext_monto_aporte_total	:=get_campo('EXTMONTOAPORTETOTAL',xml2);
	ext_monto_copago_total	:=get_campo('EXTMONTOCOPAGOTOTAL',xml2);
	ext_num_operacion	:=get_campo('EXTNUMOPERACION',xml2);
	ext_corr_prestacion	:=get_campo('EXTCORRPRESTACION',xml2);
	ext_tipo_solicitud	:=get_campo('EXTTIPOSOLICITUD',xml2);
	ext_fecha_inicio	:=replace(get_campo('EXTFECHAINICIO',xml2),'-','');
	ext_urgencia		:=get_campo('EXTURGENCIA',xml2);
	ext_plan		:=get_campo('EXTPLAN',xml2);
	ext_lista_1 		:=get_campo('EXTLISTA1',xml2);
	ext_lista_2 		:=get_campo('EXTLISTA2',xml2);
	ext_lista_3 		:=get_campo('EXTLISTA3',xml2);
      
	--Valida formato del Rut
        /*rut_conv1       :=motor_formato_rut(rut_conv1);
        rut_asoc1       :=motor_formato_rut(rut_asoc1);
        rut_tratante1   :=motor_formato_rut(rut_tratante1);
        rut_benef1      :=motor_formato_rut(rut_benef1);
        rut_cotiza1     :=motor_formato_rut(rut_cotiza1);
        rut_acomp1      :=motor_formato_rut(rut_acomp1);
        rut_emisor1     :=motor_formato_rut(rut_emisor1);
        rut_cajero1     :=motor_formato_rut(rut_cajero1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_conv1='')       or (rut_asoc1='')       or
           (rut_tratante1='')   or (rut_benef1='')      or
           (rut_cotiza1='')     or (rut_acomp1='')      or
           (rut_emisor1='')     or (rut_cajero1='')      then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;*/
        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);
 
	declare_params:=' DECLARE @extCodError VARCHAR(2)
			  DECLARE @extMensajeError VARCHAR(100)';
      
        out_params:= ' @extCodError OUTPUT,@extMensajeError OUTPUT; select @extCodError as extCodError, @extMensajeError as extMensajeError; ';

	xml2:=put_campo(xml2,'SQLINPUT',declare_params||' EXEC dbo.SMDEnvBonIs '||cod_fin1||',"'||ext_hom_numero_convenio||'","'||ext_hom_lugar_convenio||'","'||ext_suc_venta||'","'||rut_conv1||'","'||rut_asoc1||'","'||ext_nom_prestador||'","'||rut_tratante1||'","'||ext_especialidad||'","'||rut_benef1||'","'||rut_cotiza1||'","'||rut_acomp1||'","'||rut_emisor1||'","'||rut_cajero1||'","'||ext_codigo_diagnostico||'","'||ext_descuento_x_planilla||'",'||ext_montoexcendente||',"'||ext_fecha_emision||'",'||ext_nivel_convenio||','||ext_folio_financiador||','||ext_monto_valor_total||','||ext_monto_aporte_total||','||ext_monto_copago_total||','||ext_num_operacion||','||ext_corr_prestacion||','||ext_tipo_solicitud||',"'||ext_fecha_inicio||'","'||ext_urgencia||'","'||ext_plan||'","'||ext_lista_1 ||'","'||ext_lista_2||'","'||ext_lista_3||'",'||out_params); 
	
	return xml2;

end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_envbonis_vidacamara(varchar)
returns varchar as
$$
declare
        xml1  	alias for $1;
        xml2    varchar;
	i               integer='1';
	cod_resp1       varchar;
        mensaje_resp1   varchar;

begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Parseo la Respuesta
        cod_resp1       :=trim(get_campo('EXTCODERROR_'||i::varchar,xml2));
        mensaje_resp1   :=trim(get_campo('EXTMENSAJEERROR_'||i::varchar,xml2));
	xml2:=logapp(xml2,'VIDACAMARA: RSP_ENVBONIS -> extCodError='||cod_resp1||' -extMensajeError='||mensaje_resp1);
	
	--JCC:Fianciador no envia el campo EXTCODERROR. El Bono aprobado se informa al Percona como rechazo(IsaRechazoConfU)
	if mensaje_resp1='Sin Errores' then
		cod_resp1:='S';
	end if;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1); 
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

	xml2:=put_campo(xml2,'SQLOUTPUT','{'||get_campo('ERRORMSG',xml2)||', '||get_campo('EXTCODERROR',xml2)||', '||
                                        get_campo('EXTMENSAJEERROR',xml2)||'}');
        
	return xml2;
end;
$$
LANGUAGE plpgsql;
