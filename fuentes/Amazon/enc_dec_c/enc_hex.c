#include <memory.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#include <string.h>
#include <libpq-fe.h>
#include <postgres.h>
#include <fmgr.h>

#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

PG_FUNCTION_INFO_V1(string_to_hex);

Datum string_to_hex(PG_FUNCTION_ARGS)
{
    static const char* const lut = "0123456789ABCDEF";

    text *input = PG_GETARG_TEXT_P(0);
    char * in = VARDATA(input);
    size_t len = VARSIZE(input)-VARHDRSZ;
	char szTmp[200];
    int32 new_text_size = len;

    text *output = (text *) palloc(2 * new_text_size+VARHDRSZ);
    SET_VARSIZE(output,2 * new_text_size+VARHDRSZ);

    char *o = VARDATA(output);
    
    size_t i = 0;
	int j=0;
    for (i = 0; i < len; ++i)
    {
        const unsigned char c = in[i];
        o[j] = lut[c >> 4];
        o[j+1] = lut[c & 15];
	j+=2;
	/*sprintf(szTmp,"Caracter %i",c);
	elog(NOTICE,szTmp);
	elog(NOTICE,o);
	elog(NOTICE,VARDATA(output));
	*/
    }
	o[j]=0;
	//elog(NOTICE,o);
	//elog(NOTICE,VARDATA(output));

    PG_RETURN_TEXT_P(output);

}
