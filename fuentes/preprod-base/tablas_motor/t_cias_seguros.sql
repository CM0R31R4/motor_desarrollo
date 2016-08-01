drop table cias_seguros;
create table cias_seguros (
        codigo  integer,
        nombre  varchar,
        nemo    varchar(20), --Max largo del prefijo del motor
        tx      varchar,
        url     varchar,
        funcion_respuesta       varchar,
        funcion_input           varchar,
        mail_cia        varchar default 'jcossio@i-med.cl'
);
create index cias_seguros_01 on cias_seguros(codigo);
create index cias_seguros_02 on cias_seguros(nemo);

/*DROP RULE r_cias_seguros ON cias_seguros;
CREATE RULE r_cias_seguros AS ON INSERT TO cias_seguros
        WHERE NEW.tx in ('Conciliacion','Certificacion')
        DO INSERT INTO cias_seguros VALUES (NEW.codigo, NEW.nombre, NEW.nemo, NEW.tx, NEW.url, NEW.funcion_respuesta, NEW.funcion_input, '')
;*/

INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'Confirmacion', 'http://10.150.73.119/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'ConfirmacionBono3', 'http://10.150.73.119/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'ConfirmacionBonoExt', 'http://10.150.73.119/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'Conciliacion', 'http://10.150.73.119/I-med/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'Anulacion', 'http://10.150.73.119/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'AnulacionBono3', 'http://10.150.73.119/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'AnulacionBonoExt', 'http://10.150.73.119/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('11', 'ServMed CCHC', 'servmed', 'Certificacion', 'http://10.150.73.119/I-med/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

--10.171.127.30:204
-- MetLife
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'Confirmacion', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica', 'jaime.cossio@acepta.com');
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'ConfirmacionBono3', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica', 'jaime.cossio@acepta.com');
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'ConfirmacionBonoExt', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica', 'jaime.cossio@acepta.com');
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'Conciliacion', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert','');
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'Anulacion', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert', 'jaime.cossio@acepta.com');
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'AnulacionBono3', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica_cert', 'jaime.cossio@acepta.com');
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'AnulacionBonoExt', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica_cert', 'jaime.cossio@acepta.com');
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'Certificacion', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert','');

INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'Confirmacion', 'http://146.83.244.27/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'ConfirmacionBono3', 'http://146.83.244.27/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'ConfirmacionBonoExt', 'http://146.83.244.27/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'Conciliacion', 'http://146.83.244.27/I-med/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'Anulacion', 'http://146.83.244.27/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'AnulacionBono3', 'http://146.83.244.27/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'AnulacionBonoExt', 'http://146.83.244.27/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('13', 'BCI', 'bci', 'Certificacion', 'http://146.83.244.27/I-med/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('14', 'Sura(Mpro)', 'ing', 'Conciliacion', 'http://10.90.10.8/capacitacioning/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('14', 'Sura(Mpro)', 'ing', 'ConfirmacionBono3', 'http://10.90.10.8/capacitacioning/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('14', 'Sura(Mpro)', 'ing', 'ConfirmacionBonoExt', 'http://10.90.10.8/capacitacioning/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('14', 'Sura(Mpro)', 'ing', 'Confirmacion', 'http://10.90.10.8/capacitacioning/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('14', 'Sura(Mpro)', 'ing', 'Certificacion', 'http://10.90.10.8/capacitacioning/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('14', 'Sura(Mpro)', 'ing', 'Anulacion', 'http://10.90.10.8/capacitacioning/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('14', 'Sura(Mpro)', 'ing', 'AnulacionBono3', 'http://10.90.10.8/capacitacioning/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('14', 'Sura(Mpro)', 'ing', 'AnulacionBonoExt', 'http://10.90.10.8/capacitacioning/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('15', 'Vida Security(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.33/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('15', 'Vida Security(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('15', 'Vida Security(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('15', 'Vida Security(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('15', 'Vida Security(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.33/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('15', 'Vida Security(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('15', 'Vida Security(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('15', 'Vida Security(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');

INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'Anulacion', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'AnulacionBono3', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'AnulacionBonoExt', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'Confirmacion', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'ConfirmacionBono3', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'ConfirmacionBonoExt', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'Certificacion', 'http://192.10.1.100/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'Conciliacion', 'http://192.10.1.100/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'Conciliacion', 'http://10.10.2.20/Imed/WsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'Confirmacion', 'http://10.10.2.20/Imed/WsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'ConfirmacionBono3', 'http://10.10.2.20/Imed/WsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'ConfirmacionBonoExt', 'http://10.10.2.20/Imed/WsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'Certificacion', 'http://10.10.2.20/Imed/WsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'Anulacion', 'http://10.10.2.20/Imed/WsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'AnulacionBono3', 'http://10.10.2.20/Imed/WsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('17', 'EuroAmerica', 'euroamerica', 'AnulacionBonoExt', 'http://10.10.2.20/Imed/WsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'Conciliacion', 'http://200.75.5.171:8080/ws_segimed/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'Certificacion', 'http://200.75.5.171:8080/ws_segimed/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'Confirmacion', 'http://200.75.5.171:8080/ws_segimed/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'ConfirmacionBono3', 'http://200.75.5.171:8080/ws_segimed/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'ConfirmacionBonoExt', 'http://200.75.5.171:8080/ws_segimed/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'Anulacion', 'http://200.75.5.171:8080/ws_segimed/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'AnulacionBono3', 'http://200.75.5.171:8080/ws_segimed/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'AnulacionBonoExt', 'http://200.75.5.171:8080/ws_segimed/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('19', 'Consorcio(Trassa)', 'consorcio', 'Certificacion', 'http://10.90.10.8/capacitacioncns/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('19', 'Consorcio(Trassa)', 'consorcio', 'Conciliacion', 'http://10.90.10.8/capacitacioncns/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('19', 'Consorcio(Trassa)', 'consorcio', 'Anulacion', 'http://10.90.10.8/capacitacioncns/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('19', 'Consorcio(Trassa)', 'consorcio', 'AnulacionBono3', 'http://10.90.10.8/capacitacioncns/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('19', 'Consorcio(Trassa)', 'consorcio', 'AnulacionBonoExt', 'http://10.90.10.8/capacitacioncns/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('19', 'Consorcio(Trassa)', 'consorcio', 'Confirmacion', 'http://10.90.10.8/capacitacioncns/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('19', 'Consorcio(Trassa)', 'consorcio', 'ConfirmacionBono3', 'http://10.90.10.8/capacitacioncns/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('19', 'Consorcio(Trassa)', 'consorcio', 'ConfirmacionBonoExt', 'http://10.90.10.8/capacitacioncns/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');

INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'Certificacion', 'http://192.10.1.8/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'Conciliacion', 'http://192.10.1.8/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'Anulacion', 'http://192.10.1.8/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'AnulacionBono3', 'http://192.10.1.8/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'AnulacionBonoExt', 'http://192.10.1.8/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'Confirmacion', 'http://192.10.1.8/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'ConfirmacionBono3', 'http://192.10.1.8/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'ConfirmacionBonoExt', 'http://192.10.1.8/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');

INSERT INTO cias_seguros VALUES ('21', 'Consorcio(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.33/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert','');
INSERT INTO cias_seguros VALUES ('21', 'Consorcio(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.33/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert','');
INSERT INTO cias_seguros VALUES ('21', 'Consorcio(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('21', 'Consorcio(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('21', 'Consorcio(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('21', 'Consorcio(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('21', 'Consorcio(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('21', 'Consorcio(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('22', 'CruzdelSur(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('22', 'CruzdelSur(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('22', 'CruzdelSur(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('22', 'CruzdelSur(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.31/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('22', 'CruzdelSur(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.31/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('22', 'CruzdelSur(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.31/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('22', 'CruzdelSur(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.33/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('22', 'CruzdelSur(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.33/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('24', 'CruzdelSur(Faraggi)', 'far2', 'Confirmacion', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('24', 'CruzdelSur(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('24', 'CruzdelSur(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('24', 'CruzdelSur(Faraggi)', 'far2', 'Anulacion', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('24', 'CruzdelSur(Faraggi)', 'far2', 'AnulacionBono3', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('24', 'CruzdelSur(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('24', 'CruzdelSur(Faraggi)', 'far2', 'Conciliacion', 'http://172.28.1.157/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('24', 'CruzdelSur(Faraggi)', 'far2', 'Certificacion', 'http://172.28.1.157/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('25', 'ChiCon(Faraggi)', 'far2', 'Conciliacion', 'http://172.28.1.157/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('25', 'ChiCon(Faraggi)', 'far2', 'Confirmacion', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('25', 'ChiCon(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('25', 'ChiCon(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('25', 'ChiCon(Faraggi)', 'far2', 'Anulacion', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('25', 'ChiCon(Faraggi)', 'far2', 'AnulacionBono3', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('25', 'ChiCon(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('25', 'ChiCon(Faraggi)', 'far2', 'Certificacion', 'http://172.28.1.157/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.33/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.33/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('26', 'Corp Vida(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');

INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'Certificacion', 'http://10.90.10.8/capacitacionbci/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'Conciliacion', 'http://10.90.10.8/capacitacionbci/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'Anulacion', 'http://10.90.10.8/capacitacionbci/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'AnulacionBono3', 'http://10.90.10.8/capacitacionbci/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'AnulacionBonoExt', 'http://10.90.10.8/capacitacionbci/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'Confirmacion', 'http://10.90.10.8/capacitacionbci/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'ConfirmacionBono3', 'http://10.90.10.8/capacitacionbci/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('27', 'BCI(Mpro)', 'mprobci', 'ConfirmacionBonoExt', 'http://10.90.10.8/capacitacionbci/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');

INSERT INTO cias_seguros VALUES ('28', 'Bice Vida', 'bice', 'Confirmacion', 'http://192.168.122.10:7777/IMED-WebServices/WsConfirmacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('28', 'Bice Vida', 'bice', 'ConfirmacionBono3', 'http://192.168.122.10:7777/IMED-WebServices/WsConfirmacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('28', 'Bice Vida', 'bice', 'ConfirmacionBonoExt', 'http://192.168.122.10:7777/IMED-WebServices/WsConfirmacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('28', 'Bice Vida', 'bice', 'Conciliacion', 'http://192.168.122.10:7777/IMED-WebServices/WsConciliacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_cert');
INSERT INTO cias_seguros VALUES ('28', 'Bice Vida', 'bice', 'Certificacion', 'http://192.168.122.10:7777/IMED-WebServices/WsCertificacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_cert');
INSERT INTO cias_seguros VALUES ('28', 'Bice Vida', 'bice', 'Anulacion', 'http://192.168.122.10:7777/IMED-WebServices/WsAnulacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_anulacion');
INSERT INTO cias_seguros VALUES ('28', 'Bice Vida', 'bice', 'AnulacionBono3', 'http://192.168.122.10:7777/IMED-WebServices/WsAnulacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_anulacion');
INSERT INTO cias_seguros VALUES ('28', 'Bice Vida', 'bice', 'AnulacionBonoExt', 'http://192.168.122.10:7777/IMED-WebServices/WsAnulacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_anulacion');

INSERT INTO cias_seguros VALUES ('29', 'BCI(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.33/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('29', 'BCI(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('29', 'BCI(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('29', 'BCI(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('29', 'BCI(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('29', 'BCI(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('29', 'BCI(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('29', 'BCI(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.33/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('30', 'Chicon(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.33/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('30', 'Chicon(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('30', 'Chicon(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('30', 'Chicon(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('30', 'Chicon(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('30', 'Chicon(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('30', 'Chicon(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('30', 'Chicon(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.33/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('31', 'EuroAmerica(Trassa)', 'trasa2', 'Confirmacion', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('31', 'EuroAmerica(Trassa)', 'trasa2', 'ConfirmacionBono3', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('31', 'EuroAmerica(Trassa)', 'trasa2', 'ConfirmacionBonoExt', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('31', 'EuroAmerica(Trassa)', 'trasa2', 'Anulacion', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('31', 'EuroAmerica(Trassa)', 'trasa2', 'AnulacionBono3', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('31', 'EuroAmerica(Trassa)', 'trasa2', 'AnulacionBonoExt', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('31', 'EuroAmerica(Trassa)', 'trasa2', 'Conciliacion', 'http://192.10.1.100/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('31', 'EuroAmerica(Trassa)', 'trasa2', 'Certificacion', 'http://192.10.1.100/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.33/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('32', 'InterAmericana(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.33/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('33', 'CorpVida(Faraggi)', 'far2', 'Confirmacion', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('33', 'CorpVida(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('33', 'CorpVida(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('33', 'CorpVida(Faraggi)', 'far2', 'Certificacion', 'http://172.28.1.157/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('33', 'CorpVida(Faraggi)', 'far2', 'Conciliacion', 'http://172.28.1.157/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('33', 'CorpVida(Faraggi)', 'far2', 'Anulacion', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('33', 'CorpVida(Faraggi)', 'far2', 'AnulacionBono3', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('33', 'CorpVida(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('34', 'BCI(Faraggi)', 'far2', 'Confirmacion', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('34', 'BCI(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('34', 'BCI(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('34', 'BCI(Faraggi)', 'far2', 'Conciliacion', 'http://172.28.1.157/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('34', 'BCI(Faraggi)', 'far2', 'Certificacion', 'http://172.28.1.157/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('34', 'BCI(Faraggi)', 'far2', 'Anulacion', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('34', 'BCI(Faraggi)', 'far2', 'AnulacionBono3', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('34', 'BCI(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('35', 'InterAmericana(Mpro)', 'inter', 'Confirmacion', 'http://10.90.10.8/capacitacionInter/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('35', 'InterAmericana(Mpro)', 'inter', 'ConfirmacionBono3', 'http://10.90.10.8/capacitacionInter/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('35', 'InterAmericana(Mpro)', 'inter', 'ConfirmacionBonoExt', 'http://10.90.10.8/capacitacionInter/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('35', 'InterAmericana(Mpro)', 'inter', 'Conciliacion', 'http://10.90.10.8/capacitacionInter/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('35', 'InterAmericana(Mpro)', 'inter', 'Anulacion', 'http://10.90.10.8/capacitacionInter/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('35', 'InterAmericana(Mpro)', 'inter', 'AnulacionBono3', 'http://10.90.10.8/capacitacionInter/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('35', 'InterAmericana(Mpro)', 'inter', 'AnulacionBonoExt', 'http://10.90.10.8/capacitacionInter/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('35', 'InterAmericana(Mpro)', 'inter', 'Certificacion', 'http://10.90.10.8/capacitacionInter/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

--10.171.127.30:204
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'Certificacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'ConfirmacionBono3', 'http://10.171.127.30:204/IFWIMEDws/WS/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert', 'jcossio@i-med.cl');
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'ConfirmacionBonoExt', 'http://10.171.127.30:204/IFWIMEDws/WS/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert', 'jcossio@i-med.cl');
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'Confirmacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica', 'jcossio@i-med.cl');
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'Anulacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert', 'jcossio@i-med.cl');
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'AnulacionBono3', 'http://10.171.127.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert', 'jcossio@i-med.cl');
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'AnulacionBonoExt', 'http://10.171.127.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert', 'jcossio@i-med.cl');
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'Conciliacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'Confirmacion', 'http://10.90.10.8/ws_met_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'ConfirmacionBono3', 'http://10.90.10.8/ws_met_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'ConfirmacionBonoExt', 'http://10.90.10.8/ws_met_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'Anulacion', 'http://10.90.10.8/ws_met_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'AnulacionBono3', 'http://10.90.10.8/ws_met_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'AnulacionBonoExt', 'http://10.90.10.8/ws_met_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'Conciliacion', 'http://10.90.10.8/ws_met_prod/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('37', 'MetLife(Mpro)', 'metlife_mpro', 'Certificacion', 'http://10.90.10.8/ws_met_prod/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');

INSERT INTO cias_seguros VALUES ('38', 'Chilena Consolidada', 'chicon', 'Confirmacion', 'http://192.168.140.92/VIDA/WebService/Colectivos/wmImed_SrvConfirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_conf');
INSERT INTO cias_seguros VALUES ('38', 'Chilena Consolidada', 'chicon', 'ConfirmacionBono3', 'http://192.168.140.92/VIDA/WebService/Colectivos/wmImed_SrvConfirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_conf');
INSERT INTO cias_seguros VALUES ('38', 'Chilena Consolidada', 'chicon', 'ConfirmacionBonoExt', 'http://192.168.140.92/VIDA/WebService/Colectivos/wmImed_SrvConfirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_conf');
INSERT INTO cias_seguros VALUES ('38', 'Chilena Consolidada', 'chicon', 'Certificacion', 'http://192.168.140.92/VIDA/WebService/Colectivos/wmImed_SrvCertificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_cert');
INSERT INTO cias_seguros VALUES ('38', 'Chilena Consolidada', 'chicon', 'Anulacion', 'http://192.168.140.92/VIDA/WebService/Colectivos/wmImed_SrvAnulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_anulacion');
INSERT INTO cias_seguros VALUES ('38', 'Chilena Consolidada', 'chicon', 'AnulacionBono3', 'http://192.168.140.92/VIDA/WebService/Colectivos/wmImed_SrvAnulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_anulacion');
INSERT INTO cias_seguros VALUES ('38', 'Chilena Consolidada', 'chicon', 'AnulacionBonoExt', 'http://192.168.140.92/VIDA/WebService/Colectivos/wmImed_SrvAnulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_anulacion');
INSERT INTO cias_seguros VALUES ('38', 'Chilena Consolidada', 'chicon', 'Conciliacion', 'http://192.168.140.92/VIDA/WebService/Colectivos/wmImed_SrvConciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_cert');

INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'Conciliacion', 'http://10.0.0.114/~imed/nusoap/Imed/wsConciliacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'Certificacion', 'http://10.0.0.114/~imed/nusoap/Imed/wsCertificacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'Confirmacion', 'http://10.0.0.114/~imed/nusoap/Imed/wsConfirmacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'ConfirmacionBono3', 'http://10.0.0.114/~imed/nusoap/Imed/wsConfirmacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'ConfirmacionBonoExt', 'http://10.0.0.114/~imed/nusoap/Imed/wsConfirmacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'Anulacion', 'http://10.0.0.114/~imed/nusoap/Imed/wsAnulacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'AnulacionBono3', 'http://10.0.0.114/~imed/nusoap/Imed/wsAnulacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('39', 'Sermecoop', 'sermecoop', 'AnulacionBonoExt', 'http://10.0.0.114/~imed/nusoap/Imed/wsAnulacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('40', 'Chubb(Trassa)', 'trasa2', 'Anulacion', 'http://192.10.1.8/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('40', 'Chubb(Trassa)', 'trasa2', 'AnulacionBono3', 'http://192.10.1.8/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('40', 'Chubb(Trassa)', 'trasa2', 'AnulacionBonoExt', 'http://192.10.1.8/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('40', 'Chubb(Trassa)', 'trasa2', 'Certificacion', 'http://192.10.1.8/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('40', 'Chubb(Trassa)', 'trasa2', 'Confirmacion', 'http://192.10.1.8/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('40', 'Chubb(Trassa)', 'trasa2', 'ConfirmacionBono3', 'http://192.10.1.8/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('40', 'Chubb(Trassa)', 'trasa2', 'ConfirmacionBonoExt', 'http://192.10.1.8/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('40', 'Chubb(Trassa)', 'trasa2', 'Conciliacion', 'http://192.10.1.8/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('41', 'CCAF(Mpro)', 'mpro2', 'Anulacion', 'http://10.90.10.8/capacitacionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('41', 'CCAF(Mpro)', 'mpro2', 'AnulacionBono3', 'http://10.90.10.8/capacitacionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('41', 'CCAF(Mpro)', 'mpro2', 'AnulacionBonoExt', 'http://10.90.10.8/capacitacionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('41', 'CCAF(Mpro)', 'mpro2', 'Certificacion', 'http://10.90.10.8/capacitacionmpro/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('41', 'CCAF(Mpro)', 'mpro2', 'Conciliacion', 'http://10.90.10.8/capacitacionmpro/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('41', 'CCAF(Mpro)', 'mpro2', 'Confirmacion', 'http://10.90.10.8/capacitacionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('41', 'CCAF(Mpro)', 'mpro2', 'ConfirmacionBono3', 'http://10.90.10.8/capacitacionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('41', 'CCAF(Mpro)', 'mpro2', 'ConfirmacionBonoExt', 'http://10.90.10.8/capacitacionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');

INSERT INTO cias_seguros VALUES ('42', 'Sura(Faraggi)', 'far2', 'Anulacion', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('42', 'Sura(Faraggi)', 'far2', 'AnulacionBono3', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('42', 'Sura(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://172.28.1.157/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('42', 'Sura(Faraggi)', 'far2', 'Certificacion', 'http://172.28.1.157/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('42', 'Sura(Faraggi)', 'far2', 'Confirmacion', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('42', 'Sura(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('42', 'Sura(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://172.28.1.157/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('42', 'Sura(Faraggi)', 'far2', 'Conciliacion', 'http://172.28.1.157/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('43', 'ChiCon(Mpro)', 'mpro2', 'Certificacion', 'http://10.90.10.8/capacitacionmpro/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('43', 'ChiCon(Mpro)', 'mpro2', 'Confirmacion', 'http://10.90.10.8/capacitacionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('43', 'ChiCon(Mpro)', 'mpro2', 'ConfirmacionBono3', 'http://10.90.10.8/capacitacionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('43', 'ChiCon(Mpro)', 'mpro2', 'ConfirmacionBonoExt', 'http://10.90.10.8/capacitacionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('43', 'ChiCon(Mpro)', 'mpro2', 'Conciliacion', 'http://10.90.10.8/capacitacionmpro/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('43', 'ChiCon(Mpro)', 'mpro2', 'Anulacion', 'http://10.90.10.8/capacitacionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('43', 'ChiCon(Mpro)', 'mpro2', 'AnulacionBono3', 'http://10.90.10.8/capacitacionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('43', 'ChiCon(Mpro)', 'mpro2', 'AnulacionBonoExt', 'http://10.90.10.8/capacitacionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');

INSERT INTO cias_seguros VALUES ('44', 'Vida Camara', 'camara', 'Confirmacion', 'http://10.150.73.119/i-med/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('44', 'Vida Camara', 'camara', 'ConfirmacionBono3', 'http://10.150.73.119/i-med/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('44', 'Vida Camara', 'camara', 'ConfirmacionBonoExt', 'http://10.150.73.119/i-med/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('44', 'Vida Camara', 'camara', 'Conciliacion', 'http://10.150.73.119/i-med/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('44', 'Vida Camara', 'camara', 'Anulacion', 'http://10.150.73.119/i-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('44', 'Vida Camara', 'camara', 'AnulacionBono3', 'http://10.150.73.119/i-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('44', 'Vida Camara', 'camara', 'AnulacionBonoExt', 'http://10.150.73.119/i-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('44', 'Vida Camara', 'camara', 'Certificacion', 'http://10.150.73.119/i-med/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');

INSERT INTO cias_seguros VALUES ('45', 'Integramedica(Faraggi)', 'integrafar', 'Anulacion', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('45', 'Integramedica(Faraggi)', 'integrafar', 'AnulacionBono3', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('45', 'Integramedica(Faraggi)', 'integrafar', 'AnulacionBonoExt', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('45', 'Integramedica(Faraggi)', 'integrafar', 'Confirmacion', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('45', 'Integramedica(Faraggi)', 'integrafar', 'ConfirmacionBono3', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('45', 'Integramedica(Faraggi)', 'integrafar', 'ConfirmacionBonoExt', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('45', 'Integramedica(Faraggi)', 'integrafar', 'Certificacion', 'http://10.27.11.6/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('45', 'Integramedica(Faraggi)', 'integrafar', 'Conciliacion', 'http://10.27.11.6/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('46', 'MOK Assist(Mpro)', 'mpro2', 'Certificacion', 'http://10.90.10.8/capacitacionmpro/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('46', 'MOK Assist(Mpro)', 'mpro2', 'Anulacion', 'http://10.90.10.8/capacitacionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('46', 'MOK Assist(Mpro)', 'mpro2', 'AnulacionBono3', 'http://10.90.10.8/capacitacionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('46', 'MOK Assist(Mpro)', 'mpro2', 'AnulacionBonoExt', 'http://10.90.10.8/capacitacionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('46', 'MOK Assist(Mpro)', 'mpro2', 'Confirmacion', 'http://10.90.10.8/capacitacionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('46', 'MOK Assist(Mpro)', 'mpro2', 'ConfirmacionBono3', 'http://10.90.10.8/capacitacionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('46', 'MOK Assist(Mpro)', 'mpro2', 'ConfirmacionBonoExt', 'http://10.90.10.8/capacitacionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('46', 'MOK Assist(Mpro)', 'mpro2', 'Conciliacion', 'http://10.90.10.8/capacitacionmpro/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');

INSERT INTO cias_seguros VALUES ('47', 'Vida Camara(Mpro)', 'mpro2', 'Conciliacion', 'http://10.90.10.8/capacitacionmpro/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('47', 'Vida Camara(Mpro)', 'mpro2', 'Certificacion', 'http://10.90.10.8/capacitacionmpro/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('47', 'Vida Camara(Mpro)', 'mpro2', 'Confirmacion', 'http://10.90.10.8/capacitacionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('47', 'Vida Camara(Mpro)', 'mpro2', 'ConfirmacionBono3', 'http://10.90.10.8/capacitacionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('47', 'Vida Camara(Mpro)', 'mpro2', 'ConfirmacionBonoExt', 'http://10.90.10.8/capacitacionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES ('47', 'Vida Camara(Mpro)', 'mpro2', 'Anulacion', 'http://10.90.10.8/capacitacionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('47', 'Vida Camara(Mpro)', 'mpro2', 'AnulacionBono3', 'http://10.90.10.8/capacitacionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES ('47', 'Vida Camara(Mpro)', 'mpro2', 'AnulacionBonoExt', 'http://10.90.10.8/capacitacionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');

INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.22/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.22/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.22/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.22/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.22/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.22/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.22/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('48', 'Magallanes(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.22/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('49', 'BBVA(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.33/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('49', 'BBVA(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.33/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('49', 'BBVA(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('49', 'BBVA(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('49', 'BBVA(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.33/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('49', 'BBVA(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('49', 'BBVA(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('49', 'BBVA(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.33/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('51', 'BBVA(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('51', 'BBVA(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('51', 'BBVA(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('51', 'BBVA(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.6/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('51', 'BBVA(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.6/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('51', 'BBVA(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('51', 'BBVA(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('51', 'BBVA(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('52', 'Vida Security(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.6/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('52', 'Vida Security(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.6/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('52', 'Vida Security(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('52', 'Vida Security(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('52', 'Vida Security(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('52', 'Vida Security(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('52', 'Vida Security(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('52', 'Vida Security(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('53', 'Vida Camara(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('53', 'Vida Camara(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('53', 'Vida Camara(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('53', 'Vida Camara(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('53', 'Vida Camara(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('53', 'Vida Camara(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('53', 'Vida Camara(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.6/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('53', 'Vida Camara(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.6/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('56', 'Magallanes(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('56', 'Magallanes(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('56', 'Magallanes(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('56', 'Magallanes(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('56', 'Magallanes(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('56', 'Magallanes(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('56', 'Magallanes(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.6/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('56', 'Magallanes(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.6/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('57', 'Colmena(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('57', 'Colmena(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('57', 'Colmena(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.6/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('57', 'Colmena(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('57', 'Colmena(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('57', 'Colmena(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.6/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('57', 'Colmena(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.6/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('57', 'Colmena(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.6/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES ('58', 'CruzBlanca', 'cbvida', 'Confirmacion', 'http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_conf');
INSERT INTO cias_seguros VALUES ('58', 'CruzBlanca', 'cbvida', 'ConfirmacionBono3','http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_conf');
INSERT INTO cias_seguros VALUES ('58', 'CruzBlanca', 'cbvida', 'ConfirmacionBonoExt','http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_conf');
INSERT INTO cias_seguros VALUES ('58', 'CruzBlanca', 'cbvida', 'Conciliacion', 'http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_concilia');
INSERT INTO cias_seguros VALUES ('58', 'CruzBlanca', 'cbvida', 'Anulacion', 'http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_anula');
INSERT INTO cias_seguros VALUES ('58', 'CruzBlanca', 'cbvida', 'AnulacionBono3', 'http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_anula');
INSERT INTO cias_seguros VALUES ('58', 'CruzBlanca', 'cbvida', 'AnulacionBonoExt', 'http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_anula');
INSERT INTO cias_seguros VALUES ('58', 'CruzBlanca', 'cbvida', 'Certificacion', 'http://ws-seguros.cruzblanca.qa/WSIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_cert');

INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'Conciliacion', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'Certificacion', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'Confirmacion', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'Anulacion', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'AnulacionBono3', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

--MTG Apuntando a Liquidador QA
/*INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/liquidador/qa/WsConciliacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/liquidador/qa/WsCertificacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');*/

INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('91', 'Consorcio(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


INSERT INTO cias_seguros VALUES ('92', 'Sermecoop(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('92', 'Sermecoop(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('92', 'Sermecoop(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('92', 'Sermecoop(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('92', 'Sermecoop(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('92', 'Sermecoop(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('92', 'Sermecoop(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('92', 'Sermecoop(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


--MTG Apuntando a Liquidador QA
/*INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/liquidador/qa/WsCertificacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/liquidador/qa/WsConciliacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');*/

-- MTG Apuntando a Liquidador Pruebas
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('93', 'SurAsistencia(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


-- MTG Apuntando a Liquidador QA
/*INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'Conciliacion', 'http://10.100.32.153/liquidador/qa/WsConciliacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'Anulacion', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_gen
erica_cert');
INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'AnulacionBono3', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_ci
INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_ci
a_generica_cert');
INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'Confirmacion', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_inpu
t_cia_generica');
INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp
INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp
_input_cia_generica');
INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'Certificacion', 'http://10.100.32.153/liquidador/qa/WsCertificacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
*/

-- MTG Apuntando a Liquidador Pruebas
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

-- MTG Apuntando a Liquidador QA
/*INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/liquidador/qa/WsConciliacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/liquidador/qa/WsCertificacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
*/
-- MTG Apuntando a Liquidador Pruebas
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('101', 'CCAF(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

-- MTG Apuntando a Liquidador QA
/*INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/liquidador/qa/WsConciliacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/liquidador/qa/WsCertificacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
*/

-- MTG Apuntando a Liquidador Pruebas
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('102', 'Ben Salud(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


-- MTG Apuntando a Liquidador QA
/*INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/liquidador/qa/WsConciliacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/liquidador/qa/WsCertificacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
*/

-- MTG Apuntando a Liquidador Pruebas
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('103', 'Gea Chile(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

-- MTG Apuntando a Liquidador QA
/*INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'Confirmacion', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'Conciliacion', 'http://10.100.32.153/liquidador/qa/WsConciliacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'Anulacion', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'AnulacionBono3', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'Certificacion', 'http://10.100.32.153/liquidador/qa/WsCertificacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
*/

INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'Confirmacion', 'http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_conf');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'ConfirmacionBono3','http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_conf');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'ConfirmacionBonoExt','http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_conf');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'Conciliacion', 'http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_concilia');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'Anulacion', 'http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_anula');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'AnulacionBono3', 'http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_anula');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'AnulacionBonoExt', 'http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_anula');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'Certificacion', 'http://seguros.cruzblanca.qa/wsIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_cert');


-- MTG Apuntando a Liquidador Pruebas
/*INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');*/


-- MTG Apuntando a Liquidador QA
/*INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'Anulacion', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'AnulacionBono3', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'Confirmacion', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'Certificacion', 'http://10.100.32.153/liquidador/qa/WsCertificacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'Conciliacion', 'http://10.100.32.153/liquidador/qa/WsConciliacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
*/

-- MTG Apuntando a Liquidador Pruebas
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('105', 'Caja Andes', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

-- Liquidador 106 - Sur Asistencia-Enfermedad(Imed)
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


-- Liquidador 107 - Entel SA(Imed)
INSERT INTO cias_seguros VALUES ('107', 'Entel SA(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('107', 'Entel SA(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('107', 'Entel SA(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('107', 'Entel SA(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('107', 'Entel SA(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('107', 'Entel SA(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('107', 'Entel SA(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('107', 'Entel SA(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


-- Liquidador 108 - Caja 18(Imed)
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


--INSERT INTO cias_seguros VALUES ('122', 'Metlife', 'metlife_cert', 'Conciliacion', 'http://172.22.1.32:104/IFWIMEDws/WS/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('122', 'Metlife', 'metlife_cert', 'Confirmacion', 'http://172.22.1.32:104/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
--INSERT INTO cias_seguros VALUES ('122', 'Metlife', 'metlife_cert', 'Anulacion', 'http://172.22.1.32:104/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('122', 'Metlife', 'metlife_cert', 'Certificacion', 'http://172.22.1.32:104/IFWIMEDws/WS/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
