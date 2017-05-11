/**
 * Curso: Elementos de Sistemas
 * Arquivo: Code.java
 */

package vmtranslator;

import assembler.Parser;

/** 
 * Traduz da linguagem vm para códigos assembly.
 */
public class Code {
	PrintWriter writer;

    /** 
     * Abre o arquivo de entrada VM e se prepara para analisá-lo.
     * @param filename nome do arquivo VM que será feito o parser.
     */
    public Code(String filename) {
    	try{
    	   writer = new PrintWriter("output.txt", "UTF-8");
    	   // writer.close();
    	} catch (IOException e) {
    	   System.out.println("deu erro na hora de abrir o arquivo escrever o c�digo assembly");
    	}
    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para executar o comando aritmético.
     * @param  command comando aritmético a ser analisado.
     */
    public void writeArithmetic(String command) {
    	if (command == 'add' or command == 'sub' or command == 'and' or command =='or'){
	    	writer.write('leaw $0,%A');
	    	writer.write('decw (%A)');
	    	writer.write('subw $1,(%A),%A');
	    	writer.write('movw (%A),%D');
	    	writer.write("leaw $0,%A");
	    	if(command == 'add'){
	    		writer.write('addw %D,(%A),%D');
	    	}else if(command == 'sub'){
	    		writer.write('subw (%A),%D,%D');
	    	}else if (command =='and'){
	    		writer.write('andw %D,(%A),%D');
	    	}else{
	    		writer.write('orw %D,(%A),%D');
	    	}
	    	writer.write('movw %D,(%A)');
    	}
    	else if (command == 'neg'){
    		writer.write("leaw $SP, %A");
    		writer.write("movw (%A), %A");
    		writer.write("decw %A");
    		writer.write("negw (%A)");
    	}else if (command == 'not'){
    		writer.write("leaw $SP, %A");
    		writer.write("movw (%A), %A");
    		writer.write("decw %A");
    		writer.write("notw (%A)");
    	}
    	

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para executar o comando de Push ou Pop.
     * @param  command comando de push ou pop a ser analisado.
     * @param  segment segmento de memória a ser usado pelo comando.
     * @param  index índice do segkento de memória a ser usado pelo comando.
     */
    public void writePushPop(Parser.CommandType command, String segment, Integer index) {

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para inicializar o processo da VM (bootstrap).
     * Também prepara a chamada para a função Sys.init
     * O código deve ser colocado no início do arquivo de saída.
     */
    public void writeInit() {
    	writer.write("leaw $256,%A");
    	writer.write("movw %A,%D");
    	writer.write("leaw $0,%A");
    	writer.write("movw %D,(%A)");
    	//Sys.init ???

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para gerar o labels (marcadores de jump).
     * @param  label define nome do label (marcador) a ser escrito.
     */
    public void writeLabel(String label) {

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para gerar as instruções de goto (jumps).
     * Realiza um jump incondicional para o label informado.
     * @param  label define jump a ser realizado para um label (marcador).
     */
    public void writeGoto(String label) {

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para gerar as instruções de goto condicional (jumps condicionais).
     * Realiza um jump condicional para o label informado.
     * @param  label define jump a ser realizado para um label (marcador).
     */
    public void writeIf(String label) {

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para uma chamada de função (Call).
     * @param  functionName nome da função a ser "chamada" pelo call.
     * @param  numArgs número de argumentos a serem passados na função call.
     */
    public void writeCall(String functionName, Integer numArgs) {
    	writePushPop(Parser.CommandType.C_PUSH, 'return',?);//push retorno
    	writePushPop(Parser.CommandType.C_PUSH, 'local',?);//push LCL
    	for(int i = 0;i<numargs;i++){
    		writePushPop(Parser.CommandType.C_Push,'argument',i)
    	}
    	writePushPop(Parser.CommandType.C_PUSH, 'argument',?);//push ARG
    	writePushPop(Parser.CommandType.C_PUSH, 'this',?);//push this
    	writePushPop(Parser.CommandType.C_PUSH, 'that',?);//push that
    	writer.write("leaw $0,%A");
    	writer.write("movw (%A),%D");
    	writer.write("subw $5,%D,%D");
    	writer.write("subw $" +numArgs.toString()+",%D,%D");
    	writer.write("leaw $argument,%A");
    	writer.write("movw %D,(%A)");
    	writeGoto(functionName);//goto f
    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para o retorno de uma sub rotina.
     */
    public void writeReturn() {

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para a declaração de uma função.
     * @param  functionName nome da função a ser criada.
     * @param  numLocals número de argumentos a serem passados na função call.
     */
    public void writeFunction(String functionName, Integer numLocals) {
    	writeLabel(functionName);
    	for(int i=0;i<numLocals;i++){
    		writePushPop(Parser.CommandType.C_PUSH,'local',i)
    	}
    	writePushPop(Parser.CommandType.C_PUSH,'local','0');
    }

    /**
     * Armazena o nome do arquivo vm de origem.
     * Usado para definir os dados estáticos do código (por arquivo).
     * @param  filename nome do arquivo sendo tratado.
     */
    public void vmfile(String file) {

    }

}
