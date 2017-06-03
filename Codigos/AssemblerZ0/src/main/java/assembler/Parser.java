/**
 * Curso: Elementos de Sistemas
 * Arquivo: Parser.java
 */

package assembler;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Encapsula o código de leitura. Carrega as instruções na linguagem assembly,
 * analisa, e oferece acesso as partes da instrução  (campos e símbolos).
 * Além disso, remove todos os espaços em branco e comentários.
 */
public class Parser {

    /** Enumerator para os tipos de comandos do Assembler. */
    public enum CommandType {
        A_COMMAND,      // comandos LEA, que armazenam no registrador A
        C_COMMAND,      // comandos de calculos
        L_COMMAND       // comandos de Label (símbolos)
    }


    private SymbolTable symbolTable;
    String currentCommand;

    BufferedReader br;

    /**
     * Abre o arquivo de entrada NASM e se prepara para analisá-lo.
     * @param file arquivo NASM que será feito o parser.
     */
    public Parser(String file) {
        symbolTable = new SymbolTable();
        try {
        	System.out.println("Working Directory = " +
                    System.getProperty("user.dir"));

        	//int i = 0;

        	try (BufferedReader br_1p = new BufferedReader(new FileReader(file))) {
        	    String line;
        	    int i = 0;
        	    while ((line = br_1p.readLine()) != null) {

        	    	if (line.indexOf(';') == 0 || line.isEmpty() ){
                        //i += 1;
                    } else if (line.contains(":")){
                    	line = line.split(":")[0];
                    	System.out.println("SS"+line);
                    	if (!symbolTable.contains(line)) {
                            symbolTable.addEntry(line,i);
                            System.out.println("SS"+line);
                        }
                    } else {
                    	i++;
                    }
        	       System.out.println(line);// process the line.
        	    }
        	}

        	br = new BufferedReader(new FileReader(file));


        } catch (Exception e) {
            e.printStackTrace();
        }

        //currentCommand = "";

    }

    /**
     * Carrega uma instrução e avança seu apontador interno para o próxima
     * linha do arquivo de entrada. Caso não haja mais linhas no arquivo de
     * entrada o método retorna "Falso", senão retorna "Verdadeiro".
     * @return Verdadeiro se ainda há instruções, Falso se as instruções terminaram.
     */

    public boolean advance() {

		try {
			currentCommand = br.readLine();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		//System.out.println(currentCommand);

    	if(currentCommand==null){
    		return false;
    	}

		if (currentCommand.trim().isEmpty()){
			return advance();
		}

		if (currentCommand.charAt(0) == ';'){
			return advance();
		}

    	return true;
    }

    /**
     * Retorna o comando "intrução" atual (sem o avanço)
     * @return a instrução atual para ser analilisada
     */
    public String command() {
        return currentCommand;
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

        // Se começa com l, de leaw
        Character first = command.charAt(0);
         if(first == 'l') {
             return CommandType.A_COMMAND;
         }

         // Se termina com :, é um label
         int length = command.length();
         Character last = command.charAt(length - 1);
         if (last == ':') {
           return CommandType.L_COMMAND;
         }
         // Caso seja outro comando
         return CommandType.C_COMMAND;
     }

    /**
     * Retorna o símbolo ou valor numérico da instrução passada no argumento.
     * Deve ser chamado somente quando commandType() é A_COMMAND.
     * @param  command instrução a ser analisada.
     * @return somente o símbolo ou o valor número da instrução.
     */
    public String symbol(String command) {

    	String[] s1 = command.split("\\s");
    	String symbol = s1[1].replace("$", "");
    	symbol = symbol.replace(",%A", "");
    	System.out.println("!"+symbol);
    	return symbol;
    }
    /**
     * Retorna o símbolo da instrução passada no argumento.
     * Deve ser chamado somente quando commandType() é L_COMMAND.
     * @param  command instrução a ser analisada.
     * @return o símbolo da instrução (sem os dois pontos).
     */
    public String label(String command) {
      // Só queremos retornar o comando sem os ':'
      // Checamos pela exisência dos `:`, só para assegurar que está tudo certo
      if (command.indexOf(':') != 0 ){
          return command.replace(":","");
      }
    	return null;
    }
    /**
     * Separa os mnemônicos da instrução fornecida em tokens em um vetor de Strings.
     * Deve ser chamado somente quando CommandType () é C_COMMAND.
     * @param  command instrução a ser analisada.
     * @return um vetor de string contento os tokens da instrução (as partes do comando).
     */
    public String[] instruction(String command) {
      //String[] mnemonicCodes = new String[3];
      String[] mnemonicCodes = command.split(" ");

   	if (mnemonicCodes.length <= 1){
 		return mnemonicCodes;
 	}
 	else {
 		String[] secondParts = mnemonicCodes[1].split(",");
 		List<String> answer = new ArrayList<String>();
 		answer.add(mnemonicCodes[0]);
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
