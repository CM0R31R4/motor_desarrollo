DELETE FROM cias_seguros WHERE codigo = '16';

INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'Anulacion', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'AnulacionBono3', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'AnulacionBonoExt', 'http://192.10.1.100/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'Confirmacion', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'ConfirmacionBono3', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'ConfirmacionBonoExt', 'http://192.10.1.100/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'Certificacion', 'http://192.10.1.100/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('16', 'MetLife(Trassa)', 'trasa2', 'Conciliacion', 'http://192.10.1.100/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');