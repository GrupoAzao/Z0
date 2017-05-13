/**
 * Curso: Elementos de Sistemas
 * Arquivo: Parser.java
 */

package assembler;

import java.util.ArrayList;
import java.util.List;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * Encapsula o código de leitura. Carrega as instruções na linguagem assembly,
 * analisa, e oferece acesso as partes da instrução  (campos e símbolos).
 * Além disso, remove todos os espaços em branco e comentários.
 */
public class Parser {
    private String current;
    private BufferedReader reader;

    /** Enumerator para os tipos de comandos do Assembler. */
    public enum CommandType {
        A_COMMAND,      // comandos LEA, que armazenam no registrador A
        C_COMMAND,      // comandos de calculos
        L_COMMAND       // comandos de Label (símbolos)
    }

    /**
     * Abre o arquivo de entrada NASM e se prepara para analisá-lo.
     * @param file arquivo NASM que será feito o parser.
     */
    public Parser(String file) {
        current="";
        try{
            reader = new BufferedReader(new FileReader(file));
        }catch (FileNotFoundException e){
            System.out.println(e.getMessage());
        }
        //idealmente o reader deveria ser fechado quando não for mais usado

        //advance();
        //imagino que deva começar carregando minha primeira instrução,
        //mas instruções não são tão claras neste detalhe
    }

    /**
     * Carrega uma instrução e avança seu apontador interno para o próxima
     * linha do arquivo de entrada. Caso não haja mais linhas no arquivo de
     * entrada o método retorna "Falso", senão retorna "Verdadeiro".
     * @return Verdadeiro se ainda há instruções, Falso se as instruções terminaram.
     */
    public boolean advance() {
        boolean isInstruction= false;

        while (!isInstruction && current != null){
            try{
                current= reader.readLine();
            }catch(IOException e){
                System.out.println(e.getMessage());
            }

            if (current != null && !current.trim().isEmpty() && current.charAt(0) != ';'){
                isInstruction= true;
            }
        }

        return isInstruction;
    }

    /**
     * Retorna o comando "intrução" atual (sem o avanço)
     * @return a instrução atual para ser analilisada
     */
    public String command() {

		return current;
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
     	String[] parts = command.split(" ");
     	char last = parts[0].charAt(parts[0].length() - 1);
     	if (parts[0].equals("leaw")){
     		return CommandType.A_COMMAND;
     	}
     	else if (last == ':'){
     		return CommandType.L_COMMAND;
     	}
     	else {
     		return CommandType.C_COMMAND;
     	}

     }

    /**
     * Retorna o símbolo ou valor numérico da instrução passada no argumento.
     * Deve ser chamado somente quando commandType() é A_COMMAND.
     * @param  command instrução a ser analisada.
     * @return somente o símbolo ou o valor número da instrução.
     */
    public String symbol(String command) {
        String[] parts = command.split(" ");
        String symbol= parts[1];
        symbol = symbol.split(",")[0];
        //acho que a vírgula pode ser separada do token por um espaço
        symbol = symbol.substring(1, symbol.length());
        //remove o $ que precede o symbol


		return symbol;
    }

    /**
     * Retorna o símbolo da instrução passada no argumento.
     * Deve ser chamado somente quando commandType() é L_COMMAND.
     * @param  command instrução a ser analisada.
     * @return o símbolo da instrução (sem os dois pontos).
     */
     public String label(String command) {
     	CommandType type = commandType(command);
     	if (type == CommandType.L_COMMAND){
     		String symbol = command.substring(0, command.length() - 1);
     		return symbol;
     	}
     	else{
     		return null;
     	}
     }

    /**
     * Separa os mnemônicos da instrução fornecida em tokens em um vetor de Strings.
     * Deve ser chamado somente quando CommandType () é C_COMMAND.
     * @param  command instrução a ser analisada.
     * @return um vetor de string contento os tokens da instrução (as partes do comando).
     */
     public String[] instruction(String command) {
     	String[] parts = command.split(" ");
     	if (parts.length <= 1){
     		return parts;
     	}
     	else {
     		String[] secondParts = parts[1].split(",");
     		List<String> answer = new ArrayList<String>();
     		answer.add(parts[0]);
     		for(int i = 0; i < secondParts.length; i++){
     			answer.add(secondParts[i]);
     		}
     		String[] instruction = new String[answer.size()];
     		instruction = answer.toArray(instruction);
     		return instruction;

     	}
     }
		 	public SymbolTable getSymbolTable(){
				return symbolTable;
}
}
