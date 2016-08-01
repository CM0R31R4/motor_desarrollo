drop table parametros_procesos CASCADE;
create table parametros_procesos (
id_fin			integer,
nom_fin			varchar,
fin_modulo_api		varchar,
fin_puerto_local_api	integer,
fin_secuencia_puertos_api	varchar,
fin_hilos_api		integer,
fin_prefijo_api		varchar,
fin_base_datos		varchar,
fin_ip_conexion_bd	varchar,
fin_usuario_bd		varchar,
fin_clave_bd		varchar,
fin_port_ora_conn	integer,
fin_reintentos_conn	integer,
fin_timeout_conn	integer,
pxml_modulo		varchar,
pxml_puerto_bd		integer,
pxml_prefijo_log	varchar,
pxml_timeoutbd		integer,
lstr_modulo		varchar,
lstr_puerto_db		integer,
lstr_prefijo_log	varchar,
lstr_timeout_leedata	integer
);

create index parametros_procesos_01 on parametros_procesos(id_fin);
create index parametros_procesos_02 on parametros_procesos(nom_fin);

--Posgres.Bono3
insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata) values  (100,'MOTOR','Api_PG','9000',5,'API','motor','127.0.0.1','isys','pwd','PXML','9000','XML',10,'LSTR',9000,'LST',20);

--Fonasa.Bono3
insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata) values  (1,'FONASA','API_FONASA_BNO','8201',2,'API','dmotor','127.0.0.1','isys','pwd','FONASA_PXML_BNO','9000','XML',10,'FONASA_LSTR_BNO',9000,'LST',20);
--Cchc.Bono3
insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata) values  (11,'CCHC','API_CCHC_BNO','8211',2,'API','sermed','10.150.73.18:1596','imed','servicio','CCHC_PXML_BNO','9000','XML',10,'CCHC_LSTR_BNO',9000,'LST',20);
--VidaCamara.Bono3
insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata) values  (44,'VIDACAMARA','API_VIDACAMARA_BNO','8244',2,'API','vcamara','10.150.73.18:1596','imedvc','serviciovc','VIDACAMARA_PXML_BNO','9000','XML',10,'VIDACAMARA_LSTR_BNO',9000,'LST',20);
--Colmena.Bono3
insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata) values  (67,'COLMENA','API_COLMENA_BNO','8267',2,'API','isapre','4.0.11.22:12700','orden','orden$1$','COLMENA_PXML_BNO','9000','XML',10,'COLMENA_LSTR_BNO',9000,'LST',20);
--CruzBlanca.Bono3
insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata) values  (78,'CRUZBLANCA','API_CRUZBLANCA_BNO','8278',2,'API','master','172.31.16.57:10000','CSALUD00','CSALUD00','CRUZBLANCA_PXML_BNO','9000','XML',10,'CRUZBLANCA_LSTR_BNO',9000,'LST',20);
--Ferrosalud.Bono3
insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata) values  (81,'FERROSALUD','API_FERROSALUD_BNO','8281',2,'API','MASTER','10.40.100.2','IMED','ferroimed.2006','FERROSALUD_PXML_BNO','9000','XML',10,'FERROSALUD_LSTR_BNO',9000,'LST',20);
--MasVida.Bono3
insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata) values  (88,'MASVIDA','API_MASVIDA_BNO','8288',2,'API','AGENCIAS','150.10.10.31:1433','IMED','20050331','MASVIDA_PXML_BNO','9000','XML',10,'MASVIDA_LSTR_BNO',9000,'LST',20);

/****************/
/**SETUP ORACLE**/
/****************/
--SanLorenzo-Fusat-Chuquicamata-RioBlanco.Bono3. Con Secuencial de Puertos (10 Instancias).
--insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,fin_port_ora_conn,fin_reintentos_conn,fin_timeout_conn,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata,fin_secuencia_puertos_api) values (62,'SANLORENZO','SANLORENZO.py','8310',10,'API','IFUSAT','192.168.220.19','ADMIMED','ADMIMED',1521,2,5,'SANLORENZO_PXML_BNO','9000','XML',10,'SANLORENZO_LSTR_BNO',9000,'LST',20,'seq_puerto_sanlorenzo');

--insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,fin_port_ora_conn,fin_reintentos_conn,fin_timeout_conn,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata,fin_secuencia_puertos_api) values (63,'FUSAT','FUSAT.py','8320',10,'API','IFUSAT','192.168.220.19','ADMIMED','ADMIMED',1522,2,5,'FUSAT_PXML_BNO','9000','XML',10,'FUSAT_LSTR_BNO',9000,'LST',20,'seq_puerto_fusat');

--El 2015-07-14 se cambia puerto del 1522 al 1521.
insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,fin_port_ora_conn,fin_reintentos_conn,fin_timeout_conn,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata,fin_secuencia_puertos_api) values (63,'FUSAT','FUSAT.py','8320',10,'API','IFUSAT','192.168.220.19','ADMIMED','ADMIMED',1521,2,5,'FUSAT_PXML_BNO','9000','XML',10,'FUSAT_LSTR_BNO',9000,'LST',20,'seq_puerto_fusat');

--insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,fin_port_ora_conn,fin_reintentos_conn,fin_timeout_conn,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata,fin_secuencia_puertos_api) values (65,'CHUQUICAMATA','CHUQUICAMATA.py','8330',10,'API','IFUSAT','192.168.220.19','ADMIMED','ADMIMED',1521,2,5,'CHUQUICAMATA_PXML_BNO','9000','XML',10,'CHUQUICAMATA_LSTR_BNO',9000,'LST',20,'seq_puerto_chuquicamata');
--insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,fin_port_ora_conn,fin_reintentos_conn,fin_timeout_conn,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata,fin_secuencia_puertos_api) values (68,'RIOBLANCO','RIOBLANCO.py','8340',10,'API','IFUSAT','192.168.220.19','ADMIMED','ADMIMED',1521,14,'RIOBLANCO_PXML_BNO','9000','XML',10,'RIOBLANCO_LSTR_BNO',9000,'LST',20,'seq_puerto_rioblanco');

--Consalud.Bono3. Con Secuencial de Puertos (10 Instancias).
insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,fin_port_ora_conn,fin_reintentos_conn,fin_timeout_conn,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata,fin_secuencia_puertos_api) values (71,'CONSALUD','CONSALUD.py','8350',10,'API','TATESA','172.20.8.88','imedcon','imedcon',1522,1,14,'CONSALUD_PXML_BNO','9000','XML',10,'CONSALUD_LSTR_BNO',9000,'LST',20,'seq_puerto_consalud');
--insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,fin_port_ora_conn,fin_reintentos_conn,fin_timeout_conn,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata,fin_secuencia_puertos_api) values (71,'CONSALUD','CONSALUD.py','8350',10,'API','atesa','172.20.2.164','imedcon','imedcon',1521,1,14,'CONSALUD_PXML_BNO','9000','XML',10,'CONSALUD_LSTR_BNO',9000,'LST',20,'seq_puerto_consalud');

--Fundacion.Bono3. Con Secuencial de Puertos (10 Instancias).
insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,fin_port_ora_conn,fin_reintentos_conn,fin_timeout_conn,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata,fin_secuencia_puertos_api) values (76,'FUNDACION','FUNDACION.py','8360',10,'API','test','10.100.100.42','usr_imed','076imed',1521,2,5,'FUNDACION_PXML_BNO','9000','XML',10,'FUNDACION_LSTR_BNO',9000,'LST',20,'seq_puerto_fundacion');

--VidaTres.Bono3. Con Secuencial de Puertos (10 Instancias).
--insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,fin_port_ora_conn,fin_reintentos_conn,fin_timeout_conn,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata,fin_secuencia_puertos_api) values (80,'VIDATRES','VIDATRES.py','8370',10,'API','QSUCU','164.77.11.82','imed','imedqa',1521,2,5,'VIDATRES_PXML_BNO','9000','XML',10,'VIDATRES_LSTR_BNO',9000,'LST',20,'seq_puerto_vidatres');

--CruzdelNorte.Bono3. Con Secuencial de Puertos (10 Instancias).
insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,fin_port_ora_conn,fin_reintentos_conn,fin_timeout_conn,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata,fin_secuencia_puertos_api) values (94,'CRUZDELNORTE','CRUZDELNORTE.py','8380',10,'API','dsqm','172.21.3.55','isa_imed','isa_imed',1521,2,5,'CRUZDELNORTE_PXML_BNO','9000','XML',10,'CRUZDELNORTE_LSTR_BNO',9000,'LST',20,'seq_puerto_cruzdelnorte');

--Banmedica.Bono3. Con Secuencial de Puertos (10 Instancias).
insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,fin_port_ora_conn,fin_reintentos_conn,fin_timeout_conn,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata,fin_secuencia_puertos_api) values (99,'BANMEDICA','BANMEDICA.py','8390',10,'API','QSUCU','164.77.11.82','imed','imedqa',1521,2,5,'BANMEDICA_PXML_BNO','9000','XML',10,'BANMEDICA_LSTR_BNO',9000,'LST',20,'seq_puerto_banmedica');
--insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,fin_port_ora_conn,fin_reintentos_conn,fin_timeout_conn,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata,fin_secuencia_puertos_api) values (99,'BANMEDICA','BANMEDICA.py','8390',10,'API','DSUCU','164.77.11.9','imed','imeddesa',1521,2,5,'BANMEDICA_PXML_BNO','9000','XML',10,'BANMEDICA_LSTR_BNO',9000,'LST',20,'seq_puerto_banmedica');

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--MasVida.CuentaMedica
insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata) values  (88,'CME_MASVIDA','API_MASVIDA_CME','8788',2,'API','AGENCIA_PRUEBA','150.10.10.31:1433','CMELEC','IMED01','MASVIDA_PXML_CME','9000','XML',10,'MASVIDA_LSTR_CME',9000,'LST',20);
--insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd) values  (88,'CME_MASVIDA_2','API_MASVIDA_CME_2','8789',2,'API_2','AGENCIA_PRUEBA','150.10.10.31:1433','CMELEC','IMED01');
--insert into parametros_procesos (id_fin,nom_fin,fin_modulo_api,fin_puerto_local_api,fin_hilos_api,fin_prefijo_api,fin_base_datos,fin_ip_conexion_bd,fin_usuario_bd,fin_clave_bd,pxml_modulo,pxml_puerto_bd,pxml_prefijo_log,pxml_timeoutbd,lstr_modulo,lstr_puerto_db,lstr_prefijo_log,lstr_timeout_leedata) values  (88,'MASVIDA_CME','API_MASVIDA_CME','8788',2,'API','ISAPRE','150.10.11.42','CMELEC','IMED01','MASVIDA_PXML_CME','9000','XML',10,'MASVIDA_LSTR_CME',9000,'LST',20);

