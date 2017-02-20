%{
  #include <stdio.h>
%}

%start E
%token V I Af Sk If Th El Wh Do Se Sk

%%
E : E '+' T
  | E '-' T
  | T
  ;
T : T '*' F
  | F
  ;
F : '(' E ')'
  | I
  | V
  ;
C : V Af E
  | Sk
  | '(' C ')'
  | If E Th C El C
  | Wh E Do C
  | C Se C
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
