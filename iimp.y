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

  void createVariable(char *variableName){
    lenght += 1;
    value = realloc(value, lenght* sizeof(int));
    value[lenght-1] = 1;
    variablesName = realloc(variablesName, lenght * sizeof(char*));
    variablesName[lenght-1] = realloc(variablesName[lenght-1],sizeof(char) * ((sizeof(variableName) / sizeof(char*))  + 1));
    strcpy(variablesName[lenght-1], variableName);
  }

  int findVariable(char *variableName){
    for(int i = 0; i < lenght; i++){
      if(!strcmp(variablesName[i],variableName)){
        return i;
      }
    }
    createVariable((char*)variableName);
    return -1;
  }
%}

%start C
%token V I Af Sk If Th El Wh Do Se Pl Mo Mu

%%
C : V Af E {
    int i;
    if((i = findVariable((char*)$1)) != -1){
      value[i] = atoi((char*)$2);
    }else{
      value[lenght-1] = atoi((char*)$2);
    }
    printf("%s %s \n", $1,$3);
  }
  | Sk
  | '(' C ')'
  | If E Th C El C {
    if(atoi((char*)$2)> 0){
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
T : T Mu F {printf("%s\n", $2);}
  | F
  ;
F : '(' E ')'
  | I {printf("%d ",$1);}
  | V {printf("%s ",$1);}
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
	value[0] = 0;
	variablesName = malloc(sizeof(char*));
  yyparse();
  for(int i = 0; i < lenght; i++){
		printf("(%s : %i) ", variablesName[i], value[i]);
	}
  return 0;
}
