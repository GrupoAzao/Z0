/**
 * Curso: Elementos de Sistemas
 * Arquivo: TokenizerTest.java
 * Created by Luciano Soares <lpsoares@insper.edu.br> 
 * Date: 2/05/2017
 */

package compiler;

import org.junit.Test;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import compiler.JackTokenizer;

public class TokenizerTest {

	JackTokenizer tokenizerSeven = null;
	JackTokenizer tokenizerComplexArrays = null;

	/**
	 * Create the test case
	 */
	public TokenizerTest() {
		try {
			tokenizerSeven = new JackTokenizer("src/test/resources/Seven/Main.jack");
			tokenizerComplexArrays = new JackTokenizer("src/test/resources/ComplexArrays/Main.jack");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Teste para a parsing de arquivo (Seven/Main.jack) em tokens
	 */
	@Test
	public void testTokenizer_parsingSeven() {

		try {
			org.junit.Assume.assumeTrue( tokenizerSeven.advance() );		// ignora test se não abriu arquivo adequadamente
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue("class",tokenizerSeven.token().equals("class"));
			assertTrue("advance()",tokenizerSeven.advance());
			assertTrue("Main",tokenizerSeven.token().equals("Main"));
			assertTrue("advance()",tokenizerSeven.advance());
			assertTrue("{",tokenizerSeven.token().equals("{"));
			assertTrue("advance()",tokenizerSeven.advance());
			assertTrue("function",tokenizerSeven.token().equals("function"));
			assertTrue("advance()",tokenizerSeven.advance());
			assertTrue("void",tokenizerSeven.token().equals("void"));
			assertTrue("advance()",tokenizerSeven.advance());
			assertTrue("main",tokenizerSeven.token().equals("main"));
			assertTrue("advance()",tokenizerSeven.advance());
			assertTrue("(",tokenizerSeven.token().equals("("));
			assertTrue("advance()",tokenizerSeven.advance());
			assertTrue(")",tokenizerSeven.token().equals(")"));
			assertTrue("advance()",tokenizerSeven.advance());
			assertTrue("{",tokenizerSeven.token().equals("{"));
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}


	/**
	 * Teste para a parsing de arquivo (ComplexArrays/Main.jack) em tokens
	 */
	@Test
	public void testTokenizer_parsingComplexArrays() {

		try {
			org.junit.Assume.assumeTrue( tokenizerComplexArrays.advance() );		// ignora test se não abriu arquivo adequadamente
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue("class",tokenizerComplexArrays.token().equals("class"));
			assertTrue("advance()",tokenizerComplexArrays.advance());
			assertTrue("Main",tokenizerComplexArrays.token().equals("Main"));
			assertTrue("advance()",tokenizerComplexArrays.advance());
			assertTrue("{",tokenizerComplexArrays.token().equals("{"));
			assertTrue("advance()",tokenizerComplexArrays.advance());
			assertTrue("function",tokenizerComplexArrays.token().equals("function"));
			assertTrue("advance()",tokenizerComplexArrays.advance());
			assertTrue("void",tokenizerComplexArrays.token().equals("void"));
			assertTrue("advance()",tokenizerComplexArrays.advance());
			assertTrue("main",tokenizerComplexArrays.token().equals("main"));
			assertTrue("advance()",tokenizerComplexArrays.advance());
			assertTrue("(",tokenizerComplexArrays.token().equals("("));
			assertTrue("advance()",tokenizerComplexArrays.advance());
			assertTrue(")",tokenizerComplexArrays.token().equals(")"));
			assertTrue("advance()",tokenizerComplexArrays.advance());
			assertTrue("{",tokenizerComplexArrays.token().equals("{"));
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * Teste para a instrução tokenType
	 */
	@Test
	public void testTokenizer_tokenType() {

		try {
			org.junit.Assume.assumeNotNull( JackTokenizer.tokenType("class") );		// ignora test se não passou no teste para o keyword "class"
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue("class",JackTokenizer.tokenType("class")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("constructor",JackTokenizer.tokenType("constructor")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("function",JackTokenizer.tokenType("function")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("method",JackTokenizer.tokenType("method")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("field",JackTokenizer.tokenType("field")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("static",JackTokenizer.tokenType("static")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("var",JackTokenizer.tokenType("var")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("int",JackTokenizer.tokenType("int")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("char",JackTokenizer.tokenType("char")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("boolean",JackTokenizer.tokenType("boolean")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("void",JackTokenizer.tokenType("void")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("true",JackTokenizer.tokenType("true")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("false",JackTokenizer.tokenType("false")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("null",JackTokenizer.tokenType("null")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("this",JackTokenizer.tokenType("this")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("let",JackTokenizer.tokenType("let")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("do",JackTokenizer.tokenType("do")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("if",JackTokenizer.tokenType("if")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("else",JackTokenizer.tokenType("else")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("while",JackTokenizer.tokenType("while")==JackTokenizer.TokenType.KEYWORD);
			assertTrue("return",JackTokenizer.tokenType("return")==JackTokenizer.TokenType.KEYWORD);
			
			assertTrue("{",JackTokenizer.tokenType("{")==JackTokenizer.TokenType.SYMBOL);
			assertTrue("}",JackTokenizer.tokenType("}")==JackTokenizer.TokenType.SYMBOL);
			assertTrue("(",JackTokenizer.tokenType("(")==JackTokenizer.TokenType.SYMBOL);
			assertTrue(")",JackTokenizer.tokenType(")")==JackTokenizer.TokenType.SYMBOL);
			assertTrue("[",JackTokenizer.tokenType("[")==JackTokenizer.TokenType.SYMBOL);
			assertTrue("]",JackTokenizer.tokenType("]")==JackTokenizer.TokenType.SYMBOL);
			assertTrue(".",JackTokenizer.tokenType(".")==JackTokenizer.TokenType.SYMBOL);
			assertTrue(",",JackTokenizer.tokenType(",")==JackTokenizer.TokenType.SYMBOL);
			assertTrue(";",JackTokenizer.tokenType(";")==JackTokenizer.TokenType.SYMBOL);
			assertTrue("+",JackTokenizer.tokenType("+")==JackTokenizer.TokenType.SYMBOL);
			assertTrue("-",JackTokenizer.tokenType("-")==JackTokenizer.TokenType.SYMBOL);
			assertTrue("*",JackTokenizer.tokenType("*")==JackTokenizer.TokenType.SYMBOL);
			assertTrue("/",JackTokenizer.tokenType("/")==JackTokenizer.TokenType.SYMBOL);
			assertTrue("&",JackTokenizer.tokenType("&")==JackTokenizer.TokenType.SYMBOL);
			assertTrue("|",JackTokenizer.tokenType("|")==JackTokenizer.TokenType.SYMBOL);
			assertTrue("<",JackTokenizer.tokenType("<")==JackTokenizer.TokenType.SYMBOL);
			assertTrue(">",JackTokenizer.tokenType(">")==JackTokenizer.TokenType.SYMBOL);
			assertTrue("=",JackTokenizer.tokenType("=")==JackTokenizer.TokenType.SYMBOL);
			assertTrue("~",JackTokenizer.tokenType("~")==JackTokenizer.TokenType.SYMBOL);

			assertTrue("1234",JackTokenizer.tokenType("1234")==JackTokenizer.TokenType.INT_CONST);
			assertTrue("1",JackTokenizer.tokenType("1")==JackTokenizer.TokenType.INT_CONST);
			assertTrue("0",JackTokenizer.tokenType("0")==JackTokenizer.TokenType.INT_CONST);
			assertTrue("9999",JackTokenizer.tokenType("9999")==JackTokenizer.TokenType.INT_CONST);
			assertTrue("3476",JackTokenizer.tokenType("3476")==JackTokenizer.TokenType.INT_CONST);

			assertTrue("\"AAAA\"",JackTokenizer.tokenType("\"AAAA\"")==JackTokenizer.TokenType.STRING_CONST);
			assertTrue("\"A B C D\"",JackTokenizer.tokenType("\"A B C D\"")==JackTokenizer.TokenType.STRING_CONST);
			assertTrue("\"X\"",JackTokenizer.tokenType("\"X\"")==JackTokenizer.TokenType.STRING_CONST);
			assertTrue("\"abc cba\"",JackTokenizer.tokenType("\"abc cba\"")==JackTokenizer.TokenType.STRING_CONST);
			assertTrue("\"\"",JackTokenizer.tokenType("\"\"")==JackTokenizer.TokenType.STRING_CONST);
			
			assertTrue("\'AAAA\'",JackTokenizer.tokenType("\'AAAA\'")==JackTokenizer.TokenType.STRING_CONST);
			assertTrue("\'A B C D\'",JackTokenizer.tokenType("\'A B C D\'")==JackTokenizer.TokenType.STRING_CONST);
			assertTrue("\'X\'",JackTokenizer.tokenType("\'X\'")==JackTokenizer.TokenType.STRING_CONST);
			assertTrue("\'abc cba\'",JackTokenizer.tokenType("\'abc cba\'")==JackTokenizer.TokenType.STRING_CONST);
			assertTrue("\'\'",JackTokenizer.tokenType("\'\'")==JackTokenizer.TokenType.STRING_CONST);
			
			assertTrue("a",JackTokenizer.tokenType("a")==JackTokenizer.TokenType.IDENTIFIER);
			assertTrue("nome",JackTokenizer.tokenType("nome")==JackTokenizer.TokenType.IDENTIFIER);
			assertTrue("teste",JackTokenizer.tokenType("teste")==JackTokenizer.TokenType.IDENTIFIER);
			assertTrue("x1",JackTokenizer.tokenType("x1")==JackTokenizer.TokenType.IDENTIFIER);
			assertTrue("x234",JackTokenizer.tokenType("x234")==JackTokenizer.TokenType.IDENTIFIER);
			assertTrue("k_1",JackTokenizer.tokenType("k_1")==JackTokenizer.TokenType.IDENTIFIER);
			assertTrue("K_1",JackTokenizer.tokenType("K_1")==JackTokenizer.TokenType.IDENTIFIER);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * Teste para a instrução keyWord
	 */
	@Test
	public void testTokenizer_keyWord() {

		try {
			org.junit.Assume.assumeNotNull( JackTokenizer.keyWord("class") );		// ignora test se não passou no teste para o keyword "class"
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
						
			assertTrue("class",JackTokenizer.keyWord("class")==JackTokenizer.KeywordType.CLASS);
			assertTrue("constructor",JackTokenizer.keyWord("constructor")==JackTokenizer.KeywordType.CONSTRUCTOR);
			assertTrue("function",JackTokenizer.keyWord("function")==JackTokenizer.KeywordType.FUNCTION);
			assertTrue("method",JackTokenizer.keyWord("method")==JackTokenizer.KeywordType.METHOD);
			assertTrue("field",JackTokenizer.keyWord("field")==JackTokenizer.KeywordType.FIELD);
			assertTrue("static",JackTokenizer.keyWord("static")==JackTokenizer.KeywordType.STATIC);
			assertTrue("var",JackTokenizer.keyWord("var")==JackTokenizer.KeywordType.VAR);
			assertTrue("int",JackTokenizer.keyWord("int")==JackTokenizer.KeywordType.INT);
			assertTrue("char",JackTokenizer.keyWord("char")==JackTokenizer.KeywordType.CHAR);
			assertTrue("boolean",JackTokenizer.keyWord("boolean")==JackTokenizer.KeywordType.BOOLEAN);
			assertTrue("void",JackTokenizer.keyWord("void")==JackTokenizer.KeywordType.VOID);
			assertTrue("true",JackTokenizer.keyWord("true")==JackTokenizer.KeywordType.TRUE);
			assertTrue("false",JackTokenizer.keyWord("false")==JackTokenizer.KeywordType.FALSE);
			assertTrue("null",JackTokenizer.keyWord("null")==JackTokenizer.KeywordType.NULL);
			assertTrue("this",JackTokenizer.keyWord("this")==JackTokenizer.KeywordType.THIS);
			assertTrue("let",JackTokenizer.keyWord("let")==JackTokenizer.KeywordType.LET);
			assertTrue("do",JackTokenizer.keyWord("do")==JackTokenizer.KeywordType.DO);
			assertTrue("if",JackTokenizer.keyWord("if")==JackTokenizer.KeywordType.IF);
			assertTrue("else",JackTokenizer.keyWord("else")==JackTokenizer.KeywordType.ELSE);
			assertTrue("while",JackTokenizer.keyWord("while")==JackTokenizer.KeywordType.WHILE);
			assertTrue("return",JackTokenizer.keyWord("return")==JackTokenizer.KeywordType.RETURN);

		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * Teste para a instrução symbol
	 */
	@Test
	public void testTokenizer_symbol() {

		try {
			org.junit.Assume.assumeNotNull( JackTokenizer.symbol(".") );		// ignora test se não passou no teste para um símbolo "."
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue(".",JackTokenizer.symbol(".")=='.');
			assertTrue("{",JackTokenizer.symbol("{")=='{');
			assertTrue("}",JackTokenizer.symbol("}")=='}');
			assertTrue("(",JackTokenizer.symbol("(")=='(');
			assertTrue(")",JackTokenizer.symbol(")")==')');
			assertTrue("[",JackTokenizer.symbol("[")=='[');
			assertTrue("]",JackTokenizer.symbol("]")==']');
			assertTrue(".",JackTokenizer.symbol(".")=='.');
			assertTrue(",",JackTokenizer.symbol(",")==',');
			assertTrue(";",JackTokenizer.symbol(";")==';');
			assertTrue("+",JackTokenizer.symbol("+")=='+');
			assertTrue("-",JackTokenizer.symbol("-")=='-');
			assertTrue("*",JackTokenizer.symbol("*")=='*');
			assertTrue("/",JackTokenizer.symbol("/")=='/');
			assertTrue("&",JackTokenizer.symbol("&")=='&');
			assertTrue("|",JackTokenizer.symbol("|")=='|');
			assertTrue("<",JackTokenizer.symbol("<")=='<');
			assertTrue(">",JackTokenizer.symbol(">")=='>');
			assertTrue("=",JackTokenizer.symbol("=")=='=');
			assertTrue("~",JackTokenizer.symbol("~")=='~');


		} catch(Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * Teste para a instrução intVal
	 */
	@Test
	public void testTokenizer_intVal() {

		try {
			org.junit.Assume.assumeNotNull( JackTokenizer.intVal("0") );		// ignora test se não passou no teste para o keyword "class"
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue("0",JackTokenizer.intVal("0")==0);
			assertTrue("1",JackTokenizer.intVal("1")==1);
			assertTrue("11",JackTokenizer.intVal("11")==11);
			assertTrue("5396",JackTokenizer.intVal("5396")==5396);
			assertTrue("9999",JackTokenizer.intVal("9999")==9999);
			assertTrue("8888",JackTokenizer.intVal("8888")==8888);

		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * Teste para a instrução stringVal
	 */
	@Test
	public void testTokenizer_stringVal() {

		try {
			org.junit.Assume.assumeNotNull( JackTokenizer.intVal("0") );		// ignora test se não passou no teste para o keyword "class"
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue("\'AAAA\'",JackTokenizer.stringVal("\'AAAA\'").equals("AAAA"));
			assertTrue("\'A B C D\'",JackTokenizer.stringVal("\'A B C D\'").equals("A B C D"));
			assertTrue("\'X\'",JackTokenizer.stringVal("\'X\'").equals("X"));
			assertTrue("\'abc cba\'",JackTokenizer.stringVal("\'abc cba\'").equals("abc cba"));
			assertTrue("\'\'",JackTokenizer.stringVal("\'\'").equals(""));

			assertTrue("\"AAAA\"",JackTokenizer.stringVal("\"AAAA\"").equals("AAAA"));
			assertTrue("\"A B C D\"",JackTokenizer.stringVal("\"A B C D\"").equals("A B C D"));
			assertTrue("\"X\"",JackTokenizer.stringVal("\"X\"").equals("X"));
			assertTrue("\"abc cba\"",JackTokenizer.stringVal("\"abc cba\"").equals("abc cba"));
			assertTrue("\"\"",JackTokenizer.stringVal("\"\"").equals(""));
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}


}
