%{
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include "y.tab.c"
 int fileno(FILE*);
 char* strdup(const char *s);
%}

OP (Pl|Mo|Mu|Af|Afc|Sk|Jp|Jz|St)
ET [ET]+[0-9]+
DEST [a-zA-Z]*[0-9]*
ARG [+]*[-]*[0-9]*

%%

{OP} yylval.string = strdup(yytext); return Op;
{ET} yylval.string = strdup(yytext); return Et;
{ARG} yylval.string = strdup(yytext); return Arg;
{DEST} yylval.string = strdup(yytext); return Dest;
":" return Sep;
\n return NLINE;
<<EOF>> return 0;

. {;}
%%

int yywrap(){return -1;}
