CREATE OR REPLACE FUNCTION traductor_in_validacat_fonasa(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        data1   varchar;
        rqt_xml1	varchar;

	cod_fin1        varchar;
	rut_conv1       varchar;
	rut_tratat1     varchar;
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
	
	cod_fin1        :=get_campo('EXTCODFINANCIADOR',xml2);  /*SP MASVIDA NO TIENE DEFINIDO ESTE PARAMETRO*/
        rut_conv1       :=get_campo('EXTRUTCONVENIO',xml2);
        rut_tratat1     :=get_campo('EXTRUTTRATANTE',xml2);
        rut_solic1      :=get_campo('EXTRUTSOLICITANTE',xml2);
        rut_benef1      :=get_campo('EXTRUTBENEFICIARIO',xml2);
        rut_cotiz1      :=get_campo('EXTRUTCOTIZANTE',xml2);
        cod_homologo1   :=coalesce(nullif(get_campo('EXTCODIGOHOMOLOGO',xml2),''),'0');
        item1           :=coalesce(nullif(get_campo('EXTITEM',xml2),''),'0');
        cod_diag1       :=coalesce(nullif(get_campo('EXTCODIGODIAGNOSTICO',xml2),''),'0');
        cod_moda1       :=coalesce(nullif(get_campo('EXTCODMODALIDAD',xml2),''),'0');
        cod_tipaten1    :=coalesce(nullif(get_campo('EXTCODTIPATENCION',xml2),''),'0');
	fecha_nac1      :=to_char(get_campo('EXTFECHANACIMIENTO',xml2)::date, 'YYYY/MM/DD'); --AAAA/MM/DD
        cod_sexo1       :=coalesce(nullif(get_campo('EXTCODSEXO',xml2),''),'0');
        fecha_inicio1   :=to_char(get_campo('EXTFECHAINICIO',xml2)::date, 'YYYY/MM/DD'); --AAAA/MM/DD
        fecha_termino1  :=to_char(get_campo('EXTFECHATERMINO',xml2)::date, 'YYYY/MM/DD'); --AAAA/MM/DD
	frec_prestdia1  :=coalesce(nullif(get_campo('EXTFRECPRESTDIA',xml2),''),'0');
        lista1          :=coalesce(nullif(get_campo('EXTLISTAPRESTACA',xml2),''),'0');
        lista2          :=coalesce(nullif(get_campo('EXTLISTAPRESTACB',xml2),''),'0');
        lista3          :=coalesce(nullif(get_campo('EXTLISTAPRESTACC',xml2),''),'0');
        lista4          :=coalesce(nullif(get_campo('EXTLISTAPRESTACD',xml2),''),'0');
        lista5          :=coalesce(nullif(get_campo('EXTLISTAPRESTACE',xml2),''),'0');
        lista6          :=coalesce(nullif(get_campo('EXTLISTAPRESTACF',xml2),''),'0');
	ind_video1      :=coalesce(nullif(get_campo('EXTINDVIDEO',xml2),''),'0');
        ind_bilateral1  :=coalesce(nullif(get_campo('EXTINDBILATERAL',xml2),''),'0');
        recargo1        :=coalesce(nullif(get_campo('EXTRECARGOFUERAHORA',xml2),''),'0');
        ind_reembolso1  :=coalesce(nullif(get_campo('EXTINDREEMBOLSO',xml2),''),'0');
        ind_programa1   :=coalesce(nullif(get_campo('EXTINDPROGRAMA',xml2),''),'0');
        cod_app1        :=coalesce(nullif(get_campo('EXTCODAPLICACION',xml2),''),'0');
        cod_reg1        :=coalesce(nullif(get_campo('EXTCODREGION',xml2),''),'0');
        cod_suc1        :=coalesce(nullif(get_campo('EXTCODSUCUR',xml2),''),'0');
        tipo_prest1     :=coalesce(nullif(get_campo('EXTTIPOPRESTADOR',xml2),''),'0');
        cod_espec1      :=coalesce(nullif(get_campo('EXTCODESPECIALIDADES',xml2),''),'0');
        cod_prof1       :=coalesce(nullif(get_campo('EXTCODPROFESIONES',xml2),''),'0');
        antiguedad1     :=coalesce(nullif(get_campo('EXTANOSANTIGUEDAD',xml2),''),'0');

	--Valida formato del Rut
        /*rut_conv1      :=motor_formato_rut(rut_conv1);
        rut_tratat1     :=motor_formato_rut(rut_tratat1);
        rut_solic1      :=motor_formato_rut(rut_solic1);
        rut_benef1      :=motor_formato_rut(rut_benef1);
        rut_cotiz1      :=motor_formato_rut(rut_cotiz1);
        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_conv1='')       or (rut_tratat1='')     or
           (rut_solic1='')      or (rut_benef1='')      or
           (rut_cotiz1='')      then
        
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;*/

        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

	--Armo el Xml Request que va a Fonasa
        rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wsc="http://WSCerFonasaNM/"><soapenv:Header/><soapenv:Body><wsc:ValidaCat>
	<wsc:extCodFinanciador>'||cod_fin1||'</wsc:extCodFinanciador>
	<wsc:extRutConvenio>'||rut_conv1||'</wsc:extRutConvenio>
	<wsc:extRutTratante>'||rut_tratat1||'</wsc:extRutTratante>
	<wsc:extRutSolicitante>'||rut_solic1||'</wsc:extRutSolicitante>
	<wsc:extRutBeneficiario>'||rut_benef1||'</wsc:extRutBeneficiario>
	<wsc:extRutCotizante>'||rut_cotiz1||'</wsc:extRutCotizante>
	<wsc:extCodigoHomologo>'||cod_homologo1||'</wsc:extCodigoHomologo>
	<wsc:extItem>'||item1||'</wsc:extItem>
	<wsc:extCodigoDiagnostico>'||cod_diag1||'</wsc:extCodigoDiagnostico>
	<wsc:extCodModalidad>'||cod_moda1||'</wsc:extCodModalidad>
	<wsc:extCodTipAtencion>'||cod_tipaten1||'</wsc:extCodTipAtencion>
	<wsc:extFechaNacimi>'||fecha_nac1||'</wsc:extFechaNacimi>
	<wsc:extSexo>'||cod_sexo1||'</wsc:extSexo>
	<wsc:extFechaInicio>'||fecha_inicio1||'</wsc:extFechaInicio>
	<wsc:extFechaTermino>'||fecha_termino1||'</wsc:extFechaTermino>
	<wsc:extFrecPrestDia>'||frec_prestdia1||'</wsc:extFrecPrestDia>
	<wsc:extListaPrestacA>'||lista1||'</wsc:extListaPrestacA>
	<wsc:extListaPrestacB>'||lista2||'</wsc:extListaPrestacB>
	<wsc:extListaPrestacC>'||lista3||'</wsc:extListaPrestacC>
	<wsc:extListaPrestacD>'||lista4||'</wsc:extListaPrestacD>
	<wsc:extListaPrestacE>'||lista5||'</wsc:extListaPrestacE>
	<wsc:extListaPrestacF>'||lista6||'</wsc:extListaPrestacF>
	<wsc:extIndVideo>'||ind_video1||'</wsc:extIndVideo>
	<wsc:extIndBilateral>'||ind_bilateral1||'</wsc:extIndBilateral>
	<wsc:extRecargoFueraHora>'||recargo1||'</wsc:extRecargoFueraHora>
	<wsc:extIndReembolso>'||ind_reembolso1||'</wsc:extIndReembolso>
	<wsc:extIndPrograma>'||ind_programa1||'</wsc:extIndPrograma>
	<wsc:extCodAplicacion>'||cod_app1||'</wsc:extCodAplicacion>
	<wsc:extCodRegion>'||cod_reg1||'</wsc:extCodRegion>
	<wsc:extCodSucur>'||cod_suc1||'</wsc:extCodSucur>
	<wsc:extTipoPrestador>'||tipo_prest1||'</wsc:extTipoPrestador>
	<wsc:extCodEspecialidades>'||cod_espec1||'</wsc:extCodEspecialidades>
	<wsc:extCodProfesiones>'||cod_prof1||'</wsc:extCodProfesiones>
	<wsc:extAnosAntiguedad>'||antiguedad1||'</wsc:extAnosAntiguedad>
	</wsc:ValidaCat></soapenv:Body></soapenv:Envelope>';

        data1:='POST /WSCerFonasa/WSCerFonasa.asmx HTTP/1.1'||chr(10)||
                'Accept-Encoding: gzip,deflate'||chr(10)||
                'Content-Type: text/xml;charset=UTF-8'||chr(10)||
                'SOAPAction: "http://WSCerFonasaNM/ValidaCat"'||chr(10)||
                'User-Agent: Jakarta Commons-HttpClient/3.1'||chr(10)||
                'Host: 10.100.32.129'||chr(10)||
                'Content-Length: '||length(rqt_xml1)||chr(10)||chr(10)||rqt_xml1;

        --Envio la data
        xml2:=put_campo(xml2,'SQLINPUT',data1);
        --xml2:=put_campo(xml2,'INPUT',data1);
	
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_validacat_fonasa(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	rsp_xml1	varchar;
	cod_resp1       varchar;
        mensaje_resp1   varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Parseo la Respuesta
        rsp_xml1:=get_campo('SQLOUTPUT',xml2);

        --Si no hay respuesta Fonasa.
        if length(rsp_xml1)=0 then
                xml2:=put_campo(xml2,'ESTADO_WS','-1');
		xml2:=logapp(xml2,'Fonasa no Responde');
                return xml2;
        end if;	

	--Si tengo data y hay error HTTP
        if strpos(rsp_xml1,'323030204f4b')>0 then
		cod_resp1	:=trim(get_tag_xml_hex('extRespuestaCAT',rsp_xml1));
		mensaje_resp1	:=trim(get_tag_xml_hex('extMensajeCAT',rsp_xml1));
        else
                cod_resp1:='S';
                --mensaje_resp1:='Error Call Fonasa_WS';
                mensaje_resp1:=trim(get_tag_xml_hex('faultstring',rsp_xml1));
		xml2:=put_campo(xml2,'API_CODRESPUESTA','2');
                xml2:=put_campo(xml2,'API_ERROR','500');
                xml2:=put_campo(xml2,'API_DESCRIPCION_ERROR','Fonasa responde error');
                xml2:=logapp(xml2,'Fonasa no responde 200 OK');
                return xml2;
        end if;

	xml2:=logapp(xml2,'FONASA: RSP_VALIDACAT -> extRespuestaCAT='||cod_resp1||' -extMensajeCAT='||mensaje_resp1);
	--Para que conteste con Campos en HEX
        xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');
	
	xml2:=put_campo(xml2,'ERRORCOD','30');
        xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);
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
