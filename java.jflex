package cup.example;
import java_cup.runtime.*;
import java.io.*; 
import java.util.*; 	
import java_cup.runtime.ComplexSymbolFactory.*;


%%

%class Lexer
%unicode
%cup
%line
%column
%public
%implements sym

%{
	private ComplexSymbolFactory symbolFactory;
	
	public Lexer( ComplexSymbolFactory factory, InputStream in){
	 	 this(new java.io.InputStreamReader(in));
	 	 this.symbolFactory = factory;
	}
	
	StringBuffer string = new StringBuffer();

      private Symbol symbol(int code) {
        int yylen = yylength();
    	Location left = new Location(yyline + 1, yycolumn + 1, yychar);
	    Location right = new Location(yyline + 1, yycolumn + yylen, yychar + yylen);
	    int max_code = sym.terminalNames.length;
	    String name = code < max_code ? sym.terminalNames[code] : "<UNKNOWN(" + yytext() + ")>";
	    return this.symbolFactory.newSymbol(name, code, left, right);

      }
      
      private Symbol symbol(int code, Object value) {
	    int yylen = yylength();
	    Location left = new Location(yyline + 1, yycolumn + 1, yychar);
	    Location right = new Location(yyline + 1, yycolumn + yylen, yychar + yylen);
	    int max_code = sym.terminalNames.length;
	    String name = code < max_code ? sym.terminalNames[code] : "<UNKNOWN(" + yytext() + ")>";
	    return this.symbolFactory.newSymbol(name, code, left, right, value);

      }
      
      private Symbol symbol(String name, int sym, Object val) {
      	Location left = new Location(yyline+1,yycolumn+1,yychar);
      	Location right= new Location(yyline+1,yycolumn+yylength(), yychar+yylength());
      	return symbolFactory.newSymbol(name, sym, left, right,val);
 	 } 
      
%}

DIGIT		=	[0-9]
ALPHA		=	[a-zA-Z]
Identifier	=	[a-zA-Z_0-9]*
IVAL		=	[0-9+]
RVAL		=	[0-9]*.[0-9+]
BVAL		=	"true" | "false"

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

/* comments */
Comment = {TraditionalComment} | {OneLineComment}

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
OneLineComment     = "%" {InputCharacter}* {LineTerminator}?

%eofval{
    return symbol(sym.EOF);
%eofval}

%state CODESEG

%%  

<YYINITIAL> {

  
	{Comment}                      { /* ignore */ }
    {WhiteSpace}                   { /* ignore */ }
    
	
	
	"+"				{ return symbol(sym.ADD); }
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
	
	{Identifier}           { return symbol(sym.ID, yytext()); } 
}
