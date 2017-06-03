/**
 * Curso: Elementos de Sistemas
 * Arquivo: Symbol.java
 */

package compiler;

/**
 * Classe que organiza os símbolos usados na tabela de símbolos
 */
public class Symbol {

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

    }

}
