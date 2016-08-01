DELETE FROM cias_seguros WHERE codigo = '20';

INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'Certificacion', 'http://192.10.1.8/servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'Conciliacion', 'http://192.10.1.8/servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'Anulacion', 'http://192.10.1.8/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'AnulacionBono3', 'http://192.10.1.8/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'AnulacionBonoExt', 'http://192.10.1.8/servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'Confirmacion', 'http://192.10.1.8/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'ConfirmacionBono3', 'http://192.10.1.8/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('20', 'ING(Trassa)', 'trasa2', 'ConfirmacionBonoExt', 'http://192.10.1.8/servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');