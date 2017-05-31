/**
 * Curso: Elementos de Sistemas
 * Arquivo: SymbolTable.java
 */

package compiler;

import java.util.*;

import compiler.Symbol.Kind;

/**
 * Mant�m uma tabela com a correspond�ncia entre os nomes das vari�veis e seus detalhes.
 * Os dados salvos s�o o tipo de dado que a vari�vel suporta, o posicionamento no c�digo e
 * o indice num�rico no segmento de mem�ria relacionado.
 * Esta tabela de s�mbolos pode ser usada para armazenar vari�veis no contexto da Classe/objeto,
 * bem como atributos e vari�veis de subrotinas (m�todos, fun��es e construtores).
 */
public class SymbolTable {
	private int contador_static;
	private int contador_field;
	private int contador_arg;
	private int contador_var;
	
	/**
    * Cria uma tabela de s�mbolos vazia.
    */
	Hashtable<String, Symbol> tabela;
    public SymbolTable() {
    	tabela = new Hashtable<String, Symbol>();
    }

    /**
     * Reinicia todos os valores da tabela de s�mbolos, bem como quaisquer 
     * contadores ou outra estrutura de dados que n�o ser�o reusadas em um novo
     * contexto, por exemplo quando se muda para uma nova subrotina.
     */
    public void startSubroutine() {
    	tabela = new Hashtable<String,Symbol>();    
    }

    /**
     * Insere uma entrada na tabela de s�mbolos, sendo essa tabela indexada pelo nome
     * da vari�vel a ser inserida, os dados de type (tipo) e kind (posicionamento) s�o
     * fornecidos, j� o �ndice de segmento de mem�ria � gerado automaticamente nessa rotina.
     * As posicionamentos STATIC e FIELD s�o usados para escopos de classes, enquando 
     * ARG e VAR s�o usados nos escopos de subrotinas.
     * @param  name nome da vari�vel a ser armazenada na tabela de s�mbolos e usada para indexar tabela.
     * @param  type tipo a ser armazenado na tabela de s�mbolos, por exemplo: int, char, ou uma Classe qualquer.
     * @param  kind posicionamento no c�digo da vari�vel a ser armazenado na tabela de s�mbolos, por exemplo: STATIC, ARG.
     * @return valor inteiro do �ndice para segmento de mem�ria criado para a vari�vel.
     */   
    public Integer define(String name, String type, Symbol.Kind kind) {
    	contador_static = 0;
    	contador_field = 0;
    	contador_arg = 0;
    	contador_var = 0;

    	if(kind.equals(Kind.STATIC)){
    		Symbol data = new Symbol(type, kind, contador_static);
    		tabela.put(name, data);
    		contador_static++;
    		return contador_static; 
    	}
    	
    	else if(kind.equals(Kind.FIELD)){
    		Symbol data = new Symbol(type, kind, contador_static);
    		tabela.put(name, data);
    		contador_field++;
    		return contador_field; 
    	}
    	
    	else if(kind.equals(Kind.ARG)){
    		Symbol data = new Symbol(type, kind, contador_static);
    		tabela.put(name, data);
    		contador_arg++;
    		return contador_arg; 
    	}
    	
    	else if(kind.equals(Kind.VAR)){
    		Symbol data = new Symbol(type, kind, contador_static);
    		tabela.put(name, data);
    		contador_var++;
    		return contador_var; 
    	}
    	
        return null;
    }

    /**
     * Informa o n�mero de vari�veis que foram alocadas, conform o posicionamento delas (kind).
     * Quando a tabela � reiniciada, esses valores s�o zerados.
     * @param kind forma de posicionamento de uma vari�vel. Por exemplo: FIELD, VAR, etc.
     * @return quantidade de vari�veis definidas para uma determinada forma de posicionamento (kind).
     */
    public Integer varCount(Symbol.Kind kind) {
        return null;
    }

    /**
     * Retorna o tipo da vari�vel buscada, se a vari�vel n�o for encontrada para o escopo 
     * da tabela de s�mbolos procurada, um valor null deve ser retornado informando que n�o existe na tabela.
     * @param  name nome da vari�vel a ser procurado na tabela de s�mbolos.
     * @return tipo da vari�vel procurada (null caso n�o encontrado).
     */
    public String typeOf(String name) {
    	if (tabela.containsKey(name)){
    		return tabela.get(name).getType();
    	}
        return null;
    }

    /**
     * Retorna a forma de posicionamento (kind) da vari�vel buscada, se a vari�vel n�o for encontrada para o escopo 
     * da tabela de s�mbolos procurada, um valor null deve ser retornado informando que n�o existe na tabela.
     * @param  name nome da vari�vel a ser procurado na tabela de s�mbolos.
     * @return forma de posicionamento (kind) da vari�vel procurada (null caso n�o encontrado).
     */
    public Symbol.Kind kindOf(String name) {
    	if (tabela.containsKey(name)){
    		return tabela.get(name).getKind();
    		}
        return null;
    }

    /**
     * Retorna o �ndice do segmento de mem�ria da vari�vel buscada, se a vari�vel n�o for encontrada para o escopo 
     * da tabela de s�mbolos procurada, um valor null deve ser retornado informando que n�o existe na tabela.
     * @param  name nome da vari�vel a ser procurado na tabela de s�mbolos.
     * @return �ndice do segmento de mem�ria da vari�vel procurada (null caso n�o encontrado).
     */
    public Integer indexOf(String name) {
    	if (tabela.containsKey(name)){
    		return tabela.get(name).getIndex();
    		}
        return null;
    }

}
