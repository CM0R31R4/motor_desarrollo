#include <stdio.h>
#include <string.h>

int DecToBase80(char szOut[],char *pcStringIn, int iLenOut)
{
	char	acAuxHex[20], acPaso[20];
	char    acStringOut[100];
	char	*pch, cChar;
	int		i, iLenStr, iRest;
	unsigned long lDecIn=0;
	
	printf("B80 Input =%s LenOut=%i\n\r",pcStringIn,iLenOut);

	pch=pcStringIn;
	memset(acStringOut,0,sizeof(acStringOut));
	memset(acAuxHex,0,sizeof(acAuxHex));
	while (pch!=NULL && *pch==' ') pch++;
	if (pch==NULL || *pch == 0 || *pch<'0' || *pch>'9')
	{
		memset(acPaso,0,sizeof(acPaso));
		for(i=0; i< iLenOut; i++) strcat(acStringOut,"0");
		sprintf(szOut,"%s",acStringOut);
		return 1;
	}

	// pasamos a BASE80
	printf("String out = %s \n\r",acStringOut);

	lDecIn=atol(pch);

	while (lDecIn >0)
	{
		iRest=(int)(lDecIn % 80);
		lDecIn=lDecIn/80;
		if (iRest<=9)
			cChar=(char) (iRest+'0');
		else
		if (iRest>=10 && iRest<=35)
			cChar=(char)(iRest - 10 + 'A');
		else
		if (iRest>=36 && iRest<=61)
			cChar=(char)(iRest - 36 + 'a');
		else
		if (iRest==62)
			cChar='.';
		else
		if (iRest==63)
			cChar=',';
		else
		if (iRest==64)
			cChar=';';
		else
		if (iRest==65)
			cChar=':';
		else
		if (iRest==66)
			cChar='-';
		else
		if (iRest==67)
			cChar='+';
		else
		if (iRest==68)
			cChar='*';
		else
		if (iRest==69)
			cChar='/';
		else
		if (iRest==70)
			cChar='?';
		else
		if (iRest==71)
			cChar='!';
		else
		if (iRest==72)
			cChar='"';
		else
		if (iRest==73)
			cChar='=';
		else
		if (iRest==74)
			cChar='%';
		else
		if (iRest==75)
			cChar='&';
		else
		if (iRest==76)
			cChar='(';
		else
		if (iRest==77)
			cChar=')';
		else
		if (iRest==78)
			cChar='>';
		else
			cChar='<';

		sprintf(acPaso,"%c", cChar);
		strcat(acAuxHex,acPaso);
	}
	for(i=0; i<strlen(acAuxHex); i++)
		acStringOut[i]=acAuxHex[strlen(acAuxHex)-1-i];

	// ajustamos con ceros a la izquierda si es necesario
	iLenStr=strlen(acStringOut);
		
	printf("B80 LenStr=%i %s iLenOut=%i\n\r",iLenStr,acStringOut,iLenOut);

	if (iLenStr < iLenOut )
	{
		memset(acPaso,0, sizeof(acPaso));
		for(i=0; i<(iLenOut - iLenStr); i++) strcat(acPaso,"0");
		memset(acAuxHex,0, sizeof(acAuxHex));
		strcpy(acAuxHex, acStringOut);
		memset(acStringOut,0, sizeof(acStringOut));
		sprintf(acStringOut, "%s%s", acPaso, acAuxHex);
		printf("B80 %s %s %s",acStringOut,acPaso,acAuxHex);
	}
	

	sprintf(szOut,"%s",acStringOut);
	return 1;
}




unsigned long Base80ToDec(char *pcBase80)
{
	int		i;
	unsigned long lDec=0;

	for (i=0; i < strlen(pcBase80); i++)
	{
		lDec *= 80;
		if (pcBase80[i] >= '0' && pcBase80[i] <= '9' )
			lDec += pcBase80[i] - '0';
		else
		if (pcBase80[i] >= 'A' && pcBase80[i] <= 'Z' )
			lDec += pcBase80[i] - 'A' + 10;
		else
		if (pcBase80[i] >= 'a' && pcBase80[i] <= 'z' )
			lDec += pcBase80[i] - 'a' + 36;
		else
		if (pcBase80[i] == '.')
			lDec += 62;
		else
		if (pcBase80[i] == ',')
			lDec += 63;
		else
		if (pcBase80[i] == ';')
			lDec += 64;
		else
		if (pcBase80[i] == ':')
			lDec += 65;
		else
		if (pcBase80[i] == '-')
			lDec += 66;
		else
		if (pcBase80[i] == '+')
			lDec += 67;
		else
		if (pcBase80[i] == '*')
			lDec += 68;
		else
		if (pcBase80[i] == '/')
			lDec += 69;
		else
		if (pcBase80[i] == '?')
			lDec += 70;
		else
		if (pcBase80[i] == '!')
			lDec += 71;
		else
		if (pcBase80[i] == '"')
			lDec += 72;
		else
		if (pcBase80[i] == '=')
			lDec += 73;
		else
		if (pcBase80[i] == '%')
			lDec += 74;
		else
		if (pcBase80[i] == '&')
			lDec += 75;
		else
		if (pcBase80[i] == '(')
			lDec += 76;
		else
		if (pcBase80[i] == ')')
			lDec += 77;
		else
		if (pcBase80[i] == '>')
			lDec += 78;
		else
		if (pcBase80[i] == '<')
			lDec += 79;

	}
	return (lDec);
}

