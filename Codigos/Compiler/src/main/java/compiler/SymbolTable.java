/**
 * Curso: Elementos de Sistemas
 * Arquivo: SymbolTable.java
 */

package compiler;

import java.util.*;

/**
 * Mantém uma tabela com a correspondência entre os nomes das variáveis e seus detalhes.
 * Os dados salvos são o tipo de dado que a variável suporta, o posicionamento no código e
 * o indice numérico no segmento de memória relacionado.
 * Esta tabela de símbolos pode ser usada para armazenar variáveis no contexto da Classe/objeto,
 * bem como atributos e variáveis de subrotinas (métodos, funções e construtores).
 */
public class SymbolTable {

    /**
     * Cria uma tabela de símbolos vazia.
     */
    public SymbolTable() {

    }

    /**
     * Reinicia todos os valores da tabela de símbolos, bem como quaisquer 
     * contadores ou outra estrutura de dados que não serão reusadas em um novo
     * contexto, por exemplo quando se muda para uma nova subrotina.
     */
    public void startSubroutine() {
        
    }

    /**
     * Insere uma entrada na tabela de símbolos, sendo essa tabela indexada pelo nome
     * da variável a ser inserida, os dados de type (tipo) e kind (posicionamento) são
     * fornecidos, já o índice de segmento de memória é gerado automaticamente nessa rotina.
     * As posicionamentos STATIC e FIELD são usados para escopos de classes, enquando 
     * ARG e VAR são usados nos escopos de subrotinas.
     * @param  name nome da variável a ser armazenada na tabela de símbolos e usada para indexar tabela.
     * @param  type tipo a ser armazenado na tabela de símbolos, por exemplo: int, char, ou uma Classe qualquer.
     * @param  kind posicionamento no código da variável a ser armazenado na tabela de símbolos, por exemplo: STATIC, ARG.
     * @return valor inteiro do índice para segmento de memória criado para a variável.
     */    
    public Integer define(String name, String type, Symbol.Kind kind) {
        return null;
    }

    /**
     * Informa o número de variáveis que foram alocadas, conform o posicionamento delas (kind).
     * Quando a tabela é reiniciada, esses valores são zerados.
     * @param kind forma de posicionamento de uma variável. Por exemplo: FIELD, VAR, etc.
     * @return quantidade de variáveis definidas para uma determinada forma de posicionamento (kind).
     */
    public Integer varCount(Symbol.Kind kind) {
        return null;
    }

    /**
     * Retorna o tipo da variável buscada, se a variável não for encontrada para o escopo 
     * da tabela de símbolos procurada, um valor null deve ser retornado informando que não existe na tabela.
     * @param  name nome da variável a ser procurado na tabela de símbolos.
     * @return tipo da variável procurada (null caso não encontrado).
     */
    public String typeOf(String name) {
        return null;
    }

    /**
     * Retorna a forma de posicionamento (kind) da variável buscada, se a variável não for encontrada para o escopo 
     * da tabela de símbolos procurada, um valor null deve ser retornado informando que não existe na tabela.
     * @param  name nome da variável a ser procurado na tabela de símbolos.
     * @return forma de posicionamento (kind) da variável procurada (null caso não encontrado).
     */
    public Symbol.Kind kindOf(String name) {
        return null;
    }

    /**
     * Retorna o índice do segmento de memória da variável buscada, se a variável não for encontrada para o escopo 
     * da tabela de símbolos procurada, um valor null deve ser retornado informando que não existe na tabela.
     * @param  name nome da variável a ser procurado na tabela de símbolos.
     * @return índice do segmento de memória da variável procurada (null caso não encontrado).
     */
    public Integer indexOf(String name) {
        return null;
    }

}
