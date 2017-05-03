/**
 * Curso: Elementos de Sistemas
 * Arquivo: SymbolTable.java
 */

package assembler;

import java.util.Hashtable;

/**
 * Mantém uma tabela com a correspondência entre os rótulos simbólicos e endereços numéricos de memória.
 */
public class SymbolTable {

    /**
     * Cria a tabela de símbolos.
     */
	Hashtable<String, Integer> staticSymbols;
    public SymbolTable() {
		staticSymbols = new Hashtable<String, Integer>();
		
	   staticSymbols.put("R0", 0);
	   staticSymbols.put("R1", 1);
	   staticSymbols.put("R2", 2);
	   staticSymbols.put("R3", 3);
	   staticSymbols.put("R4", 4);
	   staticSymbols.put("R5", 5);
	   staticSymbols.put("R6", 6);
	   staticSymbols.put("R7", 7);
	   staticSymbols.put("R8", 8);
	   staticSymbols.put("R9", 9);
	   staticSymbols.put("R10", 10);
	   staticSymbols.put("R11", 11);
	   staticSymbols.put("R12", 12);
	   staticSymbols.put("R13", 13);
	   staticSymbols.put("R14", 14);
	   staticSymbols.put("R15", 15);
	   staticSymbols.put("SP", 0);
	   staticSymbols.put("LCL", 1);
	   staticSymbols.put("ARG", 2);
	   staticSymbols.put("THIS", 3);
	   staticSymbols.put("THAT", 4);
	   staticSymbols.put("SCREEN", 16384);
	   staticSymbols.put("KBD", 24576 );
    	   
    }

    /**
     * Insere uma entrada de um símbolo com seu endereço numérico na tabela de símbolos.
     * @param  symbol símbolo a ser armazenado na tabela de símbolos.
     * @param  address símbolo a ser armazenado na tabela de símbolos.
     */
    public void addEntry(String symbol, Integer address) {
    	staticSymbols.put(symbol,address);

    }

    /**
     * Confere se o símbolo informado já foi inserido na tabela de símbolos.
     * @param  symbol símbolo a ser procurado na tabela de símbolos.
     * @return Verdadeiro se símbolo está na tabela de símbolos, Falso se não está na tabela de símbolos.
     */
    public boolean contains(String symbol) {
    	if (staticSymbols.containsKey(symbol)){
    		return true;
    	}
    	else{
    		return false;
    	}
    	

    }

    /**
     * Retorna o valor númerico associado a um símbolo já inserido na tabela de símbolos.
     * @param  symbol símbolo a ser procurado na tabela de símbolos.
     * @return valor numérico associado ao símbolo procurado.
     */
    public int getAddress(String symbol) {
    	return staticSymbols.get(symbol);
    }

}
