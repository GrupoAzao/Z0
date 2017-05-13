/**
 /**
 * Curso: Elementos de Sistemas
 * Arquivo: AssemblerZ0.java
 */
package assembler;

import assembler.Parser.CommandType;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
/**
 * Classe principal que orquestra execução do Assembler.
 * Opções:
 *   <arquivo nasm>      primeiro parametro é o nome do arquivo nasm a ser aberto
 *   -f <arquivo mif>    parametro indica onde será salvo o arquivo gerado .mif
 */
class AssemblerZ0 {

	public static Parser parser;
	public static Code  code;
	public static SymbolTable symbol_table;
	public int linha;
	public static List<String> list;

	public static void main(String[] args) {
    	parser = new Parser(args[0]);
    	int linha = 0 ;
    	code = new Code();
    	list = new ArrayList<String>();

    	symbol_table = parser.getSymbolTable();
    	PrintWriter writer = null;
    	String command;

    	try{
    	     writer = new PrintWriter(args[2]);
    	} catch (Exception e) {
    	   System.err.println("Algo de errado com o arquivo");
    	}


    	while(parser.advance()){

    		if (parser.commandType(parser.command()) == CommandType.C_COMMAND){
    			linha++;
    			command = (linha-1 + " : " + "111" + Code.comp(parser.instruction(parser.command())) + Code.dest(parser.instruction(parser.command()))+ Code.jump(parser.instruction(parser.command()))+";");
    			if (writer != null){
    			list.add(command);

    		}}
    		else if (parser.commandType(parser.command()) == CommandType.A_COMMAND){
    			linha++;
    			System.out.println(parser.command());

    			try{
    				command= parser.symbol(parser.command());
    			}
    			catch(Exception e){
    				if (symbol_table.contains(parser.symbol(parser.command())) == true){
    					command= Integer.toString(symbol_table.getAddress(parser.symbol(parser.command())));
    				}
    				else {
    					symbol_table.addEntry(parser.symbol(parser.command()), symbol_table.getAddress(parser.symbol(parser.command())));
    					command= Integer.toString(symbol_table.getAddress(parser.symbol(parser.command())));
           				}
    				}

    			if (writer != null){
    				list.add(linha-1 + " : " + "0" + Code.toBinary(command) +";");
    			}
    		}


    	writer.println("WIDTH=16;");
    	writer.println("DEPTH=" + linha +";");
    	writer.println("");
    	writer.println("ADDRESS_RADIX=UNS;");
    	writer.println("DATA_RADIX=BIN;");
    	writer.println("");
    	writer.println("CONTENT BEGIN");
    	for(String str : list) {
    		writer.println(str);
    	}
    	writer.println("");
    	writer.println("END;");
    	if (writer!=null){
    		writer.close();
    	}}}}
