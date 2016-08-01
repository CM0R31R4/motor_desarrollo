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

PG_FUNCTION_INFO_V1(get_campo_c);

Datum get_campo_c(PG_FUNCTION_ARGS)
{
    text  *campo = PG_GETARG_TEXT_P(0);
    text  *xml1 = PG_GETARG_TEXT_P(1);
    char  *ini=NULL;
    char  *ini1=NULL;
    char *fin=NULL;  
    text  *campo1 = NULL;
    text  *xml2 = NULL;
    text *salida=NULL;
    int len;
    int32 text_size;
    
   //Arma campo con [
    text_size = VARSIZE(campo)+3+1+1;
    campo1 = (text *) palloc(text_size);
    SET_VARSIZE(campo1,text_size);
    memcpy(VARDATA(campo1),"###",3);
    memcpy(VARDATA(campo1)+3,VARDATA(campo),VARSIZE(campo)-VARHDRSZ);
    memcpy(VARDATA(campo1)+3+VARSIZE(campo)-VARHDRSZ,"[",1);
    memset(VARDATA(campo1)+3+VARSIZE(campo)-VARHDRSZ+1,0,1);
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
    ini=strstr(VARDATA(xml2),VARDATA(campo1));
    //Si no existe no esta el campo
    if (ini==NULL) goto clean;

    //Busca ]=
    ini1=strstr(ini,"]=");
    //Si no existe esta mal formado
    if (ini1==NULL) goto clean;
    
    //Busco el final del string
    fin=strstr(ini1,"###");
    //Si no existe esta mal formado
    if (fin==NULL) goto clean;

    //El largo del string esta dado por 
    len=fin-ini1-2;

    //Si el len es mayor que cero
    if (len<=0) goto clean;

    //elog(NOTICE,"ini1 %s",ini1);
    //elog(NOTICE,"fin %s",fin);
    //elog(NOTICE,"Largo %i",len);
  
    //Genera Salida sin /0 al final
    text_size = len+VARHDRSZ;
    salida = (text *) palloc(text_size);
    SET_VARSIZE(salida,text_size);
    //Me salto ]=
    memcpy(VARDATA(salida),ini1+2,len);
    //memset(VARDATA(salida)+len+1,0,1);
    //elog(NOTICE,"%s",VARDATA(salida));
    PG_RETURN_TEXT_P(salida);

clean:
    if (campo1) pfree(campo1);
    if (xml2) pfree(xml2);
    text_size = VARHDRSZ;
    salida = (text *) palloc(text_size);
    SET_VARSIZE(salida,text_size);
    //memset(VARDATA(salida),0,1);
    PG_RETURN_TEXT_P(salida);
}
