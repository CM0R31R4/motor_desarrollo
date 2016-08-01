-- CIA 60 | RDA - BCI. [Fernanda Jara solicita el día 29-02-2016 que se quite la cia. 71 y se cambie por la 60]
--INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'Conciliacion', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'Certificacion', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'Confirmacion', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
--INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'ConfirmacionBono3', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/Confirmacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica');
--INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'ConfirmacionBonoExt', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/Confirmacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica');
--INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'Anulacion', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'AnulacionBono3', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'AnulacionBonoExt', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');

-- CIA 71 | RDA - BCI. [Fernanda Jara solicita el día 29-02-2016 que se quite la cia. 71 y se cambie por la 60]
--INSERT INTO cias_seguros VALUES ('71', 'RDA-BCI', 'rda', 'Conciliacion', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('71', 'RDA-BCI', 'rda', 'Certificacion', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('71', 'RDA-BCI', 'rda', 'Confirmacion', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
--INSERT INTO cias_seguros VALUES ('71', 'RDA-BCI', 'rda', 'ConfirmacionBono3', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/Confirmacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica');
--INSERT INTO cias_seguros VALUES ('71', 'RDA-BCI', 'rda', 'ConfirmacionBonoExt', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/Confirmacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica');
--INSERT INTO cias_seguros VALUES ('71', 'RDA-BCI', 'rda', 'Anulacion', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('71', 'RDA-BCI', 'rda', 'AnulacionBono3', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
--INSERT INTO cias_seguros VALUES ('71', 'RDA-BCI', 'rda', 'AnulacionBonoExt', 'http://desarrollo.microexpertos.cl/RDA/WS/IMED/anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


-- CIA 60 | RDA - BCI. [El dia 06-05-2016 se actualizan URL de WS] 
DELETE FROM cias_seguros WHERE codigo = '60';

INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'Conciliacion', 'http://qa.microexpertos.cl/RDA/ws-imed/Conciliacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'Certificacion', 'http://qa.microexpertos.cl/RDA/ws-imed/Certificacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'Confirmacion', 'http://qa.microexpertos.cl/RDA/ws-imed/Confirmacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'ConfirmacionBono3', 'http://qa.microexpertos.cl/RDA/ws-imed/Confirmacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'ConfirmacionBonoExt', 'http://qa.microexpertos.cl/RDA/ws-imed/Confirmacion.asmx', 'sp_respuesta_cia_generica','sp_input_cia_generica');
INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'Anulacion', 'http://qa.microexpertos.cl/RDA/ws-imed/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'AnulacionBono3', 'http://qa.microexpertos.cl/RDA/ws-imed/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');
INSERT INTO cias_seguros VALUES ('60', 'RDA-BCI', 'rda', 'AnulacionBonoExt', 'http://qa.microexpertos.cl/RDA/ws-imed/Anulacion.asmx', 'sp_respuesta_cia_generica', 'sp_input_cia_generica_cert');


