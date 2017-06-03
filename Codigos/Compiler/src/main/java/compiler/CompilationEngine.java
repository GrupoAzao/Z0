/**
 * Curso: Elementos de Sistemas
 * Arquivo: CompilationEngine.java
 */

package compiler;

/**
 * Classe principal do compilador que é responsável por dar rítmo no processo de compilação.
 * Essa classe é responsável por instanciar o Tokenizer, VMWrites e SymbolTable.
 * O processo é gerenciado por funções recursivas.
 */
public class CompilationEngine {

	  JackTokenizer jtokenizer;
    VMWriter writer;
    SymbolTable symbolTable;
		void print=System.out.println;
		Symbol symbol;

    /**
     * Construtor da classe, responsável por iniciar/instanciar os objetos do processo.
     * @param inputfilename nome do arquivo Jack que será compilador.
     * @param outputfilename nome do arquivo VM que receberá o código gerado.
     */
    public CompilationEngine(String inputfilename, String outputfilename) {
			symbol = new Symbol();
    	jtokenizer= new JackTokenizer(inputfilename);
        symbolTable= new SymbolTable();
        writer= new VMWriter(outputfilename);
        while(jtokenizer.advance()){
        	if(compareTokenType(JackTokenizer.TokenType.KEYWORD)){
        		if(compareKeywordType(JackTokenizer.KeywordType.CLASS)){
        			compileClass();
        		}
        	}
        }

    }
    public boolean compareTokenType(JackTokenizer.TokenType tokenType ){
    	return jtokenizer.tokenType(jtokenizer.token()).equals(tokenType);
    }

    public boolean compareKeywordType(JackTokenizer.KeywordType keyowrdType ){
    	return jtokenizer.keywordType(jtokenizer.token()).equals(keywordType);
    }

    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir do token "class".
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamdas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  'class' className '{' classVarDec* subroutineDec* '}'
     */
    public void compileClass() {


    	jtokenizer.advance();
			if(!compareTokenType(jtokenizer.tokenType.IDENTIFIER)){
				print("ERROR: expected classname wasn't received");
				return
			}
			//jogar classname pro /symbol table
			jtokenizer.advance();
			if(!compareTokenType(jtokenizer.tokenType.SYMBOL)){
				print("ERROR: expected token "{" wasn't received");
				return
			}
			jtokenizer.advance();
			while(!compareTokenType(jtokenizer.tokenType.SYMBOL)){
				if(!compareTokenType(jtokenizer.tokenType.KEYWORD)
					break;
				if((compareKeywordType(jtokenizer.keywordType.STATIC) || (compareKeywordType(jtokenizer.keywordType.FIELD))){
					compileClassVarDec();
				}
				else if ((compareKeywordType(jtokenizer.keywordType.CONSTRUCTOR) || compareKeywordType(jtokenizer.keywordType.FUNCTION) || compareKeywordType(jtokenizer.keywordType.METHOD)))
					compileSubroutineDec();
			}
    }
}
    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir das declarações da classe.
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamadas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  ('static' | 'field') type varName (',' varName)* ';'
     */
    public void compileClassVarDec() {
				jtokenizer.advance();
				if(!compareTokenType(jtokenizer.tokenType.KEYWORD)){
					break;
				}
				String kind = jtokenizer.token();
				jtokenizer.advance();
				String type = jtokenizer.token();
				jtokenizer.advance();
				while(!jtokenizer.token().equal(';')){
					if(!jtokenizer.token().equal(',')){
						symbolTable.define(jtokenizer.token(), type ,kind.equals('static') ? symbol.Kind.STATIC : symbol.Kind.FIELD );
					}
					jtokenizer.advance();
				}
    }

    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir das subrotinas da classe.
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamadas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  ('constructor' | 'function' | 'method')
     *                         ('void' | type) subroutineName '(' parameterList ')'
     *                         subroutineBody
     */
    public void compileSubroutineDec() {
			jtokenizer.advance();
			if(!compareTokenType(jtokenizer.tokenType.KEYWORD)){
				break;
			}
			if(compareKeywordType(jtokenizer.keywordType.METHOD)){
									//
			}
			if(compareKeywordType(jtokenizer.keywordType.FUNCTION)){

			}
			if(compareKeywordType(jtokenizer.keywordType.CONSTRUCTOR)){

			}

    }

    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir dos parâmetros da subrotina.
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamadas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  ((type varName) (',' type varName)*)?
     */
    public void compileParameterList() {

    }

    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir das declarações da subrotina.
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamadas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  'var' type varName (',' varName)* ';'
     */
    public void compileVarDec() {

    }

    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir do corpo da subrotina.
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamadas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  '{' varDec* statements '}'
     */
    public void compileSubroutineBody() {

    }

    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir da lista de procedimentos da subrotina.
     * As chaves "{" e "}" não são tratadas nessa rotina de compileStatements.
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamadas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  statement*
     */
    public void compileStatements() {

    }

    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir de procedimentos "do".
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamadas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  'do' subroutineCall ';'
     */
    public void compileDo() {

    }

    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir de procedimentos "let".
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamadas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  'let' varName ('[' expression ']')? '=' expression ';'
     */
    public void compileLet() {

    }

    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir de procedimentos "while".
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamadas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  'while' '(' expression ')' '{' statements '}'
     */
    public void compileWhile() {

    }

    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir do "return".
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamadas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  'return' expression? ';'
     */
    public void compileReturn() {

    }

    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir do procedimento "if".
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamadas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  'if' '(' expression ')' '{' statements '}'
     *                         ('else' '{' statements '}')?
     */
    public void compileIf() {

    }

    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir de um expressão.
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamadas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  term (op term)*
     */
    public void compileExpression() {

    }

    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir de uma lista de expressões (possivelmente vazia).
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamadas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  (expression (',' expression)* )?
     */
    public void compileExpressionList() {

    }

    /**
     * Realiza as chamadas recursivas para criar a árvores sintática a partir de um termo encontrado.
     * Essa rotina é mais complexas que as demais e no caso dos identificadores precisa tomar decisões
     * que podem levar a verificar tokens mais a frente.
     * Grava no arquivo de saida as instruções (se necessárias) para as intruções baseado na gramática do Jack.
     * Realiza as chamadas para navegar no arquivo fonte (.jack) avançando nos tokens já consumidos.
     * Respectivas gramática:  integerConstant | stringConstant | keywordConstant | varName | varName '['
     *                         expression ']' | subroutineCall | '(' expression ')' | unaryOp term
     */
    public void compileTerm() {

    }

}
