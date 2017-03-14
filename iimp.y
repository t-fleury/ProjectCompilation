%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <stdbool.h>
  #include "node.h"
  int yyparse();
  int yylex();
  int yyerror(char*);
%}

%union{
  char *string;
  int integer;
  Node *node;
}
%start run
%token <string> V I Af Sk If Th El Wh Do Se Pl Mo Mu
%type <node> C F E T
%left Af Mu
%left Pl Mo
%left El
%left Se Do

%%
run : C {printNode($1);}
C : V Af E {
  Node *variable = create_Node($1, NULL, NULL);
  $$ = create_Node("Af", variable, $3);}
  | Sk {$$ = create_Node("skip", NULL, NULL);}
  | '(' C ')' {$$ = $2;}
  | If E Th C El C {
    Node *result = create_Node("", $4, $6);
    $$  = create_Node("If", $2, result);
  }
  | Wh E Do C {$$ = create_Node("Wh", $2,$4);}
  | C Se C {$$ = create_Node("Se",$1,$3);}
  ;
E : E Pl T {$$ = create_Node("Pl",$1,$3);}
  | E Mo T {$$ = create_Node("Mo",$1,$3);}
  | T
  ;
T : T Mu F {$$ = create_Node("Mu",$1,$3);}
  | F
  ;
F : '(' E ')' {$$ = $2;}
  | I {$$ = create_Node($1, NULL, NULL);}
  | V {$$ = create_Node($1, NULL, NULL);}
  ;
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
