%{
    #include <string.h>
    #include <stdlib.h>
    #include "y.tab.h"
    void extern yyerror(char*);
    void Invalid();

%}

whitespace      [ \t\r\v\f]
linefeed        \n

%%
"int"   |
"float" |
"str"   |
"unsigned int"  |
"unsigned str"  |
"int*"  |
"str*"  |
"float*"                                        {yylval.dataType = strdup(yytext);return DATA_TYPE;}

"!="                                            {return NOT_EQ}
"=="                                            {return EQ_TO;}
"'"                                             {return SINGLE_QUOTES;}
","                                             {return COMMA;}
";"                                             {return SEMI_COLON;}
"="                                             {return EQUALS;}
"("                                             {return BRACKET_OPEN;}
")"                                             {return BRACKET_CLOSE;}
"{"                                             {return CURLY_BRACE_OPEN;}
"}"                                             {return CURLY_BRACE_CLOSE;}
"["                                             {return BIG_BRACKET_OPEN;}
"]"                                             {return BIG_BRACKET_CLOSE;}

[\'][a-zA-Z][\']                                {yylval.charVal = yytext[1];    return CHAR_VALUE;}
[-+]?[0-9]+                                     {yylval.intVal = atoi(yytext);  return INT_VALUE;}
[-+]?[0-9]*\.?[0-9]+                            {yylval.floatVal = atof(yytext); return FLO_VALUE;}

[a-zA-Z][_a-zA-Z0-9]*(\[[0-9]+\])+              {yylval.strVal = strdup(yytext); return ARRAY_IDENTIFIER;}
[a-zA-Z][_a-zA-Z0-9]*                           {yylval.dataType = strdup(yytext); return IDENTIFIER;}


\"(\\.|[^"])*\"                                 {yylval.strVal = strdup(yytext); return STRING_VALUE;}


{linefeed}                                      {yylineno++;}
{whitespace}                                    ;
.                                               {Invalid();}


%%

int yywrap(void){
    return 1;
}

void yyerror(char *s) {
    fprintf(stderr, "\nERROR ON LINE %d : \n %s\n", yylineno, s);
    exit(0);
}

void Invalid(){
    printf("ERROR ON LINE %d : \n Invalid Token %s\n", yylineno,yytext);
    exit(0);
}
