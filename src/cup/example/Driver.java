package cup.example;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.File;
import java.io.IOException;

import java_cup.runtime.*;

class Driver {

	public static void main(String[] args) throws Exception {
		Parser parser = new Parser();
		parser.parse();
 
		//File file = new File("input.txt");
        //FileInputStream fis = null;
        //try {
         //   fis = new FileInputStream(file);
        //} catch (IOException e) {
          //  e.printStackTrace();
        //}
        //Lexer lexer = new Lexer(fis);
        //Symbol s = lexer.next_token();
        //while((s = lexer.next_token()).sym != 0) {
          //  System.out.println("currentSymbol = "+ lexer.yytext());
        //}
      }
	
	
}