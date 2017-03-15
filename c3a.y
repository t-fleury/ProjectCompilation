%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <stdbool.h>
  #include "C3Autils.h"
  int yyparse();
  int yylex();
  int yyerror(char*);
%}

%code requires{
  #include "bilquad.h"
}

%union{
  char *string;
  int integer;
  BILQUAD bQuad;
}
%start run
%token <string> Op Et Arg Dest Sep NLINE
%type <bQuad> C
%type <string> A D

%%
run : C {ecrire_bilquad($1);
  createc3aENV($1);}
C : Et Sep Op Sep A Sep A Sep D NLINE C {
    int operator = 0;
    if(!strcmp($3, "Pl")){
      operator = Pl;
    }else if(!strcmp($3, "Mo")){
      operator = Mo;
    }else if(!strcmp($3, "Mu")){
      operator = Mu;
    }else if(!strcmp($3, "Af")){
      operator = Af;
    }else if(!strcmp($3, "Afc")){
      operator = Afc;
    }else if(!strcmp($3, "Sk")){
      operator = Sk;
    }else if(!strcmp($3, "Jp")){
      operator = Jp;
    }else if(!strcmp($3, "Jz")){
      operator = Jz;
    }else if(!strcmp($3, "St")){
      operator = St;
    }
    QUAD qd = creer_quad($1, operator, $5, $7, $9);
    $$ = creer_bilquad(qd);
    $$ = concatq($$, $11);
  }
  | {$$ = bilquad_vide();}
A : Arg
  | Dest
  | {$$ = "";}
D : Dest
  | Et
  | {$$ = "";}

%%

int yyerror(char *s){
  fprintf(stderr,"*** ERROR : %s\n",s);
  exit(0);
  return 0;
}

int main(int argc, char **argv){
  yyparse();
  return 0;
}
