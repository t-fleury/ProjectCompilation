/* environ.c */
#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "environ.h"
/*---------------------allocation memoire----------------------------*/
char *Idalloc()
{
  return((char *)malloc(MAXIDENT*sizeof(char)));
}
ENV Envalloc()
{
  return((ENV)malloc(sizeof(struct cellenv)));
}

/*-------------------------------------------------------------------*/
/*-----------------------------environnements------------------------*/

/* initialise l'environnement *prho par  var=0    */
/* la chaine var est copiee dans l' environnement */
int initenv(ENV *prho,char *var)
{ENV pos, newcell;
  pos=rech(var,*prho);/* adresse de la cellule contenant var */
  if (pos == NULL)
    /*on insere var en tete de envrnt*/
    {
      newcell=Envalloc();
      newcell->ID=Idalloc();
      strcpy(newcell->ID,var);
      newcell->VAL=0;
      newcell->SUIV=*prho;
      *prho=newcell;
      return (EXIT_SUCCESS);
    }
  else
    {
      return(EXIT_SUCCESS);
    }
}


/* retourne l'adresse de la cellule contenant chaine. NULL si la chaine est absente */
ENV rech(char *chaine, ENV listident){
  if (listident!=NULL){
    if (listident->ID && strcmp(listident->ID,chaine)==0){
      return listident;
    }else{
      return rech(chaine,listident->SUIV);
    }
  }else{
    return NULL;
  }
}

/* affecte val a la variable var , dans rho */
int affect(ENV rho, char *var, int val)
{ENV pos;
  pos=rech(var,rho);/* adresse de la cellule contenant var */
  if (pos != NULL)
    {(pos->VAL)=val;
      return(EXIT_SUCCESS);
    }
  else
    return(EXIT_FAILURE);
}

/* affiche l'environnement */
int ecrire_env(ENV rho)
{ if (rho==NULL)
    {printf("fin d' environnement \n");
      return(EXIT_SUCCESS);}
  else
    {if(rho->ID!=NULL)
        printf("variable %s valeur %d \n",rho->ID,rho->VAL);
      ecrire_env(rho->SUIV);
      return(EXIT_SUCCESS);
    };
}

/* valeur de var dans rho */
int valch(ENV rho, char *var)
{ENV pos;
  pos=rech(var,rho);/* adresse de la cellule contenant var */
  if (pos != NULL)
    return(pos->VAL);
  else
    return(0);
}
