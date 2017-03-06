%{
 #include <stdio.h>
 #include "iimp.tab.h"
 #define NUMBER 0
%}

%%
:=  {return "Af";}
skip  {return "Sk";}
if  {return "If";}
then  {return "Th";}
else  {return "El";}
while  {return "Wh";}
do  {return "Do";}
;  {return "Se";}
+  {return "Pl";}
-  {return "Mo";}
*  {return "Mu";}
.|\n {return yytext;}
%%

int yywrap(){return -1;}
