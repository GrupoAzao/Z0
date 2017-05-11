package vmtranslator;
import java.io.BufferedWriter;
import java.io.FileWriter;


public class Code {
		private BufferedWriter writer;
    
    public Code(String filename) {
    	writer = new BufferedWriter(new FileWriter(filename));
    }

    
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

    public void writeInit() {

    }


    public void writeLabel(String label) {
    	writer.write(label + ":");
    }


    public void writeGoto(String label) {
    	writer.write("leaw %" + label + ", %A");
    	writer.write("jne"); //Faz um jump para o endereço armazenado em A
    	writer.write("nop");
    }


    public void writeIf(String label) {
    	writer.write("leaw %" + label + ", %A");
    	writer.write("jne"); //Faz um jump para o endereço armazenado em A
    	writer.write("nop");
    }


    public void writeCall(String functionName, Integer numArgs) {
    	
    }


    public void writeReturn() {

    }


    public void writeFunction(String functionName, Integer numLocals) {

    }


    public void vmfile(String file) {

    }

}
