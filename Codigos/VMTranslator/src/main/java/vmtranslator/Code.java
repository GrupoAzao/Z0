/**
 * Curso: Elementos de Sistemas
 * Arquivo: Code.java
 */

package vmtranslator;

import java.io.PrintWriter;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.FileNotFoundException;
import java.io.IOException;
import assembler.Parser;

/** 
 * Traduz da linguagem vm para códigos assembly.
 */
public class Code {
	private BufferedWriter writer;
	public int globalCounter;

    /** 
     * Abre o arquivo de entrada VM e se prepara para analisá-lo.
     * @param filename nome do arquivo VM que será feito o parser.
     */
    public Code(String filename) {
    	globalCounter = 0;
    	try{
    		writer = new BufferedWriter(new FileWriter(filename));
    	   // writer.close();
    	} catch (FileNotFoundException e) {
    	   System.out.println("deu erro na hora de abrir o arquivo escrever o c�digo assembly");
    	}
    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para executar o comando aritmético.
     * @param  command comando aritmético a ser analisado.
     */
    public void writeArithmetic(String command) {
    	
	    try {	
	    	if (command == 'add' or command == 'sub' or command == 'and' or command =='or'){
		    	writer.write('leaw $SP,%A');
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
	    	}else if (command =='eq'){
	    		writer.write('leaw $SP, %A');
	    		writer.write('movw (%A)');
	    	}else if  (command == 'gt' or command =='lt' or command=='eq'){
	    		writer.write('leaw $SP,%A');
		    	writer.write('decw (%A)');
		    	writer.write('subw $1,(%A),%A');
		    	writer.write('movw (%A),%D');
		    	writer.write("leaw $0,%A");
		    	writer.write('subw (%A),%D,%D');
		    	writer.write('leaw $true,%A');
		    	if(command == 'gt'){
		    		writer.write('jg');
		    	}else if (command == 'lt'){
		    		writer.write('jl');
		    	}else if (command == 'eq'){
		    		writer.write('je');
		    	}
		    	writer.write('nop');
		    	writer.write('leaw $0,%A');
		    	writer.write('movw %A,%D');
		    	writer.write('leaw (%A),%A');
		    	writer.write('movw %D,(%A)');
		    	writer.write('leaw $end,%A');
	    		writer.write('jmp');
	    		writer.write('nop');
	    		writer.write('true:');
	    		writer.write('leaw $1,%A');
	    		writer.write('movw %A,%D');
	    		writer.write('leaw $0,%A');
	    		writer.write('movw (%A),%A');
	    		writer.write('movw %D,(%A)');
	    		writer.write('end:');
	    	}
	    }
	    catch (IOException e) {
            System.out.println("writeArithmetic error");
        }
    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para executar o comando de Push ou Pop.
     * @param  command comando de push ou pop a ser analisado.
     * @param  segment segmento de memória a ser usado pelo comando.
     * @param  index índice do segkento de memória a ser usado pelo comando.
     */
    public void writePushPop(Parser.CommandType command, String segment, Integer index) {
    	try {
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
            if (segment.equals("static")) {
                segment = "16";
            }
            if (segment.equals("constant")) {
                segment = "index";
            }
            
            if(command.equals(CommandType.C_PUSH)){
                writer.write("leaw $" + segment + ", %A"); //Carrega o segmento em A
                writer.write("movw (%A) , %A");  
                for (int i = 0; i<index; i++){ //Index � o lugar dentro do segmento que est� o valor a ser PUSHADO
                    writer.write("incw %A"); //Incrementa index no valor apontado pelo segmento at� o valor a ser PUSHADO
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
                writer.write("leaw $0 , %A"); //Carrega zero em A para indicar o SP
                writer.write("movw (%A) , %D"); 
                writer.write("subw %D , $1 , %D"); //D � o SP - 1
                writer.write("movw %D , (%A)"); //Move o novo SP para 0
                writer.write("movw %D, %A"); //A � o SP onde est� o valor a ser popado
                writer.write("movw (%A) , %D"); //Move o valor a ser popado para D
                writer.write("leaw $" + segment + ", %A"); //Carrega o segmento de destino em A
                writer.write("movw (%A) , %A");
                for (int i = 0; i<index; i++){ //Index � o lugar dentro do segmento que est� o valor a ser POPADO
                    writer.write("incw %A"); //Incrementa index no valor apontado pelo segmento at� o valor a ser POPADO
                }
                writer.write("movw %D , (%A)"); //Move o valor a ser popado para o local no segmento
            }
        }
        catch (IOException e) {
            System.out.println("writePushPop error");
        }

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para inicializar o processo da VM (bootstrap).
     * Também prepara a chamada para a função Sys.init
     * O código deve ser colocado no início do arquivo de saída.
     */
    public void writeInit() {
    	try {
	    	writer.write("leaw $256,%A");
	    	writer.write("movw %A,%D");
	    	writer.write("leaw $0,%A");
	    	writer.write("movw %D,(%A)");
	    	writeCall('System.init',0);
    	}
    	 catch (IOException e) {
             System.out.println("writeInit error");
         }

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para gerar o labels (marcadores de jump).
     * @param  label define nome do label (marcador) a ser escrito.
     */
    public void writeLabel(String label) {
    	 try {
             writer.write(label + ":");
             }
         catch (IOException e) {
             System.out.println("writeLabel error");
         }

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para gerar as instruções de goto (jumps).
     * Realiza um jump incondicional para o label informado.
     * @param  label define jump a ser realizado para um label (marcador).
     */
    public void writeGoto(String label) {
    	try {
            writer.write("leaw $" + label + ", %A");
            writer.write("jmp"); //Faz um jump para o endere�o armazenado em A
            writer.write("nop");
            }
        catch (IOException e) {
            System.out.println("writeGoto error");
        }

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para gerar as instruções de goto condicional (jumps condicionais).
     * Realiza um jump condicional para o label informado.
     * @param  label define jump a ser realizado para um label (marcador).
     */
    public void writeIf(String label) {
    		
    	 try {
             writer.write("leaw $" + label + ", %A");
             writer.write("jne");  //Faz um jump para o endere�o armazenado em A
             writer.write("nop");
             }
         catch (IOException e) {
             System.out.println("writeIf error");
         }
    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para uma chamada de função (Call).
     * @param  functionName nome da função a ser "chamada" pelo call.
     * @param  numArgs número de argumentos a serem passados na função call.
     */
    public void writeCall(String functionName, Integer numArgs) {
	    	try{
	    	 globalCounter += 1;
	    	 writer.write("leaw $return" +functionName + globalCounter.toString() + ", %A"); //Carrega o segmento em A
	         writer.write("movw %A,%D");
	         writer.write("leaw $SP,%A");
	         writer.write("movw (%A),%A");
	         writer.write("movw %D,(%A)");
	         writer.write('leaw $SP,%A');
	         writer.write("incw (%A)");
	    	writePushPop(Parser.CommandType.C_PUSH, 'LCL',0);//push LCL
	    	for(int i = 0;i<numargs;i++){
	    		writePushPop(Parser.CommandType.C_Push,'ARG',i)
	    	}
	    	writePushPop(Parser.CommandType.C_PUSH, 'THIS',0);//push this
	    	writePushPop(Parser.CommandType.C_PUSH, 'THAT',0);//push that
	    	writer.write("leaw $SP,%A");
	    	writer.write("movw (%A),%D");
	    	writer.write("subw $5,%D,%D");
	    	writer.write("subw $" +numArgs.toString()+",%D,%D");
	    	writer.write("leaw $ARG,%A");
	    	writer.write("movw %D,(%A)");
	    	writer.write("leaw $SP,%A");
	    	writer.write("movw %A,%D");
	    	writer.write("leaw $LCL,%A");
	    	writer.write("movw %D,(%A)");
	    	writeGoto(functionName);//goto f
	    	writeLabel(('return' + functionName + globalCounter.toString()));
	    	}
	    	 catch (IOException e) {
	             System.out.println("writeCall error");
	         }
    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para o retorno de uma sub rotina.
     */
    public void writeReturn() {
    	try {
	    	writer.write("leaw $LCL,%A");
	    	writer.write("movw (%A),%D");
	    	writer.write("leaw $R13,%A");
	    	writer.write("movw %D,(%A)");
	    	writer.write('leaw $5,%A');
	    	writer.write('movw %A,%D');
	    	writer.write('leaw $R13,%A);
	    	writer.write('subw (%A),%D,%D');
	    	writer.write('leaw $R15,%A');
	    	writer.write("movw %D,(%A)");
	    	writePushPop(Parser.CommandType.C_POP,'ARG',0);
	    	writer.write("leaw $ARG,%A");
	    	writer.write("movw (%A),%D");
	    	writer.write("movw (%A),%D");
	    	writer.write("addw %D,$1,%D");
	    	writer.write("leaw $SP,%A");
	    	writer.write("movw %D,(%A)");
	    	
	    	writer.write('leaw $1,%A');
	    	writer.write('movw %A,%D');
	    	writer.write('leaw $R13,%A);
	    	writer.write('subw (%A),%D,%D');
	    	writer.write('leaw $THAT,%A');
	    	writer.write("movw %D,(%A)");
	    	
	    	writer.write('leaw $2,%A');
	    	writer.write('movw %A,%D');
	    	writer.write('leaw $R13,%A);
	    	writer.write('subw (%A),%D,%D');
	    	writer.write('leaw $THIS,%A');
	    	writer.write("movw %D,(%A)");
	    	
	    	writer.write('leaw $3,%A');
	    	writer.write('movw %A,%D');
	    	writer.write('leaw $R13,%A');
	    	writer.write('subw (%A),%D,%D');
	    	writer.write('leaw $ARG,%A');
	    	writer.write("movw %D,(%A)");
	    	
	    	writer.write('leaw $4,%A');
	    	writer.write('movw %A,%D');
	    	writer.write('leaw $R13,%A);
	    	writer.write('subw (%A),%D,%D');
	    	writer.write('leaw $LCL,%A');
	    	writer.write("movw %D,(%A)");
	    	
	    	 writer.write("leaw $R15, %A");
	         writer.write("jmp"); //Faz um jump para o endere�o armazenado em A
	         writer.write("nop");
    	}
    	 catch (IOException e) {
             System.out.println("writeReturn error");
         }
	    	
    	
    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para a declaração de uma função.
     * @param  functionName nome da função a ser criada.
     * @param  numLocals número de argumentos a serem passados na função call.
     */
    public void writeFunction (String functionName, Integer numLocals) {
    	try {
    	writeLabel(functionName);
    	for(int i=0;i<numLocals;i++){
    		writePushPop(Parser.CommandType.C_PUSH,'constant',0);
    	}
    	}
    	 catch (IOException e) {
             System.out.println("writeFunction error");
         }
    }

    /**
     * Armazena o nome do arquivo vm de origem.
     * Usado para definir os dados estáticos do código (por arquivo).
     * @param  filename nome do arquivo sendo tratado.
     */
    public void vmfile(String file) {
    	//n�o entendi oq isso aqui faz, certeza que est� errado.
            
         try{
             writer = new BufferedWriter(new FileWriter("codeoutput.nasm"));
         }
         catch (FileNotFoundException e){
             System.out.println(e.getMessage());
         }
    }

}
