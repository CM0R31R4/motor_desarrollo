-- CIA 73 | CARDIF SERVICIOS Y ASISTENCIAS. [El dia 16-05-2016 se crea compañia a peticion de Sebastian Lagos]
-- CIA 70 | CARDIF SERVICIOS Y ASISTENCIAS. [El dia 10-05-2016 se crea compañia a peticion de Sebastian Lagos] - [El día 16-05-2016 se elmina cia. 70 y se cambia por 73]
DELETE FROM cias_seguros WHERE codigo = '73';

--INSERT INTO cias_seguros VALUES ('70', 'CARDIF', 'cardif', 'Conciliacion', 'http://192.169.50.11/Servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('70', 'CARDIF', 'cardif', 'Certificacion', 'http://192.169.50.11/Servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('70', 'CARDIF', 'cardif', 'Confirmacion', 'http://192.169.50.11/Servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
--INSERT INTO cias_seguros VALUES ('70', 'CARDIF', 'cardif', 'ConfirmacionBono3', 'http://192.169.50.11/Servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica');
--INSERT INTO cias_seguros VALUES ('70', 'CARDIF', 'cardif', 'ConfirmacionBonoExt', 'http://192.169.50.11/Servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica');
--INSERT INTO cias_seguros VALUES ('70', 'CARDIF', 'cardif', 'Anulacion', 'http://192.169.50.11/Servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('70', 'CARDIF', 'cardif', 'AnulacionBono3', 'http://192.169.50.11/Servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('70', 'CARDIF', 'cardif', 'AnulacionBonoExt', 'http://192.169.50.11/Servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


INSERT INTO cias_seguros VALUES ('73', 'CARDIF', 'cardif', 'Conciliacion', 'http://192.169.50.11/Servicios/wsConciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('73', 'CARDIF', 'cardif', 'Certificacion', 'http://192.169.50.11/Servicios/wsCertificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('73', 'CARDIF', 'cardif', 'Confirmacion', 'http://192.169.50.11/Servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('73', 'CARDIF', 'cardif', 'ConfirmacionBono3', 'http://192.169.50.11/Servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('73', 'CARDIF', 'cardif', 'ConfirmacionBonoExt', 'http://192.169.50.11/Servicios/wsConfirmacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('73', 'CARDIF', 'cardif', 'Anulacion', 'http://192.169.50.11/Servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('73', 'CARDIF', 'cardif', 'AnulacionBono3', 'http://192.169.50.11/Servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('73', 'CARDIF', 'cardif', 'AnulacionBonoExt', 'http://192.169.50.11/Servicios/wsAnulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--

