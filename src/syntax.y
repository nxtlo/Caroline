%{
    #include <stdio.h>
    #include <string.h>
    
    extern char DataType[50];
    extern void yyerror();
    extern int yylex();
    extern char* yytext();
    extern int yylineno();


    void clearBuffers();
    void storeDataType(char*);
    int isDupe(char*, char*);
    void AssignmentErr(char*);
    char* extID(char[]);
    int ValidAssignment(char*);

%}

%define parse.lac full
%define parse.error verbose


%union {
    int intVal; 
    str charVal;
    float floatVal;
    str*    strVal;
    str*    dataType;
}

%token  NOT_EQ  EQ_TO   SINGLE_QUOTES   COMMA   SEMI_COLON  EQUALS
%token  BRACKET_OPEN    BRACKET_CLOSE   CURLY_BRACE_OPEN    CURLY_BRACE_CLOSE   BIG_BRACKET_OPEN    BIG_BRACKET_CLOSE


%token <intVal> INT_VALUE
%token  <charVal>   CHAR_VALUE
%token <floatVal>   FLO_VALUE
%token <strVal> STRING_VALUE

%token <intVal> INT
%token  <floatVal> FLOAT
%token  <strVal>    STRING
%token  <dataType>  DATA_TYPE
%token <strVal> IDENTIFIER  ARRAY_IDENTIFIER


%type <strVal> DECLARATION
%type <strVal> EXPRESSION
%type <strVal> FUNCTION_DECLARATION


%%

DECLARATION :   EXPRESSION  SEMI_COLON                                                              { clearBuffers(); }
            |   FUNCTION_DECLARATION    SEMI_COLON

%%