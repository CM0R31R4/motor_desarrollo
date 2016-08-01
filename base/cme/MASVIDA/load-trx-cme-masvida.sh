#!/bin/bash
cd /home/motor/base/cme/MASVIDA

psql -d motor -f ceranthab_masvida.sql
psql -d motor -f cerantmor_masvida.sql
psql -d motor -f cerantqui_masvida.sql
psql -d motor -f cerconciliacioncme.sql
psql -d motor -f cerdetevo_masvida.sql
psql -d motor -f cerdetanam_masvida.sql
psql -d motor -f cerdetprot_masvida.sql
psql -d motor -f cerdiaegr_masvida.sql
psql -d motor -f cerdiagposop_masvida.sql
psql -d motor -f cerdiagpreop_masvida.sql
psql -d motor -f cerencanam_masvida.sql
psql -d motor -f ceremibonopam_masvida.sql
psql -d motor -f cerencepi_masvida.sql
psql -d motor -f cerencprot_masvida.sql
psql -d motor -f cerenvcta_masvida.sql
psql -d motor -f cerenvdetequipo_masvida.sql
psql -d motor -f cerenvdethotele_masvida.sql
psql -d motor -f cerenvdetinsumo_masvida.sql
psql -d motor -f cerenvinfpac_masvida.sql
psql -d motor -f cerenvpaquete_masvida.sql
psql -d motor -f cerenvtipant_masvida.sql
psql -d motor -f cerepiind_masvida.sql
psql -d motor -f cerequmed_masvida.sql
psql -d motor -f cerexafis_masvida.sql
psql -d motor -f cergrpfam_masvida.sql
psql -d motor -f cerobtbonequipo_masvida.sql
psql -d motor -f cerobtbonhotele_masvida.sql
psql -d motor -f cerobtboninsumo_masvida.sql
psql -d motor -f cerobtbonospam_masvida.sql
psql -d motor -f cerobtfecpag_masvida.sql
psql -d motor -f cerobtpaquete_masvida.sql
psql -d motor -f cerobtsaldospag_masvida.sql
psql -d motor -f cerrelhmqprot_masvida.sql
psql -d motor -f cerotrcir_masvida.sql
psql -d motor -f certrapro_masvida.sql

