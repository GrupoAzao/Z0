/**
 * Curso: Elementos de Sistemas
 * Arquivo: Code.java
 */
writepushpop, writelabel, writegoto, writeif
package vmtranslator;

/** 
 * Traduz da linguagem vm para cÃ³digos assembly.
 */
public class Code {

    /** 
     * Abre o arquivo de entrada VM e se prepara para analisÃ¡-lo.
     * @param filename nome do arquivo VM que serÃ¡ feito o parser.
     */
    public Code(String filename) {

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
    	
    	}
    	
    	else if(command.equals(CommandType.C_POP)){
    		
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
