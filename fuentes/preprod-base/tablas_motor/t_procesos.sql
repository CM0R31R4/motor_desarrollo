drop table procesos;
create table procesos(
        proceso         varchar(50),
        ip              varchar(25),
        cantidad        integer,
        port            integer
        );

create unique index procesos_01 on procesos (proceso);

--QA.BONO3 FONASA
insert into procesos values ('FONASA_LSTR_BNO','127.0.0.1',20,8001);
insert into procesos values ('FONASA_PXML_BNO','127.0.0.1',100,8101);
--insert into procesos values ('API_FONASA_BNO','127.0.0.1',10,8201);

--QA.BONO3 CCHC
insert into procesos values ('CCHC_LSTR_BNO','127.0.0.1',20,8011);
insert into procesos values ('CCHC_PXML_BNO','127.0.0.1',10,8111);
--insert into procesos values ('API_CCHC_BNO','127.0.0.1',10,8211);

--QA.BONO3 VIDACAMARA
insert into procesos values ('VIDACAMARA_LSTR_BNO','127.0.0.1',20,8044);
insert into procesos values ('VIDACAMARA_PXML_BNO','127.0.0.1',10,8144);
--insert into procesos values ('API_VIDACAMARA_BNO','127.0.0.1',10,8244);

--QA.BONO3 FUSAT/SANLORENZO/RIOBLANCO/CHUQUICAMATA
insert into procesos values ('FUSAT_LSTR_BNO','127.0.0.1',20,8063);
insert into procesos values ('FUSAT_PXML_BNO','127.0.0.1',10,8163);
--insert into procesos values ('API_FUSAT_BNO','127.0.0.1',10,8263);

--QA.BONO3 COLMENA
insert into procesos values ('COLMENA_LSTR_BNO','127.0.0.1',20,8067);
insert into procesos values ('COLMENA_PXML_BNO','127.0.0.1',10,8167);
--insert into procesos values ('API_COLMENA_BNO','127.0.0.1',10,8267);

--QA.BONO3 CONSALUD
insert into procesos values ('CONSALUD_LSTR_BNO','127.0.0.1',20,8071);
insert into procesos values ('CONSALUD_PXML_BNO','127.0.0.1',10,8171);
--insert into procesos values ('API_CONSALUD_BNO','127.0.0.1',10,8271);

--QA.BONO3 FUNDACION
insert into procesos values ('FUNDACION_LSTR_BNO','127.0.0.1',20,8076);
insert into procesos values ('FUNDACION_PXML_BNO','127.0.0.1',10,8176);
--insert into procesos values ('API_FUNDACION_BNO','127.0.0.1',10,8276);

--QA.BONO3 CRUZBLANCA
insert into procesos values ('CRUZBLANCA_LSTR_BNO','127.0.0.1',20,8078);
insert into procesos values ('CRUZBLANCA_PXML_BNO','127.0.0.1',10,8178);
--insert into procesos values ('API_CRUZBLANCA_BNO','127.0.0.1',10,8278);

--QA.BONO3 FERROSALUD
insert into procesos values ('FERROSALUD_LSTR_BNO','127.0.0.1',20,8081);
insert into procesos values ('FERROSALUD_PXML_BNO','127.0.0.1',10,8181);
--insert into procesos values ('API_FERROSALUD_BNO','127.0.0.1',10,8281);

--QA.BONO3 MASVIDA
insert into procesos values ('MASVIDA_LSTR_BNO','127.0.0.1',20,8088);
insert into procesos values ('MASVIDA_PXML_BNO','127.0.0.1',10,8188);
--insert into procesos values ('API_MASVIDA_BNO','127.0.0.1',10,8288);

--QA.BONO3 CRUZDELNORTE
insert into procesos values ('CRUZDELNORTE_LSTR_BNO','127.0.0.1',20,8094);
insert into procesos values ('CRUZDELNORTE_PXML_BNO','127.0.0.1',10,8194);
--insert into procesos values ('API_CRUZDELNORTE_BNO','127.0.0.1',10,8294);

--QA.BONO3 BANMEDICA/VIDATRES
insert into procesos values ('BANMEDICA_LSTR_BNO','127.0.0.1',20,8099);
insert into procesos values ('BANMEDICA_PXML_BNO','127.0.0.1',10,8199);
--insert into procesos values ('API_BANMEDICA_BNO','127.0.0.1',10,8299);
---------------------------------------------------------------------------------

--CIAS-SEGUROS
insert into procesos values ('PROCESADOR_SCGI','127.0.0.1',10,4000);
insert into procesos values ('PROCESADOR_CERT_SCGI','127.0.0.1',10,4001);
---------------------------------------------------------------------------------

--Monitor
insert into procesos values ('PXML_MONITOR','127.0.0.1',10,7020);

--GrabaXmlDEC
--insert into procesos values ('PXML_DEC','127.0.0.1',5,7050);

--Liquidador
--insert into procesos values ('PXML_LIQUIDADOR','127.0.0.1',10,6000);

--RME Receta Electronica
--insert into procesos values ('PXML_RECETA','127.0.0.1',10,5000);

--Pxml-MediosPagos
--insert into procesos values ('PROCESA_XML','127.0.0.1',10,7010);
--insert into procesos values ('LISTENER_WS','127.0.0.1',10,7001);

--Para Request desde Autentia
--insert into procesos values ('AUTENTIA_WS','127.0.0.1',10,7001);
---------------------------------------------------------------------------------

--QA.CME MASVIDA
--insert into procesos values ('MASVIDA_LSTR_CME','127.0.0.1',20,8588);
--insert into procesos values ('MASVIDA_PXML_CME','127.0.0.1',10,8688);
--insert into procesos values ('API_MASVIDA_CME','127.0.0.1',10,8788);

