-- MTG Apuntando a Liquidador QA
/*
DELETE FROM cias_seguros WHERE codigo = '104';

INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'Confirmacion', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsConfirmacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'Conciliacion', 'http://10.100.32.153/liquidador/qa/WsConciliacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'Anulacion', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'AnulacionBono3', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/liquidador/qa/WsAnulacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'cbvida', 'imed', 'Certificacion', 'http://10.100.32.153/liquidador/qa/WsCertificacion/service', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
*/
-- CM : 2015-11-30 : Se comentan a peticion de Fernanda Jara.
/*
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'Confirmacion', 'http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_conf');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'ConfirmacionBono3','http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_conf');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'ConfirmacionBonoExt','http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_conf');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'Conciliacion', 'http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_concilia');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'Anulacion', 'http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_anula');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'AnulacionBono3', 'http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_anula');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'AnulacionBonoExt', 'http://seguros.cruzblanca.qa/wsIntegracionLGM/IntegracionLGM.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_anula');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'cbvida', 'Certificacion', 'http://seguros.cruzblanca.qa/wsIntegracionLGM/', 'sp_respuesta_cia_generica', 'sp_input_cia_cbvida_cert');
*/

-- CM : 2015-11-30 : Se descomentan a peticion de Fernanda Jara.
-- MTG Apuntando a Liquidador Pruebas
DELETE FROM cias_seguros WHERE codigo = '104';

INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'Confirmacion', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'ConfirmacionBono3', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'ConfirmacionBonoExt', 'http://10.100.32.153/Confirmacion/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'Conciliacion', 'http://10.100.32.153/Conciliacion/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'Anulacion', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'AnulacionBono3', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'AnulacionBonoExt', 'http://10.100.32.153/Anulacion/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('104', 'CruzBlanca(Imed)', 'imed', 'Certificacion', 'http://10.100.32.153/Certificacion/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


