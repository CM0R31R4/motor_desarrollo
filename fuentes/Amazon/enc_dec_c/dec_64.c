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

PG_FUNCTION_INFO_V1(b64_to_string);

Datum b64_to_string(PG_FUNCTION_ARGS)
{
    static const char* base64_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    text *input = PG_GETARG_TEXT_P(0);
    unsigned char const * in = VARDATA(input);
    size_t len = VARSIZE(input)-VARHDRSZ;

    int32 new_text_size = len;

    text *output = (text *) palloc(2*new_text_size +1 +VARHDRSZ);
    SET_VARSIZE(output,2*new_text_size+1+ VARHDRSZ);

    char *o = VARDATA(output);

    
    int i = 0;
    int j = 0;
    int k = 0;
    int in_ = 0;
    unsigned char char_array_4[4], char_array_3[3];

    unsigned char c = in[in_];

    while (len-- && ( in[in_] != '=') && (isalnum(c) || (c == '+') || (c == '/'))) {
        char_array_4[i++] = in[in_]; in_++;
	c = in[in_];
        if (i == 4) {
            for (i = 0; i <4; i++){
                //const char *ptr = strchr(base64_chars, char_array_4[i]);
                //int ind = ptr - base64_chars;
                char *ptr = (char *)malloc(2*sizeof(char));
                ptr[0] = char_array_4[i];
                ptr[1] = '\0';
                int ind = strcspn(base64_chars, ptr);
                char_array_4[i] = (unsigned char)ind;
            }

            char_array_3[0] = (char_array_4[0] << 2) + ((char_array_4[1] & 0x30) >> 4);
            char_array_3[1] = ((char_array_4[1] & 0xf) << 4) + ((char_array_4[2] & 0x3c) >> 2);
            char_array_3[2] = ((char_array_4[2] & 0x3) << 6) + char_array_4[3];

            for (i = 0; (i < 3); i++){
            	o[k] = char_array_3[i];
		k++;
	    }
            i = 0;
        }
    }

    if (i) {
        for (j = i; j <4; j++)
            char_array_4[j] = 0;

        for (j = 0; j <4; j++){
        //const char *ptr = strchr(base64_chars, char_array_4[i]);
            //int ind = ptr - base64_chars;
            char *ptr = (char *)malloc(2*sizeof(char));
            ptr[0] = char_array_4[j];
            ptr[1] = '\0';
            int ind = strcspn(base64_chars, ptr);
            char_array_4[j] = (unsigned char)ind;
        }

        char_array_3[0] = (char_array_4[0] << 2) + ((char_array_4[1] & 0x30) >> 4);
        char_array_3[1] = ((char_array_4[1] & 0xf) << 4) + ((char_array_4[2] & 0x3c) >> 2);
        char_array_3[2] = ((char_array_4[2] & 0x3) << 6) + char_array_4[3];

        for (j = 0; (j < i - 1); j++){ 
            o[k] = char_array_3[j];
	    k++;
	}
    }
    o[k]=0;

    PG_RETURN_TEXT_P(output);
}
