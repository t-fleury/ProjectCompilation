%{
  #include <stdio.h>
%}

%start C
%token V I Af Sk If Th El Wh Do Se Pl Mo Mu

%%
C : V Af E
  | Sk
  | '(' C ')'
  | If E Th C El C
  | Wh E Do C
  | C Se C
  ;
E : E Pl T
  | E Mo T
  | T
  ;
T : T Mu F
  | F
  ;
F : '(' E ')'
  | I
  | V
  ;
%%

int yyerror(char *s){
  fprintf(stderr,"*** ERROR : %s\n",s);
  exit(0);
  return 0;
}

int main(int argc, char **argv){
  yyparse();
  printf("Test passed\n");
  return 0;
}
