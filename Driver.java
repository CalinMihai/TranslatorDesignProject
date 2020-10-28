package cup.example;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;

import java_cup.runtime.*;

class Driver {

	public static void main(String[] args) throws Exception {
		InputStream s = new FileInputStream("input.txt");
        Reader r = new InputStreamReader(s);
        Lexer l = new Lexer(r);
        Symbol currentSymbol = null;
        do{ 
        	currentSymbol = l.next_token();
            System.out.println("currentSymbol ="+ l.yytext());
        }while (currentSymbol.sym != sym.EOF); 
	}
	
}