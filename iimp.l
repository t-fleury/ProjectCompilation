%{
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include "y.tab.c"
 int fileno(FILE*);
 char* strdup(const char *s);
%}

V [a-zA-Z][a-zA-Z0-9]*
I [1-9][0-9]*

%%
skip  {yylval.string = strdup(yytext);return Sk;}
if  {yylval.string = strdup(yytext);return If;}
then {yylval.string = strdup(yytext);return Th;}
else {yylval.string = strdup(yytext);return El;}
while {yylval.string = strdup(yytext);return Wh;}
do  {yylval.string = strdup(yytext);return Do;}
":="  {yylval.string = strdup(yytext);return Af;}
";" {yylval.string = strdup(yytext);return Se;}
"+" {yylval.string = strdup(yytext);return Pl;}
"-" {yylval.string = strdup(yytext);return Mo;}
"*" {yylval.string = strdup(yytext);return Mu;}
{V} {yylval.string = strdup(yytext);return V;}
0|{I} {yylval.string = strdup(yytext);return I;}
"(" {return Open;}
")" {return Close;}
[\t]+ {;}
[\n]  {;}
. {;}
%%

int yywrap(){return -1;}
