%{
    void extern yyerror(char *c);
    #include <stdio.h>
    #include <stdlib.h>
%}

%union {int num; char name;}
%start blocks
%token panic
%token println
%token then
%token exit
%token get
%token til
%token <num> INTEGER
%token <char> STRING
%type <num> expr
%type <char> assgin