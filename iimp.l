%{
 #include <stdio.h>
 
 #define NUMBER 0
%}

%%
[0-9]+ {return NUMBER;}
.|\n {return yytext[0];}
%%

int yywrap(){return -1;}

int main(){
 int c;
 while((c = yylex()) != '\n'){
   printf("%d\n", c);
 }
 return 0;
}
