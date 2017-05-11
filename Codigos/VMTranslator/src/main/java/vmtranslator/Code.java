/**
 * Curso: Elementos de Sistemas
 * Arquivo: Code.java
 */

package vmtranslator;
import java.io.BufferedWriter;
import java.io.FileWriter;

/** 
 * Traduz da linguagem vm para cÃ³digos assembly.
 */
public class Code {
		private BufferedWriter writer;
    /** 
     * Abre o arquivo de entrada VM e se prepara para analisÃ¡-lo.
     * @param filename nome do arquivo VM que serÃ¡ feito o parser.
     */
    public Code(String filename) {
    	writer = new BufferedWriter(new FileWriter(filename));
    }

    /**
     * Grava no arquivo de saida as instruÃ§Ãµes em Assembly para executar o comando aritmÃ©tico.
     * @param  command comando aritmÃ©tico a ser analisado.
     */
    public void writeArithmetic(String command) {
    	if(command.equals("add")){
    		
    	}
    	
    	else if(command.equals("sub")){
    		
    	}
    	
    	else if(command.equals("neg")){
    		
    	}
    	
    	else if(command.equals("eq")){
    		
    	}
    	
    	else if(command.equals("gt")){
    		
    	}
    	
    	else if(command.equals("lt")){
    		
    	}
    	
    	else if(command.equals("and")){
    		
    	}
    	
    	else if(command.equals("or")){
    		
    	}
    	
    	else if(command.equals("not")){
    		
    	}
    	
	}


    /**
     * Grava no arquivo de saida as instruÃ§Ãµes em Assembly para executar o comando de Push ou Pop.
     * @param  command comando de push ou pop a ser analisado.
     * @param  segment segmento de memÃ³ria a ser usado pelo comando.
     * @param  index Ã­ndice do segkento de memÃ³ria a ser usado pelo comando.
     */
    public void writePushPop(Parser.CommandType command, String segment, Integer index) {
    	if (segment.equals("local")){
    		segment = "1";
    	}
    	if (segment.equals("argument")){
    		segment = "2";
    	}
    	if (segment.equals("this")){
    		segment = "3";
    	}
    	if (segment.equals("that")) {
    		segment = "4";
    	}
    	
    	if(command.equals(CommandType.C_PUSH)){
    		writer.write("leaw $segment , %A"); //Carrega o segmento em A
            writer.write("movw (%A) , %A");  
            for (int i = 0; i<index; i++){ //Index é o lugar dentro do segmento que está o valor a ser PUSHADO
                writer.write("incw %A"); //Incrementa index no valor apontado pelo segmento até o valor a ser PUSHADO
            }
            writer.write("movw (%A) , %D"); //Move o valor a ser PUSHADO para D
            writer.write("leaw $0 , %A"); //Carrega zero em A para indicar o SP
            writer.write("movw (%A) , %A"); 
            writer.write("movw %D , (%A)"); //Move o valor para o topo da pilha (SP)
            writer.write("incw %A"); //Aumenta uma unidade em A para setar o novo SP
            writer.write("movw %A , %D"); 
            writer.write("leaw $0 , %A"); 
            writer.write("movw %D , (%A)"); //Move o novo SP para 0
    	}
    	
    	else if(command.equals(CommandType.C_POP)){
            writer.write("leaw $0, %A"); //Carrega zero em A para indicar o SP
            writer.write("movw (%A) , %D"); 
            writer.write("subw %D , $1 , %D"); //D é o SP - 1
            writer.write("movw %D , (%A)"); //Move o novo SP para 0
            writer.write("movw %D, %A"); //A é o SP onde está o valor a ser popado
            writer.write("movw (%A) , %D"); //Move o valor a ser popado para D
            writer.write("leaw $segment , %A"); //Carrega o segmento de destino em A
            writer.write("movw (%A) , %A");
            for (int i = 0; i<index; i++){ //Index é o lugar dentro do segmento que está o valor a ser POPADO
                writer.write("incw %A"); //Incrementa index no valor apontado pelo segmento até o valor a ser POPADO
            }
            writer.write("movw %D , (%A)"); //Move o valor a ser popado para o local no segmento
        }
    }

    /**
     * Grava no arquivo de saida as instruÃ§Ãµes em Assembly para inicializar o processo da VM (bootstrap).
     * TambÃ©m prepara a chamada para a funÃ§Ã£o Sys.init
     * O cÃ³digo deve ser colocado no inÃ­cio do arquivo de saÃ­da.
     */
    public void writeInit() {

    }

    /**
     * Grava no arquivo de saida as instruÃ§Ãµes em Assembly para gerar o labels (marcadores de jump).
     * @param  label define nome do label (marcador) a ser escrito.
     */
    public void writeLabel(String label) {
    	writer.write(label + ":");
    }

    /**
     * Grava no arquivo de saida as instruÃ§Ãµes em Assembly para gerar as instruÃ§Ãµes de goto (jumps).
     * Realiza um jump incondicional para o label informado.
     * @param  label define jump a ser realizado para um label (marcador).
     */
    public void writeGoto(String label) {
    	writer.write("leaw %" + label + ", %A");
    	writer.write("jne"); //Faz um jump para o endereço armazenado em A
    	writer.write("nop");
    }

    /**
     * Grava no arquivo de saida as instruÃ§Ãµes em Assembly para gerar as instruÃ§Ãµes de goto condicional (jumps condicionais).
     * Realiza um jump condicional para o label informado.
     * @param  label define jump a ser realizado para um label (marcador).
     */
    public void writeIf(String label) {
    	writer.write("leaw %" + label + ", %A");
    	writer.write("jne"); //Faz um jump para o endereço armazenado em A
    	writer.write("nop");
    }

    /**
     * Grava no arquivo de saida as instruÃ§Ãµes em Assembly para uma chamada de funÃ§Ã£o (Call).
     * @param  functionName nome da funÃ§Ã£o a ser "chamada" pelo call.
     * @param  numArgs nÃºmero de argumentos a serem passados na funÃ§Ã£o call.
     */
    public void writeCall(String functionName, Integer numArgs) {
    }

    /**
     * Grava no arquivo de saida as instruÃ§Ãµes em Assembly para o retorno de uma sub rotina.
     */
    public void writeReturn() {

    }

    /**
     * Grava no arquivo de saida as instruÃ§Ãµes em Assembly para a declaraÃ§Ã£o de uma funÃ§Ã£o.
     * @param  functionName nome da funÃ§Ã£o a ser criada.
     * @param  numLocals nÃºmero de argumentos a serem passados na funÃ§Ã£o call.
     */
    public void writeFunction(String functionName, Integer numLocals) {

    }

    /**
     * Armazena o nome do arquivo vm de origem.
     * Usado para definir os dados estÃ¡ticos do cÃ³digo (por arquivo).
     * @param  filename nome do arquivo sendo tratado.
     */
    public void vmfile(String file) {

    }

}
