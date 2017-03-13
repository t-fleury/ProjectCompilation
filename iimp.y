%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <stdbool.h>
  int yyparse();
  int yylex();
  char **variablesName;
  int *value;
  int lenght;
  bool ifThEl;

  void createVariable(char *name){
    lenght += 1;
    value = realloc(value, lenght* sizeof(int));
    value[lenght-1] = NULL;
    variablesName = realloc(variablesName, lenght * sizeof(char*));
    variablesName[lenght-1] = realloc(variablesName[lenght-1],(sizeof(name)/sizeof(char)) +1);
    printf("Next to this\n");
    strcpy(variablesName[lenght-1], name);
  }

  int findVariable(char *name){
    for(int i = 0; i < lenght; i++){
      if(!strcmp(variablesName[i],name)){
        return i;
      }
    }
    return -1;
  }
%}

%union{
  char *string;
  int integer;
}
%start C
%token <integer> I
%token <string> V Af Sk If Th El Wh Do Se Pl Mo Mu
%type <integer> E T F
%left Af Mu
%left Pl Mo
%left El
%left Se Do

%%
C : V Af E {
    int i;
    if((i = findVariable($1)) != -1){
      value[i] = $3;
    }else{
      createVariable((char*)$1);
      value[lenght-1] = $3;
    }
  }
  | Sk
  | '(' C ')'
  | If E Th C El C {
    if($2 > 0){
      ifThEl = true;
    }else{
      ifThEl = false;
    }
  }
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
F : '(' E ')' {$$ = $2;}
  | I {}
  | V {findVariable((char*)$1);}
  ;
%%

int yyerror(char *s){
  fprintf(stderr,"*** ERROR : %s\n",s);
  exit(0);
  return 0;
}

int main(int argc, char **argv){
  lenght = 0;
	value = malloc(sizeof(int));
	value[0] = NULL;
	variablesName = malloc(sizeof(char*));
  yyparse();
  for(int i = 0; i < lenght; i++){
		printf("(%s : %i) ", variablesName[i], value[i]);
	}
  printf("\n");
  return 0;
}
