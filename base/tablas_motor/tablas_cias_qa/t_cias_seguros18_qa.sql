DELETE FROM cias_seguros WHERE codigo = '18';
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'Conciliacion', 'http://200.75.5.171:8080/ws_segimed/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'Certificacion', 'http://200.75.5.171:8080/ws_segimed/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'Confirmacion', 'http://200.75.5.171:8080/ws_segimed/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'ConfirmacionBono3', 'http://200.75.5.171:8080/ws_segimed/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'ConfirmacionBonoExt', 'http://200.75.5.171:8080/ws_segimed/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'Anulacion', 'http://200.75.5.171:8080/ws_segimed/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'AnulacionBono3', 'http://200.75.5.171:8080/ws_segimed/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('18', 'Vida Security', 'security', 'AnulacionBonoExt', 'http://200.75.5.171:8080/ws_segimed/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

