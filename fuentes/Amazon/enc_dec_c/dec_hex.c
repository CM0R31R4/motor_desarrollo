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

PG_FUNCTION_INFO_V1(hex_to_string);

Datum hex_to_string(PG_FUNCTION_ARGS)
{
    text *input = PG_GETARG_TEXT_P(0);
    char * in = VARDATA(input);
    static const char* const lut = "0123456789ABCDEF";
    size_t len = VARSIZE(input)-VARHDRSZ;
    int32 new_text_size = len;

    text * output = (text *) malloc(new_text_size / 2+1 + VARHDRSZ);
    SET_VARSIZE(output,new_text_size/2+1+VARHDRSZ);
    char *o = VARDATA(output);

    size_t i = 0;
    int j = 0;
    for (i = 0; i < len; i += 2)
    {
        char a = in[i];
        const char* p = strchr(lut, a);

        char b = in[i + 1];
        const char* q = strchr(lut, b);

        o[j] = ((p - lut) << 4) | (q - lut);
	j++;
    }
    o[j] = 0;

    PG_RETURN_TEXT_P(output);

}
