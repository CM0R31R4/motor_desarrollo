CREATE OR REPLACE FUNCTION traductor_in_validacat_consalud(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	cod_fin1        varchar;
	rut_conv1       varchar;
	rut_tratante1     varchar;
	rut_solic1	varchar;
	rut_benef1	varchar;
	rut_cotiz1      varchar;
	cod_homologo1   varchar;
	item1           varchar;
	cod_diag1	varchar;
	cod_moda1       varchar;
	cod_tipaten1    varchar;
	fecha_nac1      varchar;
	cod_sexo1       varchar;
	fecha_inicio1   varchar;
	fecha_termino1  varchar;
	frec_prestdia1  varchar;
	lista1		varchar;
	lista2          varchar;
	lista3		varchar;
	lista4		varchar;
	lista5		varchar;
	lista6		varchar;
	ind_video1      varchar;
	ind_bilateral1  varchar;
	recargo1	varchar;
	ind_reembolso1  varchar;
	ind_programa1   varchar;
	cod_app1	varchar;
	cod_reg1        varchar;
	cod_suc1        varchar;
	tipo_prest1     varchar;
	cod_espec1	varchar;
	cod_prof1	varchar;
	antiguedad1     varchar;
	
begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));


	cod_fin1	:= trim(get_campo('EXTCODFINANCIADOR',xml2));
        rut_conv1	:= get_campo('EXTRUTCONVENIO',xml2);
        rut_tratante1	:= get_campo('EXTRUTTRATANTE',xml2);
        rut_solic1	:= get_campo('EXTRUTSOLICITANTE',xml2);
        rut_benef1	:= get_campo('EXTRUTBENEFICIARIO',xml2);
        rut_cotiz1	:= get_campo('EXTRUTCOTIZANTE',xml2);
        cod_homologo1	:= get_campo('EXTCODIGOHOMOLOGO',xml2);
        item1		:= get_campo('EXTITEM',xml2);
        cod_diag1	:= get_campo('EXTCODIGODIAGNOSTICO',xml2);
        cod_moda1	:= get_campo('EXTCODMODALIDAD',xml2);
        cod_tipaten1	:= get_campo('EXTCODTIPATENCION',xml2);
        fecha_nac1	:= to_char(get_campo('EXTFECHANACIMIENTO',xml2)::date, 'YYYYMMDD');
        --fecha_nac1	:= to_char(get_campo('EXTFECHANACIMIENTO',xml2)::date, 'DD-MON-YYYY');
        cod_sexo1	:= get_campo('EXTCODSEXO',xml2);
        fecha_inicio1	:= to_char(get_campo('EXTFECHAINICIO',xml2)::date, 'YYYYMMDD');
        --fecha_inicio1	:= to_char(get_campo('EXTFECHAINICIO',xml2)::date, 'DD-MON-YYYY');
        fecha_termino1	:= to_char(get_campo('EXTFECHATERMINO',xml2)::date, 'YYYYMMDD');
        --fecha_termino1	:= to_char(get_campo('EXTFECHATERMINO',xml2)::date, 'DD-MON-YYYY');
        frec_prestdia1	:= get_campo('EXTFRECPRESTDIA',xml2);
        lista1		:= get_campo('EXTLISTAPRESTACA',xml2);
        lista2		:= get_campo('EXTLISTAPRESTACB',xml2);
        lista3		:= get_campo('EXTLISTAPRESTACC',xml2);
        lista4		:= get_campo('EXTLISTAPRESTACD',xml2);
        lista5		:= get_campo('EXTLISTAPRESTACE',xml2);
        lista6		:= get_campo('EXTLISTAPRESTACF',xml2);
        ind_video1	:= get_campo('EXTINDVIDEO',xml2);
        ind_bilateral1	:= get_campo('EXTINDBILATERAL',xml2);
        recargo1	:= get_campo('EXTRECARGOFUERAHORA',xml2);
        ind_reembolso1	:= get_campo('EXTINDREEMBOLSO',xml2);
        ind_programa1	:= get_campo('EXTINDPROGRAMA',xml2);
        cod_app1	:= get_campo('EXTCODAPLICACION',xml2);
        cod_reg1	:= get_campo('EXTCODREGION',xml2);
        cod_suc1	:= get_campo('EXTCODSUCUR',xml2);
        tipo_prest1	:= get_campo('EXTTIPOPRESTADOR',xml2);
        cod_espec1	:= get_campo('EXTCODESPECIALIDADES',xml2);
        cod_prof1	:= get_campo('EXTCODPROFESIONES',xml2);
        antiguedad1	:= get_campo('EXTANOSANTIGUEDAD',xml2);

	--Valida formato del Rut
        /*rut_conv1      	:=motor_formato_rut(rut_conv1);
        rut_tratante1   :=motor_formato_rut(rut_tratante1);
        rut_solic1      :=motor_formato_rut(rut_solic1);
        rut_benef1      :=motor_formato_rut(rut_benef1);
        rut_cotiz1      :=motor_formato_rut(rut_cotiz1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_conv1='')       or (rut_tratante1='')     or
           (rut_solic1='')      or (rut_benef1='')      or
           (rut_cotiz1='')      then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;*/
        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

	xml2:=put_campo(xml2,'SQLINPUT','["IMEDSOF.CONVALIDACAT_PKG.CONVALIDACAT", [ "$o$STRING", '||cod_fin1||','||chr(34)||rut_conv1||chr(34)||','||chr(34)||rut_tratante1||chr(34)||','||chr(34)||rut_solic1||chr(34)||','||chr(34)||rut_benef1||chr(34)||','||chr(34)||rut_cotiz1||chr(34)||','||chr(34)||cod_homologo1||chr(34)||','||chr(34)||item1||chr(34)||','||chr(34)||cod_diag1||chr(34)||','||chr(34)||cod_moda1||chr(34)||','||chr(34)||cod_tipaten1||chr(34)||','||chr(34)||fecha_nac1||chr(34)||','||chr(34)||cod_sexo1||chr(34)||','||chr(34)||fecha_inicio1||chr(34)||','||chr(34)||fecha_termino1||chr(34)||','||frec_prestdia1||','||chr(34)||lista1||chr(34)||','||chr(34)||lista2||chr(34)||','||chr(34)||lista3||chr(34)||','||chr(34)||lista4||chr(34)||','||chr(34)||lista5||chr(34)||','||chr(34)||lista6||chr(34)||','||chr(34)||ind_video1||chr(34)||','||chr(34)||ind_bilateral1||chr(34)||','||chr(34)||recargo1||chr(34)||','||chr(34)||ind_reembolso1||chr(34)||','||chr(34)||ind_programa1||chr(34)||','||chr(34)||cod_app1||chr(34)||','||chr(34)||cod_reg1||chr(34)||','||chr(34)||cod_suc1||chr(34)||','||chr(34)||tipo_prest1||chr(34)||','||chr(34)||cod_espec1||chr(34)||','||chr(34)||cod_prof1||chr(34)||','||chr(34)||antiguedad1||chr(34)||',  "$o$STRING", "$o$STRING" ]]'||chr(10)||chr(10));	

	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_validacat_consalud(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	aux1	varchar;
	resp1	varchar;

	cod_resp1       varchar;
        mensaje_resp1   varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        --Paseo la respuesta
	resp1:=replace(get_campo('SQLOUTPUT',xml2),chr(10),'');

        --Si no esta el tag result es porque hay error
        aux1:=json_field(resp1,'result');
        if aux1 is null then
                --Vemos si hay error del ORACLE
                aux1:=json_field(resp1,'ora-msg');
                if aux1 is not null then
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG',replace(aux1,'\\n',''));
                --Otro Error
                else
                        xml2:=put_campo(xml2,'ERRORCOD','99');
			xml2:=put_campo(xml2,'ERRORMSG','Consalud:Error_ValidaCat');
                end if;
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error en Respuesta del Financiador');
                return xml2;
        end if;
	
	--Paseo la respuesta	
	cod_resp1	:=trim(replace(json_field(aux1,'1'),'"',''));
	mensaje_resp1	:=trim(replace(json_field(aux1,'2'),'"',''));	
	xml2:=logapp(xml2,'CONSALUD: RSP_VALIDACAT -> extRespuestaCat='||cod_resp1||' -extMensajeCat='||mensaje_resp1);
	
	if mensaje_resp1='null' then mensaje_resp1=''; end if;
	
	xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',replace(json_field(aux1,'0'),'"',''));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'EXTRESPUESTACAT',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJECAT',mensaje_resp1);
	--Solo para que guarde el mensaje de error 
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);
        return xml2;
end;
$$
LANGUAGE plpgsql;
