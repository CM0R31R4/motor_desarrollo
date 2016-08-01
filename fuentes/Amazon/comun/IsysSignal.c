#include <signal.h>
#include <errno.h>
#include <xml.h>

typedef void Sigfunc(int); 

Sigfunc *Signal(int idsignal, Sigfunc *handler)
{
    struct sigaction iaction,oaction;
    sigset_t     mask;

    iaction.sa_handler = handler;
    sigemptyset(&iaction.sa_mask);
    iaction.sa_flags = 0;

    if (sigaction(idsignal,&iaction,&oaction) < 0) return(SIG_ERR);
    else return(oaction.sa_handler); 
} 

static void TerminaProcesosSig(int idsig)
{
	printf("Activa TerminaProcesosSig %i %i\n\r",idsig,getpid());
	TerminaProcesos();
	exit(0);
}

int InicializaSenales()
{
   if (Signal(SIGUSR1,TerminaProcesosSig)>0)
   {
   }
   Signal(SIGPIPE,SIG_IGN);
   WriteLog(0,"Inicializa Senales");
}
