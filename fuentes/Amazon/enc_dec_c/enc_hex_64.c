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

PG_FUNCTION_INFO_V1(hex_64_hex);

Datum hex_64_hex(PG_FUNCTION_ARGS)
{

    /* Fase 1: Pasar el Hexa que viene como input a string */

    text *input = PG_GETARG_TEXT_P(0);
    char * in = VARDATA(input);
    static const char* const lut = "0123456789abcdef";
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
//elog(NOTICE,o);
    /* Fin Fase 1 */

    /* Fase 2: Pasar el string a base64 */

    static const char* base64_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    text *hexa = output;
    unsigned char const * in_hexa = VARDATA(hexa);
    size_t len_hexa = VARSIZE(hexa)-VARHDRSZ;

    int32 new_text_size_hexa = len_hexa;

    text *output_64 = (text *) palloc(2* new_text_size_hexa + 1 +VARHDRSZ);
    SET_VARSIZE(output_64,2*new_text_size_hexa + 1 + VARHDRSZ);

    char *o_64 = VARDATA(output_64);

    i = 0;
    j = 0;
    unsigned char char_array_3[3];
    unsigned char char_array_4[4];

    while (len_hexa --) {
        char_array_3[i++] = *(in_hexa++);
        if (i == 3) {
            char_array_4[0] = (char_array_3[0] & 0xfc) >> 2;
            char_array_4[1] = ((char_array_3[0] & 0x03) << 4) + ((char_array_3[1] & 0xf0) >> 4);
            char_array_4[2] = ((char_array_3[1] & 0x0f) << 2) + ((char_array_3[2] & 0xc0) >> 6);
            char_array_4[3] = char_array_3[2] & 0x3f;

            for(i = 0; (i <4) ; i++){
                o_64[j] = base64_chars[char_array_4[i]];
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
                o_64[k] = base64_chars[char_array_4[j]];
                k++;
            }
	    while((i++ < 3)){
                o_64[k] = '=';
                k++;
            }
    }
    o_64[k]=0;
//elog(NOTICE,o_64);
  
    /* Fin Fase 2 */

    /* Fase 3: Pasar el base64 a hexa */

    text *input_64 = output_64;
    char * in_64 = VARDATA(input_64);
    size_t len_64 = VARSIZE(input_64)-VARHDRSZ -VARHDRSZ;
    char szTmp[200];
    int32 new_text_size_64 = len_64;

//  sprintf(szTmp,"Caracter %i",len_64);
       
  //      elog(NOTICE,szTmp);
  
    text *output_hex = (text *) palloc(2 * new_text_size_64+VARHDRSZ);
    SET_VARSIZE(output_hex,2 * new_text_size_64+VARHDRSZ);

    char *o_hex = VARDATA(output_hex);

    i = 0;
    j=0;
    for (i = 0; i < len_64; ++i)
    {
        const unsigned char c = in_64[i];
        o_hex[j] = lut[c >> 4];
        o_hex[j+1] = lut[c & 15];
//	sprintf(szTmp,"Caracter %i , %i, %i",c, o_hex[j], o_hex[j+1]);
        j+=2;
  /*      elog(NOTICE,szTmp);
        elog(NOTICE,o_hex);
        elog(NOTICE,VARDATA(output_hex));*/
        
    }
    o_hex[j]=0;
//elog(NOTICE,o_hex);
    /* Fin Fase 3 */
 
    PG_RETURN_TEXT_P(output_hex);

}

