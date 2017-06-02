/**
 * Curso: Elementos de Sistemas
 * Arquivo: Symbol.java
 */

package compiler;

/**
 * Classe que organiza os símbolos usados na tabela de símbolos
 */
public class Symbol {
	public String type;
    public Kind kind;
    public Integer index;
    	    
    /** Enumerator para os kind. */
    public enum Kind {
        STATIC,
        FIELD, 
        ARG, 
        VAR
    }

    /**
     * Cria um objeto que contem os dados dos símbolos
     */
    public Symbol(String type, Kind kind, Integer index) {
    	this.type = type;
    	this.kind = kind;
    	this.index = index;
    }
    
    public Kind getKind() {
        return kind;
    }
    
    public String getType() {
        return type;
    }
    
    public Integer getIndex() {
        return index;
    }
}
