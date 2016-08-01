DROP TABLE cias_seguros cascade;
CREATE TABLE cias_seguros (
    codigo 	integer,
    nombre	character varying,
    nemo 	character varying(20),
    tx 		character varying,
    url 	character varying,
    funcion_respuesta 	character varying,
    funcion_input 	character varying,
    mail_cia	character varying default 'operaciones@acepta.com'
);

CREATE INDEX cias_seguros_01 ON cias_seguros USING btree (codigo);
CREATE INDEX cias_seguros_02 ON cias_seguros USING btree (nemo);


INSERT INTO cias_seguros VALUES (11, 'ServMed CCHC', 'servmed', 'ConfirmacionBono3', 'http://10.150.73.12/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (11, 'ServMed CCHC', 'servmed', 'ConfirmacionBonoExt', 'http://10.150.73.12/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (11, 'ServMed CCHC', 'servmed', 'AnulacionBono3', 'http://10.150.73.12/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (11, 'ServMed CCHC', 'servmed', 'AnulacionBonoExt', 'http://10.150.73.12/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (11, 'ServMed CCHC', 'servmed', 'Certificacion', 'http://10.150.73.12/I-med/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (11, 'ServMed CCHC', 'servmed', 'Anulacion', 'http://10.150.73.12/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (11, 'ServMed CCHC', 'servmed', 'Conciliacion', 'http://10.150.73.12/I-med/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (11, 'ServMed CCHC', 'servmed', 'Confirmacion', 'http://10.150.73.12/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (12, 'Metlife', 'metlife', 'ConfirmacionBonoExt', 'http://10.171.127.30:204/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (12, 'Metlife', 'metlife', 'ConfirmacionBono3', 'http://10.171.127.30:204/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (12, 'Metlife', 'metlife', 'Confirmacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (12, 'Metlife', 'metlife', 'AnulacionBonoExt', 'http://10.171.127.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (12, 'Metlife', 'metlife', 'AnulacionBono3', 'http://10.171.127.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (12, 'Metlife', 'metlife', 'Certificacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (12, 'Metlife', 'metlife', 'Anulacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (12, 'Metlife', 'metlife', 'Conciliacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (13, 'BCI', 'bci', 'Confirmacion', 'http://146.83.244.27/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (13, 'BCI', 'bci', 'ConfirmacionBonoExt', 'http://146.83.244.27/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (13, 'BCI', 'bci', 'ConfirmacionBono3', 'http://146.83.244.27/I-med/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (13, 'BCI', 'bci', 'AnulacionBonoExt', 'http://146.83.244.27/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (13, 'BCI', 'bci', 'AnulacionBono3', 'http://146.83.244.27/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (13, 'BCI', 'bci', 'Certificacion', 'http://146.83.244.27/I-med/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (13, 'BCI', 'bci', 'Anulacion', 'http://146.83.244.27/I-med/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (13, 'BCI', 'bci', 'Conciliacion', 'http://146.83.244.27/I-med/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (14, 'Sura(Mpro)', 'ing', 'Confirmacion', 'http://10.90.10.8/ws_ing_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (14, 'Sura(Mpro)', 'ing', 'ConfirmacionBonoExt', 'http://10.90.10.8/ws_ing_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (14, 'Sura(Mpro)', 'ing', 'ConfirmacionBono3', 'http://10.90.10.8/ws_ing_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (14, 'Sura(Mpro)', 'ing', 'Certificacion', 'http://10.90.10.8/ws_ing_prod/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (14, 'Sura(Mpro)', 'ing', 'AnulacionBonoExt', 'http://10.90.10.8/ws_ing_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (14, 'Sura(Mpro)', 'ing', 'AnulacionBono3', 'http://10.90.10.8/ws_ing_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (14, 'Sura(Mpro)', 'ing', 'Anulacion', 'http://10.90.10.8/ws_ing_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (14, 'Sura(Mpro)', 'ing', 'Conciliacion', 'http://10.90.10.8/ws_ing_prod/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (15, 'Vida Security(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.66/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (15, 'Vida Security(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.66/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (15, 'Vida Security(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.66/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (15, 'Vida Security(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.66/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (15, 'Vida Security(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.66/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (15, 'Vida Security(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.66/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (15, 'Vida Security(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.66/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (15, 'Vida Security(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.66/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (16, 'MetLife(Trassa)', 'trasa2', 'Confirmacion', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (16, 'MetLife(Trassa)', 'trasa2', 'ConfirmacionBonoExt', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (16, 'MetLife(Trassa)', 'trasa2', 'ConfirmacionBono3', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (16, 'MetLife(Trassa)', 'trasa2', 'Certificacion', 'http://192.10.1.100/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (16, 'MetLife(Trassa)', 'trasa2', 'AnulacionBonoExt', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (16, 'MetLife(Trassa)', 'trasa2', 'AnulacionBono3', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (16, 'MetLife(Trassa)', 'trasa2', 'Anulacion', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (16, 'MetLife(Trassa)', 'trasa2', 'Conciliacion', 'http://192.10.1.100/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (17, 'EuroAmerica', 'euroamerica', 'Confirmacion', 'http://10.10.4.10/Imed/WsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (17, 'EuroAmerica', 'euroamerica', 'ConfirmacionBonoExt', 'http://10.10.4.10/Imed/WsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (17, 'EuroAmerica', 'euroamerica', 'ConfirmacionBono3', 'http://10.10.4.10/Imed/WsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (17, 'EuroAmerica', 'euroamerica', 'Certificacion', 'http://10.10.4.10/Imed/WsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (17, 'EuroAmerica', 'euroamerica', 'AnulacionBonoExt', 'http://10.10.4.10/Imed/WsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (17, 'EuroAmerica', 'euroamerica', 'AnulacionBono3', 'http://10.10.4.10/Imed/WsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (17, 'EuroAmerica', 'euroamerica', 'Anulacion', 'http://10.10.4.10/Imed/WsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (17, 'EuroAmerica', 'euroamerica', 'Conciliacion', 'http://10.10.4.10/Imed/WsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (18, 'Vida Security', 'security', 'Confirmacion', 'http://200.75.5.171:8080/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (18, 'Vida Security', 'security', 'ConfirmacionBonoExt', 'http://200.75.5.171:8080/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (18, 'Vida Security', 'security', 'ConfirmacionBono3', 'http://200.75.5.171:8080/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (18, 'Vida Security', 'security', 'Certificacion', 'http://200.75.5.171:8080/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (18, 'Vida Security', 'security', 'AnulacionBonoExt', 'http://200.75.5.171:8080/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (18, 'Vida Security', 'security', 'AnulacionBono3', 'http://200.75.5.171:8080/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (18, 'Vida Security', 'security', 'Conciliacion', 'http://200.75.5.171:8080/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (18, 'Vida Security', 'security', 'Anulacion', 'http://200.75.5.171:8080/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (19, 'Consorcio(Mpro)', 'consorcio', 'Confirmacion', 'http://10.90.10.8/ws_cns_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (19, 'Consorcio(Mpro)', 'consorcio', 'ConfirmacionBonoExt', 'http://10.90.10.8/ws_cns_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (19, 'Consorcio(Mpro)', 'consorcio', 'ConfirmacionBono3', 'http://10.90.10.8/ws_cns_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (19, 'Consorcio(Mpro)', 'consorcio', 'Certificacion', 'http://10.90.10.8/ws_cns_prod/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (19, 'Consorcio(Mpro)', 'consorcio', 'AnulacionBonoExt', 'http://10.90.10.8/ws_cns_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (19, 'Consorcio(Mpro)', 'consorcio', 'AnulacionBono3', 'http://10.90.10.8/ws_cns_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (19, 'Consorcio(Mpro)', 'consorcio', 'Anulacion', 'http://10.90.10.8/ws_cns_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (19, 'Consorcio(Mpro)', 'consorcio', 'Conciliacion', 'http://10.90.10.8/ws_cns_prod/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (20, 'ING(Trassa)', 'trasa2', 'Confirmacion', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (20, 'ING(Trassa)', 'trasa2', 'ConfirmacionBonoExt', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (20, 'ING(Trassa)', 'trasa2', 'ConfirmacionBono3', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (20, 'ING(Trassa)', 'trasa2', 'Certificacion', 'http://192.10.1.100/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (20, 'ING(Trassa)', 'trasa2', 'AnulacionBonoExt', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (20, 'ING(Trassa)', 'trasa2', 'AnulacionBono3', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (20, 'ING(Trassa)', 'trasa2', 'Anulacion', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (20, 'ING(Trassa)', 'trasa2', 'Conciliacion', 'http://192.10.1.100/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (21, 'Consorcio(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (21, 'Consorcio(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (21, 'Consorcio(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (21, 'Consorcio(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.11/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (21, 'Consorcio(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (21, 'Consorcio(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (21, 'Consorcio(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (21, 'Consorcio(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.11/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (22, 'CruzdelSur(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (22, 'CruzdelSur(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (22, 'CruzdelSur(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (22, 'CruzdelSur(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.11/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (22, 'CruzdelSur(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (22, 'CruzdelSur(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (22, 'CruzdelSur(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (22, 'CruzdelSur(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.11/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (24, 'CruzdelSur(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (24, 'CruzdelSur(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (24, 'CruzdelSur(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (24, 'CruzdelSur(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.60/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (24, 'CruzdelSur(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (24, 'CruzdelSur(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (24, 'CruzdelSur(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (24, 'CruzdelSur(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.60/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (25, 'ChiCon(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (25, 'ChiCon(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (25, 'ChiCon(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (25, 'ChiCon(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.60/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (25, 'ChiCon(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (25, 'ChiCon(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (25, 'ChiCon(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (25, 'ChiCon(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.60/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (26, 'Corp Vida(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (26, 'Corp Vida(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (26, 'Corp Vida(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (26, 'Corp Vida(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.11/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (26, 'Corp Vida(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (26, 'Corp Vida(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (26, 'Corp Vida(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (26, 'Corp Vida(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.11/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (27, 'BCI(Mpro)', 'mprobci', 'Confirmacion', 'http://10.90.10.8/ws_bci_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (27, 'BCI(Mpro)', 'mprobci', 'ConfirmacionBonoExt', 'http://10.90.10.8/ws_bci_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (27, 'BCI(Mpro)', 'mprobci', 'ConfirmacionBono3', 'http://10.90.10.8/ws_bci_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (27, 'BCI(Mpro)', 'mprobci', 'AnulacionBonoExt', 'http://10.90.10.8/ws_bci_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (27, 'BCI(Mpro)', 'mprobci', 'AnulacionBono3', 'http://10.90.10.8/ws_bci_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (27, 'BCI(Mpro)', 'mprobci', 'Certificacion', 'http://10.90.10.8/ws_bci_prod/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (27, 'BCI(Mpro)', 'mprobci', 'Anulacion', 'http://10.90.10.8/ws_bci_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (27, 'BCI(Mpro)', 'mprobci', 'Conciliacion', 'http://10.90.10.8/ws_bci_prod/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');

INSERT INTO cias_seguros VALUES (28, 'Bice Vida', 'bice', 'Confirmacion', 'http://192.168.122.11:7777/IMED-WebServices/WsConfirmacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (28, 'Bice Vida', 'bice', 'ConfirmacionBonoExt', 'http://192.168.122.11:7777/IMED-WebServices/WsConfirmacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (28, 'Bice Vida', 'bice', 'ConfirmacionBono3', 'http://192.168.122.11:7777/IMED-WebServices/WsConfirmacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (28, 'Bice Vida', 'bice', 'Certificacion', 'http://192.168.122.11:7777/IMED-WebServices/WsCertificacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_cert');
INSERT INTO cias_seguros VALUES (28, 'Bice Vida', 'bice', 'AnulacionBonoExt', 'http://192.168.122.11:7777/IMED-WebServices/WsAnulacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_anulacion');
INSERT INTO cias_seguros VALUES (28, 'Bice Vida', 'bice', 'AnulacionBono3', 'http://192.168.122.11:7777/IMED-WebServices/WsAnulacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_anulacion');
INSERT INTO cias_seguros VALUES (28, 'Bice Vida', 'bice', 'Anulacion', 'http://192.168.122.11:7777/IMED-WebServices/WsAnulacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_anulacion');
INSERT INTO cias_seguros VALUES (28, 'Bice Vida', 'bice', 'Conciliacion', 'http://192.168.122.11:7777/IMED-WebServices/WsConciliacionSoap', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_cert');

INSERT INTO cias_seguros VALUES (29, 'BCI(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (29, 'BCI(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (29, 'BCI(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (29, 'BCI(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.11/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (29, 'BCI(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (29, 'BCI(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (29, 'BCI(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (29, 'BCI(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.11/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (30, 'Chicon(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (30, 'Chicon(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (30, 'Chicon(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (30, 'Chicon(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.11/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (30, 'Chicon(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (30, 'Chicon(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (30, 'Chicon(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (30, 'Chicon(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.11/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (31, 'EuroAmerica(Trassa)', 'trasa2', 'Confirmacion', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (31, 'EuroAmerica(Trassa)', 'trasa2', 'ConfirmacionBonoExt', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (31, 'EuroAmerica(Trassa)', 'trasa2', 'ConfirmacionBono3', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (31, 'EuroAmerica(Trassa)', 'trasa2', 'Certificacion', 'http://192.10.1.100/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (31, 'EuroAmerica(Trassa)', 'trasa2', 'AnulacionBonoExt', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (31, 'EuroAmerica(Trassa)', 'trasa2', 'AnulacionBono3', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (31, 'EuroAmerica(Trassa)', 'trasa2', 'Anulacion', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (31, 'EuroAmerica(Trassa)', 'trasa2', 'Conciliacion', 'http://192.10.1.100/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (32, 'InterAmericana(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (32, 'InterAmericana(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (32, 'InterAmericana(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (32, 'InterAmericana(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.11/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (32, 'InterAmericana(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (32, 'InterAmericana(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (32, 'InterAmericana(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (32, 'InterAmericana(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.11/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (33, 'CorpVida(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (33, 'CorpVida(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (33, 'CorpVida(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (33, 'CorpVida(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.60/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (33, 'CorpVida(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (33, 'CorpVida(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (33, 'CorpVida(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (33, 'CorpVida(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.60/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (34, 'BCI(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (34, 'BCI(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (34, 'BCI(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (34, 'BCI(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.60/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (34, 'BCI(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (34, 'BCI(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (34, 'BCI(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (34, 'BCI(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.60/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (35, 'InterAmericana(Mpro)', 'inter', 'Confirmacion', 'http://10.90.10.8/ws_int_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (35, 'InterAmericana(Mpro)', 'inter', 'ConfirmacionBonoExt', 'http://10.90.10.8/ws_int_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (35, 'InterAmericana(Mpro)', 'inter', 'ConfirmacionBono3', 'http://10.90.10.8/ws_int_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (35, 'InterAmericana(Mpro)', 'inter', 'Certificacion', 'http://10.90.10.8/ws_int_prod/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (35, 'InterAmericana(Mpro)', 'inter', 'AnulacionBonoExt', 'http://10.90.10.8/ws_int_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (35, 'InterAmericana(Mpro)', 'inter', 'AnulacionBono3', 'http://10.90.10.8/ws_int_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (35, 'InterAmericana(Mpro)', 'inter', 'Anulacion', 'http://10.90.10.8/ws_int_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (35, 'InterAmericana(Mpro)', 'inter', 'Conciliacion', 'http://10.90.10.8/ws_int_prod/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

/*INSERT INTO cias_seguros VALUES (36, 'CCAF', 'metlife', 'Confirmacion', 'http://172.22.1.30:204/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (36, 'CCAF', 'metlife', 'ConfirmacionBonoExt', 'http://172.22.1.30:204/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (36, 'CCAF', 'metlife', 'ConfirmacionBono3', 'http://172.22.1.30:204/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (36, 'CCAF', 'metlife', 'Certificacion', 'http://172.22.1.30:204/IFWIMEDws/WS/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (36, 'CCAF', 'metlife', 'AnulacionBonoExt', 'http://172.22.1.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (36, 'CCAF', 'metlife', 'AnulacionBono3', 'http://172.22.1.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (36, 'CCAF', 'metlife', 'Anulacion', 'http://172.22.1.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (36, 'CCAF', 'metlife', 'Conciliacion', 'http://172.22.1.30:204/IFWIMEDws/WS/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');*/

INSERT INTO cias_seguros VALUES (36, 'CCAF(Metlife)', 'metlife', 'Confirmacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (36, 'CCAF(Metlife)', 'metlife', 'ConfirmacionBonoExt', 'http://10.171.127.30:204/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (36, 'CCAF(Metlife)', 'metlife', 'ConfirmacionBono3', 'http://10.171.127.30:204/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (36, 'CCAF(Metlife)', 'metlife', 'Certificacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (36, 'CCAF(Metlife)', 'metlife', 'AnulacionBonoExt', 'http://10.171.127.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (36, 'CCAF(Metlife)', 'metlife', 'AnulacionBono3', 'http://10.171.127.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (36, 'CCAF(Metlife)', 'metlife', 'Anulacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (36, 'CCAF(Metlife)', 'metlife', 'Conciliacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (37, 'MetLife(Mpro)', 'metlife_mpro', 'Confirmacion', 'http://10.90.10.8/ws_met_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (37, 'MetLife(Mpro)', 'metlife_mpro', 'ConfirmacionBonoExt', 'http://10.90.10.8/ws_met_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (37, 'MetLife(Mpro)', 'metlife_mpro', 'ConfirmacionBono3', 'http://10.90.10.8/ws_met_prod/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (37, 'MetLife(Mpro)', 'metlife_mpro', 'Certificacion', 'http://10.90.10.8/ws_met_prod/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (37, 'MetLife(Mpro)', 'metlife_mpro', 'AnulacionBonoExt', 'http://10.90.10.8/ws_met_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (37, 'MetLife(Mpro)', 'metlife_mpro', 'AnulacionBono3', 'http://10.90.10.8/ws_met_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (37, 'MetLife(Mpro)', 'metlife_mpro', 'Anulacion', 'http://10.90.10.8/ws_met_prod/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (37, 'MetLife(Mpro)', 'metlife_mpro', 'Conciliacion', 'http://10.90.10.8/ws_met_prod/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');

INSERT INTO cias_seguros VALUES (38, 'Chilena Consolidada', 'chicon', 'Confirmacion', 'http://192.168.140.91/VIDA/WebService/Colectivos/wmImed_SrvConfirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_conf');
INSERT INTO cias_seguros VALUES (38, 'Chilena Consolidada', 'chicon', 'ConfirmacionBonoExt', 'http://192.168.140.91/VIDA/WebService/Colectivos/wmImed_SrvConfirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_conf');
INSERT INTO cias_seguros VALUES (38, 'Chilena Consolidada', 'chicon', 'ConfirmacionBono3', 'http://192.168.140.91/VIDA/WebService/Colectivos/wmImed_SrvConfirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_conf');
INSERT INTO cias_seguros VALUES (38, 'Chilena Consolidada', 'chicon', 'Certificacion', 'http://192.168.140.91/VIDA/WebService/Colectivos/wmImed_SrvCertificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_cert');
INSERT INTO cias_seguros VALUES (38, 'Chilena Consolidada', 'chicon', 'AnulacionBonoExt', 'http://192.168.140.91/VIDA/WebService/Colectivos/wmImed_SrvAnulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_anulacion');
INSERT INTO cias_seguros VALUES (38, 'Chilena Consolidada', 'chicon', 'AnulacionBono3', 'http://192.168.140.91/VIDA/WebService/Colectivos/wmImed_SrvAnulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_anulacion');
INSERT INTO cias_seguros VALUES (38, 'Chilena Consolidada', 'chicon', 'Anulacion', 'http://192.168.140.91/VIDA/WebService/Colectivos/wmImed_SrvAnulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_anulacion');
INSERT INTO cias_seguros VALUES (38, 'Chilena Consolidada', 'chicon', 'Conciliacion', 'http://192.168.140.91/VIDA/WebService/Colectivos/wmImed_SrvConciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_chicon_cert');

INSERT INTO cias_seguros VALUES (39, 'Sermecoop', 'sermecoop', 'Confirmacion', 'http://10.0.0.114/~imed/nusoap/Sermecoop/wsConfirmacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (39, 'Sermecoop', 'sermecoop', 'ConfirmacionBonoExt', 'http://10.0.0.114/~imed/nusoap/Sermecoop/wsConfirmacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (39, 'Sermecoop', 'sermecoop', 'ConfirmacionBono3', 'http://10.0.0.114/~imed/nusoap/Sermecoop/wsConfirmacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (39, 'Sermecoop', 'sermecoop', 'Certificacion', 'http://10.0.0.114/~imed/nusoap/Sermecoop/wsCertificacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (39, 'Sermecoop', 'sermecoop', 'AnulacionBonoExt', 'http://10.0.0.114/~imed/nusoap/Sermecoop/wsAnulacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (39, 'Sermecoop', 'sermecoop', 'AnulacionBono3', 'http://10.0.0.114/~imed/nusoap/Sermecoop/wsAnulacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (39, 'Sermecoop', 'sermecoop', 'Anulacion', 'http://10.0.0.114/~imed/nusoap/Sermecoop/wsAnulacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (39, 'Sermecoop', 'sermecoop', 'Conciliacion', 'http://10.0.0.114/~imed/nusoap/Sermecoop/wsConciliacion.php', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (40, 'Chubb(Trassa)', 'trasa2', 'Confirmacion', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (40, 'Chubb(Trassa)', 'trasa2', 'ConfirmacionBonoExt', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (40, 'Chubb(Trassa)', 'trasa2', 'ConfirmacionBono3', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (40, 'Chubb(Trassa)', 'trasa2', 'Certificacion', 'http://192.10.1.100/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (40, 'Chubb(Trassa)', 'trasa2', 'AnulacionBonoExt', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (40, 'Chubb(Trassa)', 'trasa2', 'AnulacionBono3', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (40, 'Chubb(Trassa)', 'trasa2', 'Anulacion', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (40, 'Chubb(Trassa)', 'trasa2', 'Conciliacion', 'http://192.10.1.100/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (41, 'CCAF(Mpro)', 'mpro2', 'Confirmacion', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (41, 'CCAF(Mpro)', 'mpro2', 'ConfirmacionBonoExt', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (41, 'CCAF(Mpro)', 'mpro2', 'ConfirmacionBono3', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (41, 'CCAF(Mpro)', 'mpro2', 'Certificacion', 'http://10.90.10.8/produccionmpro/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (41, 'CCAF(Mpro)', 'mpro2', 'AnulacionBonoExt', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (41, 'CCAF(Mpro)', 'mpro2', 'AnulacionBono3', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (41, 'CCAF(Mpro)', 'mpro2', 'Anulacion', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (41, 'CCAF(Mpro)', 'mpro2', 'Conciliacion', 'http://10.90.10.8/produccionmpro/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');

INSERT INTO cias_seguros VALUES (42, 'Sura(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (42, 'Sura(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (42, 'Sura(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (42, 'Sura(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.60/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (42, 'Sura(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (42, 'Sura(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (42, 'Sura(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (42, 'Sura(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.60/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (43, 'ChiCon(Mpro)', 'mpro2', 'Confirmacion', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (43, 'ChiCon(Mpro)', 'mpro2', 'ConfirmacionBonoExt', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (43, 'ChiCon(Mpro)', 'mpro2', 'ConfirmacionBono3', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (43, 'ChiCon(Mpro)', 'mpro2', 'Certificacion', 'http://10.90.10.8/produccionmpro/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (43, 'ChiCon(Mpro)', 'mpro2', 'AnulacionBonoExt', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (43, 'ChiCon(Mpro)', 'mpro2', 'AnulacionBono3', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (43, 'ChiCon(Mpro)', 'mpro2', 'Anulacion', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (43, 'ChiCon(Mpro)', 'mpro2', 'Conciliacion', 'http://10.90.10.8/produccionmpro/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');

INSERT INTO cias_seguros VALUES (44, 'Vida Camara', 'camara', 'Confirmacion', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (44, 'Vida Camara', 'camara', 'ConfirmacionBonoExt', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (44, 'Vida Camara', 'camara', 'ConfirmacionBono3', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (44, 'Vida Camara', 'camara', 'Certificacion', 'http://10.90.10.8/produccionmpro/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (44, 'Vida Camara', 'camara', 'AnulacionBonoExt', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (44, 'Vida Camara', 'camara', 'AnulacionBono3', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (44, 'Vida Camara', 'camara', 'Anulacion', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (44, 'Vida Camara', 'camara', 'Conciliacion', 'http://10.90.10.8/produccionmpro/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');

INSERT INTO cias_seguros VALUES (45, 'Integramedica(Faraggi)', 'integrafar', 'Confirmacion', 'http://10.27.11.61/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (45, 'Integramedica(Faraggi)', 'integrafar', 'ConfirmacionBonoExt', 'http://10.27.11.61/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (45, 'Integramedica(Faraggi)', 'integrafar', 'ConfirmacionBono3', 'http://10.27.11.61/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (45, 'Integramedica(Faraggi)', 'integrafar', 'Certificacion', 'http://10.27.11.61/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (45, 'Integramedica(Faraggi)', 'integrafar', 'AnulacionBonoExt', 'http://10.27.11.61/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (45, 'Integramedica(Faraggi)', 'integrafar', 'AnulacionBono3', 'http://10.27.11.61/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (45, 'Integramedica(Faraggi)', 'integrafar', 'Anulacion', 'http://10.27.11.61/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (45, 'Integramedica(Faraggi)', 'integrafar', 'Conciliacion', 'http://10.27.11.61/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (46, 'MOK Assist(Mpro)', 'mpro2', 'Confirmacion', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (46, 'MOK Assist(Mpro)', 'mpro2', 'ConfirmacionBonoExt', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (46, 'MOK Assist(Mpro)', 'mpro2', 'ConfirmacionBono3', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (46, 'MOK Assist(Mpro)', 'mpro2', 'Certificacion', 'http://10.90.10.8/produccionmpro/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (46, 'MOK Assist(Mpro)', 'mpro2', 'AnulacionBonoExt', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (46, 'MOK Assist(Mpro)', 'mpro2', 'AnulacionBono3', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (46, 'MOK Assist(Mpro)', 'mpro2', 'Anulacion', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (46, 'MOK Assist(Mpro)', 'mpro2', 'Conciliacion', 'http://10.90.10.8/produccionmpro/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');

INSERT INTO cias_seguros VALUES (47, 'Vida Camara(Mpro)', 'mpro2', 'AnulacionBonoExt', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (47, 'Vida Camara(Mpro)', 'mpro2', 'AnulacionBono3', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (47, 'Vida Camara(Mpro)', 'mpro2', 'Confirmacion', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (47, 'Vida Camara(Mpro)', 'mpro2', 'ConfirmacionBonoExt', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (47, 'Vida Camara(Mpro)', 'mpro2', 'ConfirmacionBono3', 'http://10.90.10.8/produccionmpro/confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro');
INSERT INTO cias_seguros VALUES (47, 'Vida Camara(Mpro)', 'mpro2', 'Certificacion', 'http://10.90.10.8/produccionmpro/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (47, 'Vida Camara(Mpro)', 'mpro2', 'Anulacion', 'http://10.90.10.8/produccionmpro/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');
INSERT INTO cias_seguros VALUES (47, 'Vida Camara(Mpro)', 'mpro2', 'Conciliacion', 'http://10.90.10.8/produccionmpro/conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_mpro_cert');

INSERT INTO cias_seguros VALUES (48, 'Magallanes(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (48, 'Magallanes(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (48, 'Magallanes(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (48, 'Magallanes(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.11/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (48, 'Magallanes(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (48, 'Magallanes(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (48, 'Magallanes(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (48, 'Magallanes(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.11/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (49, 'BBVA(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (49, 'BBVA(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (49, 'BBVA(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (49, 'BBVA(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.11/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (49, 'BBVA(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (49, 'BBVA(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (49, 'BBVA(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (49, 'BBVA(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.11/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (51, 'BBVA(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (51, 'BBVA(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (51, 'BBVA(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (51, 'BBVA(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.60/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (51, 'BBVA(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (51, 'BBVA(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (51, 'BBVA(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (51, 'BBVA(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.60/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (52, 'Vida Security(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (52, 'Vida Security(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (52, 'Vida Security(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (52, 'Vida Security(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.60/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (52, 'Vida Security(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (52, 'Vida Security(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (52, 'Vida Security(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (52, 'Vida Security(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.60/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (53, 'Vida Camara(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (53, 'Vida Camara(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (53, 'Vida Camara(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (53, 'Vida Camara(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.60/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (53, 'Vida Camara(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (53, 'Vida Camara(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (53, 'Vida Camara(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (53, 'Vida Camara(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.60/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (56, 'Magallanes(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (56, 'Magallanes(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (56, 'Magallanes(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (56, 'Magallanes(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.60/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (56, 'Magallanes(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (56, 'Magallanes(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (56, 'Magallanes(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (56, 'Magallanes(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.60/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (57, 'Colmena(Faraggi)', 'far2', 'Confirmacion', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (57, 'Colmena(Faraggi)', 'far2', 'ConfirmacionBonoExt', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (57, 'Colmena(Faraggi)', 'far2', 'ConfirmacionBono3', 'http://10.27.11.60/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (57, 'Colmena(Faraggi)', 'far2', 'Anulacion', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (57, 'Colmena(Faraggi)', 'far2', 'AnulacionBonoExt', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (57, 'Colmena(Faraggi)', 'far2', 'AnulacionBono3', 'http://10.27.11.60/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (57, 'Colmena(Faraggi)', 'far2', 'Certificacion', 'http://10.27.11.60/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (57, 'Colmena(Faraggi)', 'far2', 'Conciliacion', 'http://10.27.11.60/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

--http://ws-seguros.cruzblanca.cl/wsIntegracionLGM/IntegracionLGM.asmx/
INSERT INTO cias_seguros VALUES (58, 'CruzBlanca', 'cbvida', 'Confirmacion', 'http://ws-seguros.cruzblanca.cl/wsIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_conf');
INSERT INTO cias_seguros VALUES (58, 'CruzBlanca', 'cbvida', 'ConfirmacionBonoExt','http://ws-seguros.cruzblanca.cl/wsIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_conf');
INSERT INTO cias_seguros VALUES (58, 'CruzBlanca', 'cbvida', 'ConfirmacionBono3','http://ws-seguros.cruzblanca.cl/wsIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_conf');
INSERT INTO cias_seguros VALUES (58, 'CruzBlanca', 'cbvida', 'Conciliacion', 'http://ws-seguros.cruzblanca.cl/wsIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_concilia');
INSERT INTO cias_seguros VALUES (58, 'CruzBlanca', 'cbvida', 'Anulacion', 'http://ws-seguros.cruzblanca.cl/wsIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_anula');
INSERT INTO cias_seguros VALUES (58, 'CruzBlanca', 'cbvida', 'AnulacionBonoExt', 'http://ws-seguros.cruzblanca.cl/wsIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_anula');
INSERT INTO cias_seguros VALUES (58, 'CruzBlanca', 'cbvida', 'AnulacionBono3', 'http://ws-seguros.cruzblanca.cl/wsIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_anula');
INSERT INTO cias_seguros VALUES (58, 'CruzBlanca', 'cbvida', 'Certificacion', 'http://ws-seguros.cruzblanca.cl/wsIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_cert');

INSERT INTO cias_seguros VALUES (59, 'Mapfre(Trassa)', 'trasa', 'Confirmacion', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (59, 'Mapfre(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (59, 'Mapfre(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://192.169.50.11/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (59, 'Mapfre(Trassa)', 'trasa', 'Certificacion', 'http://192.169.50.11/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (59, 'Mapfre(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (59, 'Mapfre(Trassa)', 'trasa', 'AnulacionBono3', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (59, 'Mapfre(Trassa)', 'trasa', 'Anulacion', 'http://192.169.50.11/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (59, 'Mapfre(Trassa)', 'trasa', 'Conciliacion', 'http://192.169.50.11/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (91, 'Consorcio(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (91, 'Consorcio(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (91, 'Consorcio(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (91, 'Consorcio(Imed)', 'imed', 'Certificacion', 'http://10.100.32.148/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (91, 'Consorcio(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (91, 'Consorcio(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (91, 'Consorcio(Imed)', 'imed', 'Anulacion', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (91, 'Consorcio(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.148/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (93, 'SurAsistencia(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (93, 'SurAsistencia(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (93, 'SurAsistencia(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (93, 'SurAsistencia(Imed)', 'imed', 'Certificacion', 'http://10.100.32.148/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (93, 'SurAsistencia(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (93, 'SurAsistencia(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (93, 'SurAsistencia(Imed)', 'imed', 'Anulacion', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (93, 'SurAsistencia(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.148/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (100, 'Liq-Pruebas(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (100, 'Liq-Pruebas(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (100, 'Liq-Pruebas(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (100, 'Liq-Pruebas(Imed)', 'imed', 'Certificacion', 'http://10.100.32.148/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (100, 'Liq-Pruebas(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (100, 'Liq-Pruebas(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (100, 'Liq-Pruebas(Imed)', 'imed', 'Anulacion', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (100, 'Liq-Pruebas(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.148/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (101, 'CCAF(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (101, 'CCAF(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (101, 'CCAF(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (101, 'CCAF(Imed)', 'imed', 'Certificacion', 'http://10.100.32.148/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (101, 'CCAF(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (101, 'CCAF(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (101, 'CCAF(Imed)', 'imed', 'Anulacion', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (101, 'CCAF(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.148/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (102, 'Ben Salud(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (102, 'Ben Salud(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (102, 'Ben Salud(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (102, 'Ben Salud(Imed)', 'imed', 'Certificacion', 'http://10.100.32.148/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (102, 'Ben Salud(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (102, 'Ben Salud(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (102, 'Ben Salud(Imed)', 'imed', 'Anulacion', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (102, 'Ben Salud(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.148/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (103, 'Gea Chile(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (103, 'Gea Chile(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (103, 'Gea Chile(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (103, 'Gea Chile(Imed)', 'imed', 'Certificacion', 'http://10.100.32.148/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (103, 'Gea Chile(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.148/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (103, 'Gea Chile(Imed)', 'imed', 'Anulacion', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (103, 'Gea Chile(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (103, 'Gea Chile(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (104, 'CruzBlanca(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (104, 'CruzBlanca(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (104, 'CruzBlanca(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (104, 'CruzBlanca(Imed)', 'imed', 'Certificacion', 'http://10.100.32.148/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (104, 'CruzBlanca(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (104, 'CruzBlanca(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (104, 'CruzBlanca(Imed)', 'imed', 'Anulacion', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (104, 'CruzBlanca(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.148/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (105, 'Caja Andes', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (105, 'Caja Andes', 'imed', 'ConfirmacionBono3', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (105, 'Caja Andes', 'imed', 'AnulacionBonoExt', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (105, 'Caja Andes', 'imed', 'AnulacionBono3', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (105, 'Caja Andes', 'imed', 'Confirmacion', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (105, 'Caja Andes', 'imed', 'Certificacion', 'http://10.100.32.148/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (105, 'Caja Andes', 'imed', 'Anulacion', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (105, 'Caja Andes', 'imed', 'Conciliacion', 'http://10.100.32.148/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


-- Liquidador 106 - Sur Asistencia-Enfermedad(Imed)
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'Anulacion', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'Certificacion', 'http://10.100.32.148/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('106', 'Sur Asistencia-Enfermedad(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.148/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


-- Liquidador 108 - Caja 18(Imed)
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Anulacion', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.148/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.148/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Certificacion', 'http://10.100.32.148/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('108', 'Caja 18(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.148/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

INSERT INTO cias_seguros VALUES (122, 'Metlife', 'metlife_cert', 'Confirmacion', 'http://172.22.1.32:104/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (122, 'Metlife', 'metlife_cert', 'ConfirmacionBonoExt', 'http://172.22.1.32:104/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (122, 'Metlife', 'metlife_cert', 'ConfirmacionBono3', 'http://172.22.1.32:104/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES (122, 'Metlife', 'metlife_cert', 'Certificacion', 'http://172.22.1.32:104/IFWIMEDws/WS/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (122, 'Metlife', 'metlife_cert', 'AnulacionBonoExt', 'http://172.22.1.32:104/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (122, 'Metlife', 'metlife_cert', 'AnulacionBono3', 'http://172.22.1.32:104/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (122, 'Metlife', 'metlife_cert', 'Anulacion', 'http://172.22.1.32:104/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES (122, 'Metlife', 'metlife_cert', 'Conciliacion', 'http://172.22.1.32:104/IFWIMEDws/WS/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


--UPDATE cias_seguros set mail_cia='' where tx in ('Certificacion','Conciliacion');

