--10.171.127.30:204
DELETE FROM cias_seguros WHERE codigo = '36';

INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'Certificacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'ConfirmacionBono3', 'http://10.171.127.30:204/IFWIMEDws/WS/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert', 'jcossio@i-med.cl');
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'ConfirmacionBonoExt', 'http://10.171.127.30:204/IFWIMEDws/WS/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert', 'jcossio@i-med.cl');
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'Confirmacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica', 'jcossio@i-med.cl');
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'Anulacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert', 'jcossio@i-med.cl');
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'AnulacionBono3', 'http://10.171.127.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert', 'jcossio@i-med.cl');
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'AnulacionBonoExt', 'http://10.171.127.30:204/IFWIMEDws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert', 'jcossio@i-med.cl');
INSERT INTO cias_seguros VALUES ('36', 'CCAF(Metlife)', 'metlife', 'Conciliacion', 'http://10.171.127.30:204/IFWIMEDws/WS/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


