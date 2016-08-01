CREATE OR REPLACE FUNCTION traductor_in_loganulabonou(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
        rqt_query 	varchar;

	cod_fin1 	varchar;
	folio_bono1	varchar;
	dia_trx1	varchar;
	num_motor1	varchar;
	fec_inicio1	varchar;
	fec_termino1	varchar;
	orden1		varchar;

	tx_tabla1	varchar;
	total_reg1	integer;
	
	cod_motor1	varchar;
	fecha_in_tx1	varchar;
	xml_input1	varchar;
	sp_exec1	varchar;
	sp_return1	varchar;
	response_bono1	varchar;

	tx_tabla_query1	varchar;
BEGIN
        xml2		:=xml1;
	xml2		:=put_campo(xml2,'__SECUENCIAOK__','0');

	cod_fin1        :=trim(get_campo('EXTCODFINANCIADOR',xml2));
        folio_bono1     :=trim(get_campo('EXTFOLIOBONO',xml2));
	dia_trx1	:=trim(get_campo('EXTDIATRX',xml2));
	num_motor1	:=trim(get_campo('EXTNUMMOTOR',xml2));
	fec_inicio1	:=trim(get_campo('EXTFECHAINICIO',xml2));
	fec_termino1	:=trim(get_campo('EXTFECHATERMINO',xml2));
	orden1		:=trim(get_campo('EXTORDEN',xml2));

	tx_tabla_query1	:=dia_trx1||num_motor1;

	tx_tabla1	:=dia_trx1||num_motor1;
	tx_tabla1	:=('tx_bono3_'||tx_tabla1);

	xml2:=logapp(xml2,'-- TABLA: '||tx_tabla1);
	
	-- Valida la existencia de la tabla.
	IF EXISTS (
    		SELECT 1 
    		FROM   pg_catalog.pg_class c
    		JOIN   pg_catalog.pg_namespace n ON n.oid = c.relnamespace
    		WHERE  c.relname = tx_tabla1
    		AND    c.relkind = 'r')
	THEN
		-- Cuenta los registros en caso de que exista la tabla.
		EXECUTE 'SELECT COUNT(*) FROM '||tx_tabla1||' 
			 WHERE 	tipo_tx = '||chr(39)||'anulabonou'||chr(39)||' 
			 AND 	cod_fin = '||chr(39)||cod_fin1||chr(39)||' 
			 AND 	folio = '||chr(39)||folio_bono1||chr(39)||'
			 AND    fecha_in_tx >= '||chr(39)||fec_inicio1||chr(39)||'
                 	 AND    fecha_in_tx <= '||chr(39)||fec_termino1||chr(39)||';' INTO total_reg1;

		IF total_reg1::integer > 0 THEN
			IF total_reg1::integer = 1 THEN
				-- Puede recoger datos.
				IF orden1 = 'ASC' THEN
					EXECUTE 'SELECT codigo_motor, fecha_in_tx, xml_input, sp_exec, sp_return, response_bono
                           			FROM   '||tx_tabla1||'
                            			WHERE  tipo_tx = '||chr(39)||'anulabonou'||chr(39)||'
                            			AND    cod_fin = '||chr(39)||cod_fin1||chr(39)||'
                            			AND    folio = '||chr(39)||folio_bono1||chr(39)||'
                            			AND    fecha_in_tx >= '||chr(39)||fec_inicio1||chr(39)||'
                            			AND    fecha_in_tx <= '||chr(39)||fec_termino1||chr(39)||'
                            			ORDER BY fecha_in_tx ASC;' INTO cod_motor1, fecha_in_tx1, xml_input1, sp_exec1, sp_return1, response_bono1;                         
         			ELSE
                            		EXECUTE 'SELECT codigo_motor, fecha_in_tx, xml_input, sp_exec, sp_return, response_bono
                            			FROM   '||tx_tabla1||'
                            			WHERE  tipo_tx = '||chr(39)||'anulabonou'||chr(39)||'
                            			AND    cod_fin = '||chr(39)||cod_fin1||chr(39)||'
                            			AND    folio = '||chr(39)||folio_bono1||chr(39)||'
                            			AND    fecha_in_tx >= '||chr(39)||fec_inicio1||chr(39)||'
                            			AND    fecha_in_tx <= '||chr(39)||fec_termino1||chr(39)||'
                            			ORDER BY fecha_in_tx DESC;' INTO cod_motor1, fecha_in_tx1, xml_input1, sp_exec1, sp_return1, response_bono1;
            			END IF;

				xml2:=put_campo(xml2,'EXTCODERROR', '00');
        			xml2:=put_campo(xml2,'EXTMENSAJEERROR', 'Operacion OK');

				-- Variable de resultado.
        			xml2:=put_campo(xml2,'EXTCODFINANCIADOR', encode(cod_fin1::bytea,'base64'));
        			xml2:=put_campo(xml2,'EXTCODMOTOR', encode(cod_motor1::bytea,'base64'));
				xml2:=put_campo(xml2,'EXTFECHAINTRX', encode(fecha_in_tx1::bytea,'base64'));
				xml2:=put_campo(xml2,'EXTREQUEST', encode(xml_input1::bytea,'base64'));
				xml2:=put_campo(xml2,'EXTSPEXEC', encode(sp_exec1::bytea,'base64'));

				IF cod_fin1 = '1' OR cod_fin1 = '01' THEN
        				xml2:=put_campo(xml2,'EXTSPRETURN', encode(decode(sp_return1,'HEX')::bytea,'base64'));
				ELSE
					xml2:=put_campo(xml2,'EXTSPRETURN', encode(sp_return1::bytea,'base64'));
				END IF;

        			xml2:=put_campo(xml2,'EXTRESPONSE', encode(response_bono1::bytea,'base64'));

				xml2:=logapp(xml2,'-- RSP_LOG_ANULABONOU : [CodigoMotor:'||get_campo('EXTCODMOTOR', xml2)||'] - [Fecha:'||get_campo('EXTFECHAINTRX', xml2)||'] - [REQUEST:'||get_campo('EXTREQUEST', xml2)||'] - [Ejecucion:'||get_campo('EXTSPEXEC', xml2)||'] - [Resultado:'||get_campo('EXTSPRETURN', xml2)||'] - [RESPONSE:'||get_campo('EXTRESPONSE', xml2)||']');
			ELSE
				-- Tabla tiene demasiados registros. No puede continuar.
				--xml2:=put_campo(xml2,'EXTCODERROR','04');
                        	--xml2:=put_campo(xml2,'EXTMENSAJEERROR','Ups!, demasiados registros ('||total_reg1::varchar||'). Especifique su consulta.');
                        	--xml2:=logapp(xml2,'Error 04 - Demasiados registros. Especifique su consulta.');
				--xml2:=logapp(xml2,'-- RSP_LOG_ANULABONOU : [EXTCODERROR:'||get_campo('EXTCODERROR', xml2)||'] - [EXTMENSAJEERROR:'||get_campo('EXTMENSAJEERROR', xml2)||']');
				
				-- Puede recoger datos.
                                IF orden1 = 'ASC' THEN
                                        EXECUTE 'SELECT codigo_motor, fecha_in_tx, xml_input, sp_exec, sp_return, response_bono
                                                FROM   '||tx_tabla1||'
                                                WHERE  tipo_tx = '||chr(39)||'anulabonou'||chr(39)||'
                                                AND    cod_fin = '||chr(39)||cod_fin1||chr(39)||'
                                                AND    folio = '||chr(39)||folio_bono1||chr(39)||'
                                                AND    fecha_in_tx >= '||chr(39)||fec_inicio1||chr(39)||'
                                                AND    fecha_in_tx <= '||chr(39)||fec_termino1||chr(39)||'
                                                ORDER BY fecha_in_tx ASC;' INTO cod_motor1, fecha_in_tx1, xml_input1, sp_exec1, sp_return1, response_bono1;                         
                                ELSE
                                        EXECUTE 'SELECT codigo_motor, fecha_in_tx, xml_input, sp_exec, sp_return, response_bono
                                                FROM   '||tx_tabla1||'
                                                WHERE  tipo_tx = '||chr(39)||'anulabonou'||chr(39)||'
                                                AND    cod_fin = '||chr(39)||cod_fin1||chr(39)||'
                                                AND    folio = '||chr(39)||folio_bono1||chr(39)||'
                                                AND    fecha_in_tx >= '||chr(39)||fec_inicio1||chr(39)||'
                                                AND    fecha_in_tx <= '||chr(39)||fec_termino1||chr(39)||'
                                                ORDER BY fecha_in_tx DESC;' INTO cod_motor1, fecha_in_tx1, xml_input1, sp_exec1, sp_return1, response_bono1;
                                END IF;
				
				xml2:=put_campo(xml2,'EXTCODERROR', '00');
                                xml2:=put_campo(xml2,'EXTMENSAJEERROR', 'Operacion OK');

				-- Variable de resultado.
                                --xml2:=put_campo(xml2,'EXTCODFINANCIADOR', cod_fin1);
                                xml2:=put_campo(xml2,'EXTCODMOTOR', cod_motor1);
				xml2:=logapp(xml2,'CODIGO_MOTOR='||cod_motor1);
                                --xml2:=put_campo(xml2,'EXTFECHAINTRX', encode(fecha_in_tx1::bytea,'base64'));
                                --xml2:=put_campo(xml2,'EXTREQUEST', encode(xml_input1::bytea,'base64'));
                                --xml2:=put_campo(xml2,'EXTSPEXEC', encode(sp_exec1::bytea,'base64'));

                                --IF cod_fin1 = '1' OR cod_fin1 = '01' THEN
                                --        xml2:=put_campo(xml2,'EXTSPRETURN', encode(decode(sp_return1,'HEX')::bytea,'base64'));
                                --ELSE
                                --        xml2:=put_campo(xml2,'EXTSPRETURN', encode(sp_return1::bytea,'base64'));
                                --END IF;

                                --xml2:=put_campo(xml2,'EXTRESPONSE', encode(response_bono1::bytea,'base64'));

                                --xml2:=logapp(xml2,'-- RSP_LOG_ANULABONOU : [CodigoMotor:'||get_campo('EXTCODMOTOR', xml2)||'] - [Fecha:'||get_campo('EXTFECHAINTRX', xml2)||'] - [REQUEST:'||get_campo('EXTREQUEST', xml2)||'] - [Ejecucion:'||get_campo('EXTSPEXEC', xml2)||'] - [Resultado:'||get_campo('EXTSPRETURN', xml2)||'] - [RESPONSE:'||get_campo('EXTRESPONSE', xml2)||']');

			END IF;
		ELSE
			-- Tabla no tiene registros.
                	xml2:=put_campo(xml2,'EXTCODERROR','05');
                	xml2:=put_campo(xml2,'EXTMENSAJEERROR','Oooh, que mal. No hay registro para mostrar.');
                	--xml2:=logapp(xml2,'Error 05 - No hay registro para mostrar.');
			xml2:=logapp(xml2,'-- RSP_LOG_ANULABONOU : [EXTCODERROR:'||get_campo('EXTCODERROR', xml2)||'] - [EXTMENSAJEERROR:'||get_campo('EXTMENSAJEERROR', xml2)||']');
		END IF;
	ELSE
		-- En caso de que NO exista la tabla.
		xml2:=put_campo(xml2,'EXTCODERROR','06');
        	xml2:=put_campo(xml2,'EXTMENSAJEERROR','Todo mal, la tabla NO existe.');
		--xml2:=logapp(xml2,'Error 06 - La tabla NO existe.'); 
		xml2:=logapp(xml2,'-- RSP_LOG_ANULABONOU : [EXTCODERROR:'||get_campo('EXTCODERROR', xml2)||'] - [EXTMENSAJEERROR:'||get_campo('EXTMENSAJEERROR', xml2)||']');
	END IF;
	
	RETURN xml2;
END;
$$
LANGUAGE plpgsql;
