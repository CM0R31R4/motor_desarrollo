DELETE FROM cias_seguros WHERE codigo = '59';
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'Conciliacion', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'Certificacion', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'Confirmacion', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'ConfirmacionBono3', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'ConfirmacionBonoExt', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'Anulacion', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'AnulacionBono3', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('59', 'Mafre(Trassa)', 'trasa', 'AnulacionBonoExt', 'http://qa.adproc.cl:9090/wsMapfre/Servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
