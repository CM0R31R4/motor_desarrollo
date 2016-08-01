#!/bin/bash
cd /home/motor/base/cias

psql -d motor -f graba_tx_cia.sql
psql -d motor -f responde_http_anulacionbono3_cia.sql
psql -d motor -f responde_http_anulacion_cia.sql
psql -d motor -f responde_http_certificacion_cia.sql
psql -d motor -f responde_http_conciliacion_cia.sql
psql -d motor -f responde_http_conf_cia.sql
psql -d motor -f responde_http_confirmacionbono3_cia.sql
psql -d motor -f responde_http_confirmacion_cia.sql
psql -d motor -f responde_http_scgi.sql
psql -d motor -f sp_actualiza_req_cia.sql
psql -d motor -f sp_input_cia_cbvida_anula.sql
psql -d motor -f sp_input_cia_cbvida_cert.sql
psql -d motor -f sp_input_cia_cbvida_concilia.sql
psql -d motor -f sp_input_cia_cbvida_conf.sql
psql -d motor -f sp_input_cia_chicon_anulacion.sql
psql -d motor -f sp_input_cia_chicon_cert.sql
psql -d motor -f sp_input_cia_chicon_conf.sql
psql -d motor -f sp_input_cia_generica_cert.sql
psql -d motor -f sp_input_cia_generica.sql
psql -d motor -f sp_input_cia_mpro_cert.sql
psql -d motor -f sp_input_cia_mpro.sql
psql -d motor -f sp_procesa_respuesta_cola_cia.sql
psql -d motor -f sp_respuesta_cia_generica.sql
psql -d motor -f t_requerimientos_cia.sql
