#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "IMPutils.h"
#include "environ.h"
#include "bilquad.h"
#include <stdbool.h>

int eval(char *op, int arg1, int arg2)
{
  if(!strcmp("Pl", op)){
      return(arg1 + arg2);
  }else if(!strcmp("Mo", op)){
      return(arg1 - arg2);
  }else if(!strcmp("Mu", op)){
      return(arg1 * arg2);
  }
  return(0);
}

void createc3aENV(BILQUAD list){
  ENV env = Envalloc();
  QUAD line = list.debut;
  while(line != NULL && line->OP != St){
    switch(line->OP){
      case(Af):{
          initenv(&env, line->ARG1);
          initenv(&env, line->ARG2);
          affect(env, line->ARG1, valch(env, line->ARG2));
          line = line->SUIV;
          break;
        }
        case(Sk):{
          line = line->SUIV;
          break;
        }
        case(Pl):{
          initenv(&env, line->RES);
          initenv(&env, line->ARG1);
          initenv(&env, line->ARG2);
          int res = eval("Pl", valch(env, line->ARG1), valch(env, line->ARG2));
          affect(env, line->RES, res);
          line = line->SUIV;
          break;
        }
        case(Mo):{
          initenv(&env, line->RES);
          initenv(&env, line->ARG1);
          initenv(&env, line->ARG2);
          int res = eval("Mo", valch(env, line->ARG1), valch(env, line->ARG2));
          affect(env, line->RES, res);
          line = line->SUIV;
          break;
        }
        case(Mu):{
          initenv(&env, line->RES);
          initenv(&env, line->ARG1);
          initenv(&env, line->ARG2);
          int res = eval("Mu", valch(env, line->ARG1), valch(env, line->ARG2));
          affect(env, line->RES, res);
          line = line->SUIV;
          break;
        }
        case(Afc):{
          initenv(&env, line->RES);
          affect(env, line->RES, atoi(line->ARG1));
          line = line->SUIV;
          break;
        }
        case(Jp):{
          QUAD listStart = list.debut;
          char *dest = line->RES;
          while (strcmp(listStart->ETIQ,dest) != 0)
            listStart = listStart->SUIV;
          line=listStart;
          break;
        }
        case(Jz):{
          QUAD listStart = list.debut;
          char *dest = line->RES;
          if(valch(env, line->ARG1) == 0){
            while (strcmp(listStart->ETIQ,dest) != 0){
              listStart = listStart->SUIV;
            }
            line=listStart;
          } else {
            line = line->SUIV;
          }
          break;
        }
      };
  }
  ecrire_env((ENV)env);
}
