--10.171.127.30:204
-- MetLife
DELETE FROM cias_seguros WHERE codigo = '12';
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'Confirmacion', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica', 'cmoreira@i-med.cl');
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'ConfirmacionBono3', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica', 'cmoreira@i-med.cl');
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'ConfirmacionBonoExt', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica', 'cmoreira@i-med.cl');
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'Conciliacion', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert','');
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'Anulacion', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert', 'cmoreira@i-med.cl');
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'AnulacionBono3', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica_cert', 'cmoreira@i-med.cl');
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'AnulacionBonoExt', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsAnulacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica_cert', 'cmoreira@i-med.cl');
INSERT INTO cias_seguros VALUES ('12', 'Metlife', 'metlife', 'Certificacion', 'http://mlclimeddevqa01.alico.corp:204/ifwimedws/WS/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert','');

