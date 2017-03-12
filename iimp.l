%{
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include "iimp.tab.c"
 #define NUMBER 0
%}

V [a-zA-Z][0-9]*
I [1-9][0-9]*

%%
skip  {return "Sk";}
if  {return "If";}
then  {return "Th";}
else  {return "El";}
while {return "Wh";}
do  {return "Do";}
:=  {return "Af";}
";" {return "Se";}
"+" {return "Pl";}
"-" {return "Mo";}
"*" {return "Mu";}
{V} {return (V);}
{I} {return (I);}
[\t]+ {;}
[\n]  {;}
. {;}
%%

int yywrap(){return -1;}
