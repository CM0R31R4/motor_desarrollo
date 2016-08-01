#!/bin/bash
cd /home/motor/base/funciones_motor/

psql -d motor -f  busca_tx_data_xml.sql
psql -d motor -f  correlativo_motor.sql
psql -d motor -f  codifica_utf8.sql
psql -d motor -f  genera_codmotor.sql
psql -d motor -f  get_campo.sql
psql -d motor -f  get_tag_xml.sql
psql -d motor -f  get_xml.sql
psql -d motor -f  get_tag_xml_hex.sql
psql -d motor -f  get_xml2.sql
psql -d motor -f  getipserver.sql
psql -d motor -f  is_number.sql
psql -d motor -f  motor_formato_rut.sql
psql -d motor -f  logapp.sql
psql -d motor -f  motor_isnumber.sql
psql -d motor -f  obtiene_codmotor.sql
psql -d motor -f  motor_modulo11.sql
psql -d motor -f  parser_xml.sql
psql -d motor -f  put_campo.sql
psql -d motor -f  put_tag_xml.sql
psql -d motor -f  responde_http.sql
psql -d motor -f  responde_http_scgi.sql
psql -d motor -f  respuesta_xml.sql
psql -d motor -f  respuesta_xml_hex.sql
psql -d motor -f  valida_documento_xml.sql
psql -d motor -f  ctamed_update_tx.sql
psql -d motor -f  ctamed_registra_tx.sql

