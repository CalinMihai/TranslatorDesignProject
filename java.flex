%{
    import java_cup.runtime.*;
	import java.io.*; 
	import java.util.*; 	
%}

%%

%class Lexer
%unicode
%cup
%line
%column
%public
%implements sym

%{
	StringBuffer string = new StringBuffer();

      private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
      }
      private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
      }
%}

DIGIT	=	[0-9]
ALPHA	=	[a-zA-Z]
ID		=	{ALPHA}[_{DIGIT}{ALPHA}]*
IVAL	=	{DIGIT}+
RVAL	=	{DIGIT}*.{DIGIT}+
BVAL	=	"true" | "false"

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

Multi_line_comment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
Single_line_comment  = "%" {InputCharacter}* {LineTerminator}?


%%

<YYINITIAL> {

	{Multi_line_comment}			{ /* ignore */ }
	{Single_line_comment}			{ /* ignore */ }


	"+"			{ return symbol(sym.ADD); }
	"-" 			{ return symbol(sym.SUB); }
	"*" 			{ return symbol(sym.MUL); }
	"/" 			{ return symbol(sym.DIV); }

	"&&" 			{ return symbol(sym.AND); }
	"||" 			{ return symbol(sym.OR); }
	"not" 			{ return symbol(sym.NOT); }

	"=" 			{ return symbol(sym.EQUAL); }
	"<" 			{ return symbol(sym.LT); }
	">" 			{ return symbol(sym.GT); }
	"=<" 			{ return symbol(sym.LE); }
	">=" 			{ return symbol(sym.GE); }

	":=" 			{ return symbol(sym.ASSIGN); }

	"(" 			{ return symbol(sym.LPAR); }
	")" 			{ return symbol(sym.RPAR); }
	"{" 			{ return symbol(sym.CLPAR); }
	"}" 			{ return symbol(sym.CRPAR); }
	"[" 			{ return symbol(sym.SLPAR); }
	"]" 			{ return symbol(sym.SRPAR); }
	":" 			{ return symbol(sym.COLON); }
	";" 			{ return symbol(sym.SEMICOLON); }
	"," 			{ return symbol(sym.COMMA); }

	"if" 			{ return symbol(sym.IF); }
	"then" 			{ return symbol(sym.THEN); }
	"while" 		{ return symbol(sym.WHILE); }
	"do" 			{ return symbol(sym.DO); }
	"read" 			{ return symbol(sym.READ); }
	"else" 			{ return symbol(sym.ELSE); }
	"begin" 		{ return symbol(sym.BEGIN); }
	"end" 			{ return symbol(sym.END); }
	"print" 		{ return symbol(sym.PRINT); }
	"int" 			{ return symbol(sym.INT); }
	"bool" 			{ return symbol(sym.BOOL); }
	"real" 			{ return symbol(sym.REAL); }
	"var" 			{ return symbol(sym.VAR); }
	"size" 			{ return symbol(sym.SIZE); }
	"float" 		{ return symbol(sym.FLOAT); }
	"floor" 		{ return symbol(sym.FLOOR); }
	"ceil" 			{ return symbol(sym.CEIL); }
	"fun" 			{ return symbol(sym.FUN); }
	"return" 		{ return symbol(sym.RETURN); }
}
