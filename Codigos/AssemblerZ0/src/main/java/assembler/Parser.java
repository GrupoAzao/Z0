/**
 * Curso: Elementos de Sistemas
 * Arquivo: Parser.java
 */

package assembler;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

/**
 * Encapsula o código de leitura. Carrega as instruções na linguagem assembly,
 * analisa, e oferece acesso as partes da instrução  (campos e símbolos).
 * Além disso, remove todos os espaços em branco e comentários.
 */
public class Parser {
	private String text;
	private SymbolTable st;
	private int Counter;
	private String line;
	private StringBuilder sb;
	private BufferedReader br;
	
    /** Enumerator para os tipos de comandos do Assembler. */
    public enum CommandType {
        A_COMMAND,      // comandos LEA, que armazenam no registrador A
        C_COMMAND,      // comandos de calculos
        L_COMMAND       // comandos de Label (símbolos)
    }

    /** 
     * Abre o arquivo de entrada NASM e se prepara para analisá-lo.
     * @param file arquivo NASM que será feito o parser.
     * @throws IOException 
     */
    public Parser(String file) throws IOException {
        br = new BufferedReader(new FileReader(file));
    	st = new SymbolTable();
    	try {
    		sb = new StringBuilder();
    	   	line = command();
    	    do {
    	    	int coment =  line.indexOf(';');
    	    	if(coment > 0){
    	    		line = line.substring(0, coment-1);
    	    		sb.append(line);

    	    	}else if (coment == -1) {
    	    		if (line.trim().length() > 0){
    	    			sb.append(line);
    	    			
    	    		}
    	    	}
    	    	if (line.contains(":")){
    	    		st.addEntry(this.label(line), Counter);
    	    	}
    	    }  while (advance());
    	    
    	    String everything = sb.toString();
    	    this.text = everything;
    	    
    	} finally {
    	    br.close();
    	}
    }
    

    /**
     * Carrega uma instrução e avança seu apontador interno para o próxima
     * linha do arquivo de entrada. Caso não haja mais linhas no arquivo de
     * entrada o método retorna "Falso", senão retorna "Verdadeiro".
     * @return Verdadeiro se ainda há instruções, Falso se as instruções terminaram.
     * @throws IOException 
     */


    public boolean advance() throws IOException {
    	sb.append(System.lineSeparator());
		line = br.readLine();
		Counter++;
		if(line != null){
			return true;
		}else{
			return false;
		}

    }

    /**
     * Retorna o comando "intrução" atual (sem o avanço)
     * @return a instrução atual para ser analilisada
     * @throws IOException 
     */

    public String command() throws IOException {
    	return br.readLine();

    }

    /**
     * Retorna o tipo da instrução passada no argumento:
     *  A_COMMAND para leaw, por exemplo leaw $1,%A
     *  L_COMMAND para labels, por exemplo Xyz: , onde Xyz é um símbolo.
     *  C_COMMAND para todos os outros comandos
     * @param  command instrução a ser analisada.
     * @return o tipo da instrução.
     */
    public CommandType commandType(String command) {
    	Character first = command.charAt(0); // pega a primeira letra
    	
    	if(first == 'l'){ // se ela for 'l' a instrucao eh leaw
    		return CommandType.A_COMMAND;
    	}	
    	
    	Character last = command.charAt(command.length()-1);
    			
    	if(last == ':'){ 
    		return CommandType.L_COMMAND;
    	}
    	
    	return CommandType.C_COMMAND;

    }

    /**
     * Retorna o símbolo ou valor numérico da instrução passada no argumento.
     * Deve ser chamado somente quando commandType() é A_COMMAND.
     * @param  command instrução a ser analisada.
     * @return somente o símbolo ou o valor número da instrução.
     * leaw $51,%A
     */
    public String symbol(String command) {

    	String[] mnemos = command.split("\\s");
    	String a1 = mnemos[1].replace("$", "");
    	a1 = a1.replace(",%A", "");
    	System.out.println(a1);
    	return a1;

    }

    /**
     * Retorna o símbolo da instrução passada no argumento.
     * Deve ser chamado somente quando commandType() é L_COMMAND.
     * @param  command instrução a ser analisada.
     * @return o símbolo da instrução (sem os dois pontos).
     */
    public String label(String command) {

    	return command.replace(":","");

    }

    /**
     * Separa os mnemônicos da instrução fornecida em tokens em um vetor de Strings.
     * Deve ser chamado somente quando CommandType () é C_COMMAND.
     * @param  command instrução a ser analisada.
     * @return um vetor de string contento os tokens da instrução (as partes do comando).
     */
    public String[] instruction(String command) {
    	String[] quebra1 = command.split("\\s");
    	if(quebra1.length == 1){
    		return quebra1;
    	}
    	String[] quebra2 = quebra1[1].split(",");
    	
    	if(quebra2.length == 1){
    		String[] mnemos = new String[2];
        	mnemos[0]= quebra1[0];
        	mnemos[1] = quebra1[1];   	
        	return mnemos;
    	}
    	
    	if(quebra2.length ==2 ){
    		String[] mnemos = new String[3];
        	mnemos[0]= quebra1[0];
        	mnemos[1]  = quebra2[0];
        	mnemos[2] = quebra2[1];   	
        	return mnemos;
    	}
    	
    	String[] mnemos = new String[4];
    	mnemos[0]= quebra1[0];
    	mnemos[1]  = quebra2[0];
    	mnemos[2] = quebra2[1];
    	mnemos[3] = quebra2[2];
    	return mnemos;
    	

    }

}
