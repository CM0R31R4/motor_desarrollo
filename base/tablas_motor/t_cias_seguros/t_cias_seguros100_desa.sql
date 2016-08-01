-- MTG Apuntando a Liquidador QA
/*
DELETE FROM cias_seguros WHERE codigo = '100';

INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'Conciliacion', 'http://10.100.32.153/liquidador/qa/WsConciliacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'Anulacion', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'AnulacionBono3', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_ci
INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'Confirmacion', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp
INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('100', 'liquimed', 'imed', 'Certificacion', 'http://10.100.32.153/liquidador/qa/WsCertificacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
*/


-- MTG Apuntando a Liquidador Pruebas
DELETE FROM cias_seguros WHERE codigo = '100';

INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('100', 'Liq(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


