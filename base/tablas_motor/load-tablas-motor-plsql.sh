#!/bin/bash
cd /home/motor/base/tablas_motor/

psql -d motor -f t_convert_octal_ascii.sql
psql -d motor -f t_formatos.sql
psql -d motor -f t_respuestas_soap.sql
psql -d motor -f t_servicios.sql
psql -d motor -f t_tx_ctamed.sql
psql -d motor -f t_procesos.sql
psql -d motor -f t_define_secuencia_ws.sql
psql -d motor -f t_isys_tx_formatos.sql
psql -d motor -f t_isys_querys_tx.sql
psql -d motor -f t_parametros_procesos_motor.sql
psql -d motor -f t_ip_motores.sql
psql -d motor -f t_base_datos.sql

