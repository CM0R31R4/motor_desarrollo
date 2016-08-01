#include <stdio.h>
#include <string.h>
#include <libpq-fe.h>
#include <xml.h>
#include <const.h>
#include <postgres.h>
#include <fmgr.h>

#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

PG_FUNCTION_INFO_V1(put_campo_c);

Datum put_campo_c(PG_FUNCTION_ARGS)
{
    text  *xml1 = PG_GETARG_TEXT_P(0);
    text  *campo1 = PG_GETARG_TEXT_P(1);
    text  *data1 = PG_GETARG_TEXT_P(2);

    text  *campo_buscado = NULL;
    text  *xml2 = NULL;

    char  *ini=NULL;
    char  *ini1=NULL;
    char *fin=NULL;  
    text *salida=NULL;
    int len,pos1,pos2,len_aux;
	char szAux[512];
    int32 text_size;

   //Si campo1 es null, devulevo data original
	/*
   if (VARDATA(campo1)==NULL) 
   {
        elog(NOTICE,"campo1 nulo");
	PG_RETURN_TEXT_P(xml1);
   }
   else elog(NOTICE,"campo1=%s",VARDATA(campo1));
	*/
    
   //Arma campo con [
    text_size = VARSIZE(campo1)+3+1+1;
    campo_buscado = (text *) palloc(text_size);
    SET_VARSIZE(campo_buscado,text_size);
    memcpy(VARDATA(campo_buscado),"###",3);
    memcpy(VARDATA(campo_buscado)+3,VARDATA(campo1),VARSIZE(campo1)-VARHDRSZ);
    memcpy(VARDATA(campo_buscado)+3+VARSIZE(campo1)-VARHDRSZ,"[",1);
    memset(VARDATA(campo_buscado)+3+VARSIZE(campo1)-VARHDRSZ+1,0,1);
    //elog(NOTICE,"%s",VARDATA(campo1));

    //Agrega ### al xml1
    text_size = VARSIZE(xml1)+3+1;
    xml2 = (text *) palloc(text_size);
    SET_VARSIZE(xml2,text_size);
    memcpy(VARDATA(xml2),"###",3);
    memcpy(VARDATA(xml2)+3,VARDATA(xml1),VARSIZE(xml1)-VARHDRSZ);
    memset(VARDATA(xml2)+3+VARSIZE(xml1)-VARHDRSZ,0,1);
    //elog(NOTICE,"%s",VARDATA(xml2));

    //Busca la primera ocurrencia ###CAMPO[
    ini=strstr(VARDATA(xml2),VARDATA(campo_buscado));
    //Si no existe inserto al principio
    if (ini==NULL) goto inserta;

    //Busca ]=
    ini1=strstr(ini,"]=");
    //Si no existe esta mal formado
    if (ini1==NULL) goto inserta;

    //Busco el final del string
    fin=strstr(ini1,"###");
    //Si no existe esta mal formado
    if (fin==NULL) goto inserta;

    //pos1 es largo de la primera parte
    pos1=ini-VARDATA(xml2);
    //pos2 es donde empieza la 2 parte a concatenar
    pos2=fin-VARDATA(xml2);

    //elog(NOTICE,"ini1 %s",ini1);
    //elog(NOTICE,"fin %s",fin);
    //elog(NOTICE,"Largo %i %i",pos1,pos2);

    //Genera Salida sin /0 al final
    sprintf(szAux,"%i",VARSIZE(data1)-VARHDRSZ);
    len_aux=strlen(szAux);
    text_size = pos1+VARSIZE(xml1)-VARHDRSZ-pos2+VARSIZE(data1)+3+len_aux+VARSIZE(campo1)-VARHDRSZ+3;
    salida = (text *) palloc(text_size);
    SET_VARSIZE(salida,text_size);
    memcpy(VARDATA(salida),VARDATA(xml1),pos1);
    len=pos1;
    memcpy(VARDATA(salida)+len,VARDATA(campo1),VARSIZE(campo1)-VARHDRSZ);
    len+=VARSIZE(campo1)-VARHDRSZ;
    memcpy(VARDATA(salida)+len,"[",1);
    len+=1;
    memcpy(VARDATA(salida)+len,szAux,len_aux);
    len+=len_aux;
    memcpy(VARDATA(salida)+len,"]=",2);
    len+=2;
    memcpy(VARDATA(salida)+len,VARDATA(data1),VARSIZE(data1)-VARHDRSZ);
    len+=VARSIZE(data1)-VARHDRSZ;
    memcpy(VARDATA(salida)+len,"###",3);
    len+=3;
    memcpy(VARDATA(salida)+len,VARDATA(xml1)+pos2,VARSIZE(xml1)-VARHDRSZ-pos2);
    if (campo_buscado) pfree(campo_buscado);
    if (xml2) pfree(xml2);

    //memset(VARDATA(salida)+len+1,0,1);
    //elog(NOTICE,"%s",VARDATA(salida));
    PG_RETURN_TEXT_P(salida);


//Inserta el campo al inicio
inserta:
    sprintf(szAux,"%i",VARSIZE(data1)-VARHDRSZ);
    len_aux=strlen(szAux);
    text_size = VARSIZE(campo1)+1+len_aux+2+VARSIZE(data1)-VARHDRSZ+3+VARSIZE(xml1)-VARHDRSZ;
    salida = (text *) palloc(text_size);
    SET_VARSIZE(salida,text_size);   
    len=VARSIZE(campo1)-VARHDRSZ;
    memcpy(VARDATA(salida),VARDATA(campo1),len);
    memcpy(VARDATA(salida)+len,"[",1);
    len+=1;
    memcpy(VARDATA(salida)+len,szAux,len_aux);
    len+=len_aux;
    memcpy(VARDATA(salida)+len,"]=",2);
    len+=2;
    memcpy(VARDATA(salida)+len,VARDATA(data1),VARSIZE(data1)-VARHDRSZ);
    len+=VARSIZE(data1)-VARHDRSZ;
    memcpy(VARDATA(salida)+len,"###",3);
    len+=3;
    memcpy(VARDATA(salida)+len,VARDATA(xml1),VARSIZE(xml1)-VARHDRSZ);

    //memset(VARDATA(salida),0,1);
    if (campo_buscado) pfree(campo_buscado);
    if (xml2) pfree(xml2);
    PG_RETURN_TEXT_P(salida);
}
