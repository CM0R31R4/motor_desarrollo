CREATE OR REPLACE FUNCTION public.servicios_dummy_3003(character varying)
RETURNS character varying
LANGUAGE plpgsql
AS $function$
declare
        xml1            alias for $1;
        xml2            varchar;
	
	tipo_tx1        varchar;

	-- Variables para SOLICFOLIOS.
	cont1           integer='1';
        aux1            varchar;
        folios1         varchar='';
        tabla1          varchar;

        valorPrest1     varchar='';
        aporteFin1      varchar='';
        extCopago1      varchar='';
        cont2           integer='1';

	-- Variables para VALORVARI y VALORIZI.
        internoIsa1     varchar='';
        tipoBonif1      varchar='';
        copago1         varchar='';
        tipoBonif2      varchar='';
        copago2         varchar='';
        tipoBonif3      varchar='';
        copago3         varchar='';
        tipoBonif4      varchar='';
        copago4         varchar='';
        tipoBonif5      varchar='';
        copago5         varchar='';

        -- Variables para COPTRAN.
        cont3           integer='1';
        lstValores1     varchar='';

BEGIN
	xml2:=xml1;

	-- Obtiene el tipo de transaccion.
	tipo_tx1:=get_campo('TX_WS',xml2);

	-- Servicio BENCERTIF
        IF (tipo_tx1='bencertif') THEN
                xml2:=logapp(xml2,'BENCERTIF : Respuesta.Dummy');

                --Variables de Respuesta
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
                xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

                xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','');

                xml2:=put_campo(xml2,'EXTAPELLIDOPAT','XXXX');
                xml2:=put_campo(xml2,'EXTAPELLIDOMAT','XXXX');
                xml2:=put_campo(xml2,'EXTNOMBRES','XXXX');
                xml2:=put_campo(xml2,'EXTSEXO','F');
                xml2:=put_campo(xml2,'EXTFECHANACIMI','19870809');
                xml2:=put_campo(xml2,'EXTCODESTBEN','C');
                xml2:=put_campo(xml2,'EXTDESCESTADO','Certificado');
                xml2:=put_campo(xml2,'EXTRUTCOTIZANTE',get_campo('EXTRUTBENEFICIARIO',xml2));
                xml2:=put_campo(xml2,'EXTNOMCOTIZANTE','XXXX');
                xml2:=put_campo(xml2,'EXTDIRPACIENTE','XXXX');
                xml2:=put_campo(xml2,'EXTGLOSACOMUNA','XXXX');
                xml2:=put_campo(xml2,'EXTGLOSACIUDAD','XXXX');
                xml2:=put_campo(xml2,'EXTPREVISION','A');
                xml2:=put_campo(xml2,'EXTGLOSA','Activo');
                xml2:=put_campo(xml2,'EXTPLAN','C');
                xml2:=put_campo(xml2,'EXTDESCUENTOXPLANILLA','N');
                xml2:=put_campo(xml2,'EXTMONTOEXCEDENTE','0');
                xml2:=put_campo(xml2,'EXTRUTACOMPANANTE','');
                xml2:=put_campo(xml2,'EXTNOMBREACOMPANANTE','');

		xml2:=put_campo(xml2,'EXTMENSAJEERROR','APROBADO MOTOR');

                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));

                -- Para registro en tabla tx_bono3.
                xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummy');
                xml2    :=b3_registra_tx(xml2);

                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

                -- No va al Financiador.
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

                RETURN xml2;
        END IF;

	-- Servicio VALIDACAT.
        IF (tipo_tx1='validacat') THEN
                xml2:=logapp(xml2,'VALIDACAT : Respuesta.Dummy');

                -- Variables de Respuesta.
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
                xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

                xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','');

                xml2:=put_campo(xml2,'EXTRESPUESTACAT','S');
                xml2:=put_campo(xml2,'EXTMENSAJECAT','OK');

                xml2:=put_campo(xml2,'EXTMENSAJEERROR','APROBADO MOTOR');

                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));

                -- Para registro en tabla tx_bono3.
                xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummy');
                xml2    :=b3_registra_tx(xml2);

                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

                -- No va al Financiador.
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

                RETURN xml2;
        END IF;

	-- Servicio VALORVARI y VALORIZI
        IF (tipo_tx1='valorvari') OR (tipo_tx1='valorizi') THEN

                IF (tipo_tx1='valorvari') THEN
                        xml2:=logapp(xml2,'VALORVARI : Respuesta.Dummy');
                END IF;

                IF (tipo_tx1='valorizi') THEN
                        xml2:=logapp(xml2,'VALORIZI : Respuesta.Dummy');
                END IF;

                while (cont2 <= get_campo('EXTNUMPRESTACIONES',xml2)::integer)
                LOOP
                        valorPrest1:=valorPrest1||'1000'||',';
                        aporteFin1:=aporteFin1||'800'||',';
                        extCopago1:=extCopago1||'200'||',';
                        internoIsa1:=internoIsa1||'"025LE PB"'||',';
                        tipoBonif1:=tipoBonif1||'0'||',';
                        copago1:=copago1||'0'||',';
                        tipoBonif2:=tipoBonif2||'0'||',';
                        copago2:=copago2||'0'||',';
                        tipoBonif3:=tipoBonif3||'0'||',';
                        copago3:=copago3||'0'||',';
                        tipoBonif4:=tipoBonif4||'0'||',';
                        copago4:=copago4||'0'||',';
                        tipoBonif5:=tipoBonif5||'0'||',';
                        copago5:=copago5||'0'||',';

                        cont2:=cont2+1;
                END LOOP;

		-- Quita la ultima coma (ya que no volvera al ciclo) y se sale.
                IF length(valorPrest1)>0 THEN
                        valorPrest1:=substring(valorPrest1,1,length(valorPrest1)-1);
                END IF;

                IF length(aporteFin1)>0 THEN
                        aporteFin1:=substring(aporteFin1,1,length(aporteFin1)-1);
                END IF;

                IF length(extCopago1)>0 THEN
                        extCopago1:=substring(extCopago1,1,length(extCopago1)-1);
                END IF;

                IF length(internoIsa1)>0 THEN
                        internoIsa1:=substring(internoIsa1,1,length(internoIsa1)-1);
                END IF;

                IF length(tipoBonif1)>0 THEN
                        tipoBonif1:=substring(tipoBonif1,1,length(tipoBonif1)-1);
                END IF;

                IF length(copago1)>0 THEN
                        copago1:=substring(copago1,1,length(copago1)-1);
                END IF;

                IF length(tipoBonif2)>0 THEN
                        tipoBonif2:=substring(tipoBonif2,1,length(tipoBonif2)-1);
                END IF;

                IF length(copago2)>0 THEN
                        copago2:=substring(copago2,1,length(copago2)-1);
                END IF;

                IF length(tipoBonif3)>0 THEN
                        tipoBonif3:=substring(tipoBonif3,1,length(tipoBonif3)-1);
                END IF;

                IF length(copago3)>0 THEN
                        copago3:=substring(copago3,1,length(copago3)-1);
                END IF;

		IF length(tipoBonif4)>0 THEN
                        tipoBonif4:=substring(tipoBonif4,1,length(tipoBonif4)-1);
                END IF;

                IF length(copago4)>0 THEN
                        copago4:=substring(copago4,1,length(copago4)-1);
                END IF;

                IF length(tipoBonif5)>0 THEN
                        tipoBonif5:=substring(tipoBonif5,1,length(tipoBonif5)-1);
                END IF;

                IF length(copago5)>0 THEN
                        copago5:=substring(copago5,1,length(copago5)-1);
                END IF;

                -- Variables de Respuesta.
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
                xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

                xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','');
                xml2:=put_campo(xml2,'EXTCODERROR','S');

                xml2:=put_campo(xml2,'EXTPLAN','A');
                xml2:=put_campo(xml2,'EXTGLOSA1','');
                xml2:=put_campo(xml2,'EXTGLOSA2','');
                xml2:=put_campo(xml2,'EXTGLOSA3','');
                xml2:=put_campo(xml2,'EXTGLOSA4','');
                xml2:=put_campo(xml2,'EXTGLOSA5','');

		xml2:=put_campo(xml2,'EXTVALORPRESTACION','['||valorPrest1||']');
                xml2:=put_campo(xml2,'EXTAPORTEFINANCIADOR','['||aporteFin1||']');
                xml2:=put_campo(xml2,'EXTCOPAGO','['||extCopago1||']');
                xml2:=put_campo(xml2,'EXTINTERNOISA','['||internoIsa1||']');

                xml2:=put_campo(xml2,'EXTTIPOBONIF1','['||tipoBonif1||']');
                xml2:=put_campo(xml2,'EXTCOPAGO1','['||copago1||']');
                xml2:=put_campo(xml2,'EXTTIPOBONIF2','['||tipoBonif2||']');
                xml2:=put_campo(xml2,'EXTCOPAGO2','['||copago2||']');
                xml2:=put_campo(xml2,'EXTTIPOBONIF3','['||tipoBonif3||']');
                xml2:=put_campo(xml2,'EXTCOPAGO3','['||copago3||']');
                xml2:=put_campo(xml2,'EXTTIPOBONIF4','['||tipoBonif4||']');
                xml2:=put_campo(xml2,'EXTCOPAGO4','['||copago4||']');
                xml2:=put_campo(xml2,'EXTTIPOBONIF5','['||tipoBonif5||']');
                xml2:=put_campo(xml2,'EXTCOPAGO5','['||copago5||']');

                xml2:=put_campo(xml2,'EXTMENSAJEERROR','OK');

                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));

                -- Para registro en tabla tx_bono3.
                xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummy');
                xml2    :=b3_registra_tx(xml2);

                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

                -- No va al Financiador.
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

                RETURN xml2;
        END IF;

	-- Servicio COPTRAN.
        IF (tipo_tx1='coptran') THEN
                xml2:=logapp(xml2,'COPTRAN : Respuesta.Dummy');

                -- Variables de Respuesta.
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
                xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

                xml2:=put_campo(xml2,'ERRORCOD','S');
                xml2:=put_campo(xml2,'ERRORMSG','Prestacion Autorizada');

                xml2:=put_campo(xml2,'EXTCODERROR','S');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','Prestacion Autorizada');
                xml2:=put_campo(xml2,'EXTPLAN','D');

                while (cont3 <= get_campo('EXTNUMPRESTACIONES',xml2)::integer)
                LOOP
                        lstValores1:=lstValores1||'<CopTran_ColOut>
                                                        <extValorPrestacion>13070</extValorPrestacion>
                                                        <extAporteFinanciador>7840</extAporteFinanciador>
                                                        <extCopago>5230</extCopago>
                                                        <extInternoIsa></extInternoIsa>
                                                   </CopTran_ColOut>';

                        cont3:=cont3+1;
                END LOOP;

                xml2:=put_campo(xml2,'LSTVALORES',lstValores1);

                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));

                -- Para registro en tabla tx_bono3.
                xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummy');
                xml2    :=b3_registra_tx(xml2);

		-- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

                -- No va al Financiador.
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

                RETURN xml2;
        END IF;

	-- Servicio SOLICFOLIOS.
        IF (tipo_tx1='solicfolios')  THEN
                xml2:=logapp(xml2,'SOLICFOLIOS : Respuesta.Dummy');

                while (cont1 <= get_campo('EXTNUMFOLIOS',xml2)::integer)
                LOOP
                        aux1:=nextval('seq_folios');
                        folios1:=folios1||aux1||',';
                        cont1:=cont1+1;
                END LOOP;

                xml2:=logapp(xml2,'FOLIOS: '||folios1);

                -- Quita la ultima coma (ya que no volvera al ciclo) y se sale.
                IF length(folios1)>0 THEN
                        folios1:=substring(folios1,1,length(folios1)-1);
                END IF;

                -- Variables de respuesta.
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
                xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

                xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','');
                xml2:=put_campo(xml2,'EXTCODERROR','S');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','Servicio Correcto');
                xml2:=put_campo(xml2,'EXFOLIOSDEVUELTOS','['||folios1||']');

                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));

                -- Para Registro en Tabla tx_bono3
                xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummies');
                xml2    :=b3_registra_tx(xml2);

		-- Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

                -- No va al Financiador
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

                RETURN xml2;
        END IF;

	-- Servicio CERMENSAJEBEN.
        IF (tipo_tx1='cermensajeben') THEN
                xml2:=logapp(xml2,'CERMENSAJEBEN : Respuesta.Dummy');

                -- Variables de Respuesta.
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
                xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

                xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','Servicio Correcto');

                xml2:=put_campo(xml2,'EXTTIPOACCION','0.0');
                xml2:=put_campo(xml2,'EXTMSGERROR1','');
                xml2:=put_campo(xml2,'EXTMSGERROR1','');


                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));

                -- Para registro en tabla tx_bono3.
                xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummy');
                xml2    :=b3_registra_tx(xml2);

                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

                -- No va al Financiador.
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

                RETURN xml2;
        END IF;

	-- Servicio VALTRANS.
        IF (tipo_tx1='valtrans') THEN
                xml2:=logapp(xml2,'VALTRANS : Respuesta.Dummy');

                -- Variables de Respuesta.
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
                xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

                xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','');

                xml2:=put_campo(xml2,'EXTRESPUESTA','E');
                xml2:=put_campo(xml2,'EXTCODERROR','S');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','');

                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));

                -- Para registro en tabla tx_bono3.
                xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummy');
                xml2    :=b3_registra_tx(xml2);

                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

                -- No va al Financiador.
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

                RETURN xml2;
        END IF;

	-- Servicio ENROLA.
        IF (tipo_tx1='enrola') THEN
                xml2:=logapp(xml2,'ENROLA : Respuesta.Dummy');

                -- Variables de Respuesta.
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
                xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

                xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','OK');

                xml2:=put_campo(xml2,'EXTVALIDO','N');
                xml2:=put_campo(xml2,'EXTNOMBRECOMP','');

                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));

                -- Para registro en tabla tx_bono3.
                xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummy');
                xml2    :=b3_registra_tx(xml2);

                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

                -- No va al Financiador.
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

                RETURN xml2;
        END IF;

	-- Servicio ANULABONOU.
        IF (tipo_tx1='anulabonou') THEN
                xml2:=logapp(xml2,'ANULABONOU : Respuesta.Dummy');

                -- Variables de Respuesta.
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
                xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

                xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','S');

                xml2:=put_campo(xml2,'EXTCODERROR','0');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','S');

                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));

                -- Para registro en tabla tx_bono3.
                xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummy');
                xml2    :=b3_registra_tx(xml2);

                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

                -- No va al Financiador.
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

                RETURN xml2;
        END IF;

	-- Servicio DATOSPREST.
        IF (tipo_tx1='datosprest') THEN
                xml2:=logapp(xml2,'DATOSPREST : Respuesta.Dummy');

                -- Variables de Respuesta.
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
                xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

                xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','OK');

                xml2:=put_campo(xml2,'EXTESTCONVENIO','');
                xml2:=put_campo(xml2,'EXTNIVEL','0');
                xml2:=put_campo(xml2,'EXTTIPOPRESTADOR','');
                xml2:=put_campo(xml2,'EXTCODESPECIALIDADES','');
                xml2:=put_campo(xml2,'EXTCODPROFESIONES','');
                xml2:=put_campo(xml2,'EXTANOSANTIGUEDAD','');

                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));

                -- Para registro en tabla tx_bono3.
                xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummy');
                xml2    :=b3_registra_tx(xml2);

                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

                -- No va al Financiador.
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

                RETURN xml2;
        END IF;

	-- Servicio LEERUTCOTIZ.
        IF (tipo_tx1='leerutcotiz') THEN
                xml2:=logapp(xml2,'LEERUTCOTIZ : Respuesta.Dummy');

                -- Variables de Respuesta.
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
                xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

                xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','');

                xml2:=put_campo(xml2,'EXTNOMCOTIZANTE','XXXX XXXX XXXX XXXX');
                xml2:=put_campo(xml2,'EXTCODERROR','S');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','Servicio Correcto');

                xml2:=put_campo(xml2,'EXTCORRBENEF','[0]');
                xml2:=put_campo(xml2,'EXTRUTBENEFICIARIO',get_campo('EXTRUTCOTIZANTE',xml2));
                xml2:=put_campo(xml2,'EXTAPELLIDOPAT','[XXXX]');
                xml2:=put_campo(xml2,'EXTAPELLIDOMAT','[XXXX]');
                xml2:=put_campo(xml2,'EXTNOMBRES','[XXXX]');
                xml2:=put_campo(xml2,'EXTCODESTBEN','[C]');
                xml2:=put_campo(xml2,'EXTDESCESTADO','[Certificado]');

                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));

                -- Para registro en tabla tx_bono3.
                xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummy');
                xml2    :=b3_registra_tx(xml2);

                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

		-- No va al Financiador.
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

                RETURN xml2;
        END IF;

        -- Servicio BENREC.
        IF (tipo_tx1='benrec') THEN
                xml2:=logapp(xml2,'BENREC : Respuesta.Dummy');

                -- Variables de Respuesta.
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
                xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

                xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','Carga Correlativo no Existe');

                xml2:=put_campo(xml2,'EXTCODRESBEN','0');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','Carga Correlativo no Existe');

                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));

                -- Para registro en tabla tx_bono3.
                xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummy');
                xml2    :=b3_registra_tx(xml2);

                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

                -- No va al Financiador.
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

                RETURN xml2;
        END IF;

	-- Servicio PRESTPAQUETE.
        IF (tipo_tx1='prestpaquete') THEN
                xml2:=logapp(xml2,'PRESTPAQUETE : Respuesta.Dummy');

                -- Variables de Respuesta.
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
                xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

                xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','');

                xml2:=put_campo(xml2,'EXTCODERROR','S');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','');

                xml2:=put_campo(xml2,'EXTCODHOMOLOGO','["0302048", "0302047"]');
                xml2:=put_campo(xml2,'EXTITEMHOMOLOGO','["0", "0"]');
                xml2:=put_campo(xml2,'EXTCANTIDAD','[1.0, 1.0]');

                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));

                -- Para registro en tabla tx_bono3.
                xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummy');
                xml2    :=b3_registra_tx(xml2);

                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

                -- No va al Financiador.
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

                RETURN xml2;
        END IF;
	
END;
$function$
