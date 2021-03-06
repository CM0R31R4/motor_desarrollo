CREATE OR REPLACE FUNCTION traductor_in_leerutcotiz_chuqui(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	cod_fin1	varchar;
	rut_cotiza1	varchar;
	l_array	varchar;
begin
        xml2:=xml1;
	l_array:=40;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        cod_fin1	:= trim(get_campo('EXTCODFINANCIADOR',xml2));
	rut_cotiza1	:= get_campo('EXTRUTCOTIZANTE',xml2);
	
	--Valida formato del Rut
        rut_cotiza1      :=motor_formato_rut(rut_cotiza1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_cotiza1='') then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;
        --Envia y almacena lo que viene.:
        xml2    :=put_campo(xml2,'RUT_BASE',rut_cotiza1);
        
        xml2:=put_campo(xml2,'SQLINPUT','["ADMIMED.CHULEERUTCOTIZ_PKG.CHULEERUTCOTIZ", [ "$o$STRING", '||cod_fin1||', '||chr(34)||rut_cotiza1||chr(34)||',"$o$STRING", "$o$STRING", "$o$STRING", "$o$NUMBER['||l_array||']", "$o$STRING['||l_array||']","$o$STRING['||l_array||']", "$o$STRING['||l_array||']", "$o$STRING['||l_array||']", "$o$STRING['||l_array||']", "$o$STRING['||l_array||']"]]'||chr(10)||chr(10));

	return xml2;
end;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION traductor_out_leerutcotiz_chuqui(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        aux1    varchar;
        resp1   varchar;

	nombre_cotiz1   varchar;
        cod_resp1       varchar;
        mensaje_resp1   varchar;

        corr_benef1     varchar;
        rut_benef1      varchar;
        apell_pat1      varchar;
        apell_mat1      varchar;
        nombres1        varchar;
        cod_est_benef1  varchar;
        desc_estado1    varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        resp1:=replace(get_campo('SQLOUTPUT',xml2),chr(10),'');
        aux1:=json_field(resp1,'result');
 
	if aux1 is null then
                aux1:=json_field(resp1,'ora-msg');
		if aux1 is not null then
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG',replace(aux1,'\\n',''));
                else
                        xml2:=put_campo(xml2,'ERRORCOD','99');
			xml2:=put_campo(xml2,'ERRORMSG','Chuqui:Error_LeeRutCotiz');
                end if;
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error en Respuesta del Financiador');
		return xml2;
        end if;

	nombre_cotiz1   :=trim(replace(json_field(aux1,'1'),'"',''));
        cod_resp1       :=trim(replace(json_field(aux1,'2'),'"',''));
        mensaje_resp1   :=trim(replace(json_field(aux1,'3'),'"',''));

        corr_benef1     :=replace(trim(replace(json_field(aux1,'4'),'"','')),'.0','');
        rut_benef1      :=trim(replace(json_field(aux1,'5'),'"',''));
        apell_pat1      :=trim(replace(json_field(aux1,'6'),'"',''));
        apell_mat1      :=trim(replace(json_field(aux1,'7'),'"',''));
        nombres1        :=trim(replace(json_field(aux1,'8'),'"',''));
        cod_est_benef1  :=trim(replace(json_field(aux1,'9'),'"',''));
        desc_estado1    :=trim(replace(json_field(aux1,'10'),'"',''));
        
	xml2:=logapp(xml2,'CHUQUICAMATA: RSP_LEERUTCOTIZ -> extNombreCotiz1='||nombre_cotiz1||' -extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1||' -extCorrBenef1='||corr_benef1||' -extRutBenef1='||rut_benef1||' -extApellPat1='||apell_pat1||' -extApellMat1='||apell_mat1||' -extNombres1='||nombres1||' -extCodEstBenef1='||cod_est_benef1||' -extDescEstado1='||desc_estado1);	

	--raise notice 'JCC_LEERUTCOTIZ_Receive extNomCotizante=% - extCodError=% - extMensajeError=% - extApellidoPat=% ',nombre_cotiz1,cod_resp1,mensaje_resp1,apell_pat1;

        if mensaje_resp1='null' then mensaje_resp1=''; end if;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',replace(json_field(aux1,'0'),'"',''));
        --Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'EXTNOMCOTIZANTE',nombre_cotiz1);
        xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

        xml2:=put_campo(xml2,'EXTCORRBENEF',corr_benef1);
        xml2:=put_campo(xml2,'EXTRUTBENEFICIARIO',rut_benef1);
        xml2:=put_campo(xml2,'EXTAPELLIDOPAT',apell_pat1);
        xml2:=put_campo(xml2,'EXTAPELLIDOMAT',apell_mat1);
        xml2:=put_campo(xml2,'EXTNOMBRES',nombres1);
        xml2:=put_campo(xml2,'EXTCODESTBEN',cod_est_benef1);
        xml2:=put_campo(xml2,'EXTDESCESTADO',desc_estado1);

	return xml2;
end;
$$
LANGUAGE plpgsql;
