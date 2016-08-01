drop table isys_tx_formatos;
CREATE TABLE isys_tx_formatos (
    descripcion character varying(100),
    proceso character varying(30),
    secuencia smallint,
    largo_llave1 smallint,
    posicion_llave1 smallint,
    largo_llave2 smallint,
    posicion_llave2 smallint,
    tipo_llave character varying(10),
    llave character varying(200),
    data_web smallint,
    formato_entrada smallint,
    formato_in_trans smallint,
    formato_out_trans smallint,
    formato_salida smallint,
    formato_salida_texto smallint,
    nombre_campo_texto character varying(30),
    salida_xml smallint,
    servicio smallint,
    tag_pagina_respuesta character varying(30),
    formato_respuesta_ok smallint,
    formato_respuesta_nk smallint
);


CREATE UNIQUE INDEX isys_tx_formatos_01 ON isys_tx_formatos USING btree (llave, proceso);

/*LSTR FONASA(BNO)*/
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','FONASA_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8101,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','FONASA_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8101,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','FONASA_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9101,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','FONASA_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9101,101,101,2);


/*LSTR CCHC(BNO)*/
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','CCHC_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8111,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','CCHC_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8111,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','CCHC_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9111,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','CCHC_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9111,101,101,2);


/*LSTR VIDACAMARA(BNO)*/
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','VIDACAMARA_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8144,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','VIDACAMARA_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8144,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','VIDACAMARA_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9144,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','VIDACAMARA_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9144,101,101,2);


/*LSTR SANLORENZO(BNO)*/
/*
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','SANLORENZO_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8162,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','SANLORENZO_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8162,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','SANLORENZO_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9162,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','SANLORENZO_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9162,101,101,2);
*/

/*LSTR SANLORENZO - FUSAT - CHUQUICAMATA - RIOBLANCO(BNO)*/
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','FUSAT_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8163,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','FUSAT_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8163,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','FUSAT_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9163,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','FUSAT_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9163,101,101,2);


/*LSTR CHUQUICAMATA(BNO)*/
/*
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','CHUQUICAMATA_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8165,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','CHUQUICAMATA_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8165,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','CHUQUICAMATA_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9165,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','CHUQUICAMATA_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9165,101,101,2);
*/

/*LSTR COLMENA(BNO)*/
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','COLMENA_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8167,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','COLMENA_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8167,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','COLMENA_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9167,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','COLMENA_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9167,101,101,2);


/*LSTR RIOBLANCO(BNO)*/
/*
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','RIOBLANCO_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8168,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','RIOBLANCO_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8168,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','RIOBLANCO_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9168,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','RIOBLANCO_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9168,101,101,2);
*/

/*LSTR CONSALUD(BNO)*/
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','CONSALUD_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8171,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','CONSALUD_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8171,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','CONSALUD_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9171,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','CONSALUD_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9171,101,101,2);


/*LSTR FUNDACION(BNO)*/
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','FUNDACION_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8176,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','FUNDACION_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8176,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','FUNDACION_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9176,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','FUNDACION_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9176,101,101,2);


/*LSTR CRUZBLANCA(BNO)*/
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','CRUZBLANCA_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8178,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','CRUZBLANCA_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8178,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','CRUZBLANCA_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9178,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','CRUZBLANCA_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9178,101,101,2);


/*LSTR VIDATRES(BNO)*/
/*
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','VIDATRES_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8180,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','VIDATRES_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8180,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','VIDATRES_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9180,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','VIDATRES_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9180,101,101,2);
*/

/*LSTR FERROSALUD(BNO)*/
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','FERROSALUD_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8181,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','FERROSALUD_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8181,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','FERROSALUD_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9181,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','FERROSALUD_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9181,101,101,2);


/*LSTR MASVIDA(BNO)*/
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','MASVIDA_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8188,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','MASVIDA_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8188,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','MASVIDA_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9188,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','MASVIDA_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9188,101,101,2);


/*LSTR CRUZDELNORTE(BNO)*/
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','CRUZDELNORTE_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8194,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','CRUZDELNORTE_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8194,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','CRUZDELNORTE_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9194,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','CRUZDELNORTE_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9194,101,101,2);


/*LSTR BANMEDICA - VIDATRES (BNO)*/
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','BANMEDICA_LSTR_BNO',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8199,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','BANMEDICA_LSTR_BNO',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8199,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','BANMEDICA_LSTR_BNO',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9199,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','BANMEDICA_LSTR_BNO',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9199,101,101,2);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*LSTR MASVIDA(CME)*/
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','MASVIDA_LSTR_CME',0,0,0,0,0,'XML','</SOAP-ENV:Envelope>',100,0,0,0,0,8688,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WS','MASVIDA_LSTR_CME',0,0,0,0,0,'XML','</soapenv:Envelope>',100,0,0,0,0,8688,101,101,2);
--Archivos WSDL y XSD
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','MASVIDA_LSTR_CME',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,9688,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','MASVIDA_LSTR_CME',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,9688,101,101,2);


--Archivos WSDL y XSD
/*
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_WSDL','LISTENER_WS',0,0,0,0,0,'XML','?wsdl',100,0,0,0,0,3001,101,101,2);
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_XSD','LISTENER_WS',0,0,0,0,0,'XML','?xsd=',100,0,0,0,0,3001,101,101,2);
*/

/*Autentia Medios de Pagos*/
insert into isys_tx_formatos (descripcion,proceso,secuencia,largo_llave1,posicion_llave1,largo_llave2,posicion_llave2,tipo_llave,llave,formato_entrada,formato_in_trans,formato_out_trans,formato_salida,formato_salida_texto,servicio,formato_respuesta_ok,formato_respuesta_nk,salida_xml) values ('TX_MP','AUTENTIA_WS',0,0,0,0,0,'XML','</requerimiento>',100,0,0,0,0,3010,101,101,2);

