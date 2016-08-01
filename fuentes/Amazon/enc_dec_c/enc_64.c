#include <memory.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#include <string.h>
#include <libpq-fe.h>
#include <postgres.h>
#include <fmgr.h>
#include <math.h>

#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

PG_FUNCTION_INFO_V1(string_to_64);

Datum string_to_64(PG_FUNCTION_ARGS)
{
    static const char* base64_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    text *input = PG_GETARG_TEXT_P(0);
    unsigned char const * in = VARDATA(input);
    size_t len = VARSIZE(input)-VARHDRSZ;

    int32 new_text_size = len;

    text *output = (text *) palloc(2* new_text_size + 1 +VARHDRSZ);
    SET_VARSIZE(output,2*new_text_size + 1 + VARHDRSZ);

    char *o = VARDATA(output);

    int i = 0;
    int j = 0;
    unsigned char char_array_3[3];
    unsigned char char_array_4[4];

    while (len --) {
        char_array_3[i++] = *(in++);
        if (i == 3) {
            char_array_4[0] = (char_array_3[0] & 0xfc) >> 2;
            char_array_4[1] = ((char_array_3[0] & 0x03) << 4) + ((char_array_3[1] & 0xf0) >> 4);
            char_array_4[2] = ((char_array_3[1] & 0x0f) << 2) + ((char_array_3[2] & 0xc0) >> 6);
            char_array_4[3] = char_array_3[2] & 0x3f;

            for(i = 0; (i <4) ; i++){
                o[j] = base64_chars[char_array_4[i]];
		j++;
	    }
            i = 0;
        }
    }
    int k =j;
    j=0;
    if (i)
    {
        for(j = i; j < 3; j++)
            char_array_3[j] = '\0';
            char_array_4[0] = (char_array_3[0] & 0xfc) >> 2;
            char_array_4[1] = ((char_array_3[0] & 0x03) << 4) + ((char_array_3[1] & 0xf0) >> 4);
            char_array_4[2] = ((char_array_3[1] & 0x0f) << 2) + ((char_array_3[2] & 0xc0) >> 6);
            char_array_4[3] = char_array_3[2] & 0x3f;

            for (j = 0; (j < i + 1); j++){
                o[k] = base64_chars[char_array_4[j]];
		k++;
	    }

            while((i++ < 3)){
                o[k] = '=';
		k++;
	    }
    }
    o[k]=0;

    PG_RETURN_TEXT_P(output);
}
