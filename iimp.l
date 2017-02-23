%{
 #include <stdio.h>
 #include "iimp.tab.h"
 #define NUMBER 0
%}

%%
Af  {printf(":=");}
Sk  {printf("skip");}
If  {printf("if");}
Th  {printf("then");}
El  {printf("else");}
Wh  {printf("while");}
Do  {printf("do");}
Se  {printf(";");}
Pl  {printf("+");}
Mo  {printf("-");}
Mu  {printf("*");}
.|\n {printf(yytext);}
%%

int yywrap(){return -1;}

int main(){
 int c;
 while((c = yylex()) != '\n'){
   printf("%d\n", c);
 }
 return 0;
}
