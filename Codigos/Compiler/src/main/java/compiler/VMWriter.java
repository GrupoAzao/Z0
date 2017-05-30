/**
 * Curso: Elementos de Sistemas
 * Arquivo: VMWriter.java
 */

package compiler;

import java.io.File;

/**
 * Encapsula o código para gravar as instruções em Liguagem de Máquina Virtual à Pilha.
 * Responsável por abrir o arquivo para gravar instruções, possui funcionalidades para gravar as instruções.
 */
public class VMWriter {

    /** Enumerator para os tipos de segmentos de memória do Z0. */
    public enum Segment {
        CONST,
        ARG, 
        LOCAL, 
        STATIC,
        THIS,
        THAT,
        POINTER,
        TEMP
    }

    /** Enumerator para os tipos de instruções aritméticas suportadas pelo Z0. */
    public enum Command {
        ADD,
        SUB, 
        NEG, 
        EQ,
        GT,
        LT,
        AND,
        OR,
        NOT
    }

    /** 
     * Grava instruções no formato de máquina virtual a pilha.
     * @param objeto File para o arquivo onde serão salvas as instruções em VM.
     */
    public VMWriter(File file) {

    }

    /** 
     * Grava um comand "push" no arquivo de instruções VM.
     * Adicionalmente o método tem a possibilidade de retornar a instrução gerada.
     * @param segment código do segmento usado no VMWriter.
     * @param index índice do segmento de memória a ser usado.
     * @return retorna a String do respectivo comando
     */
    public String writePush(Segment segment, Integer index) {
        return null;
    }

    /** 
     * Grava um comand "pop" no arquivo de instruções VM.
     * @param segment código do segmento usado no VMWriter.
     * @param index índice do segmento de memória a ser usado.
     * @return retorna a String do respectivo comando
     */
    public String writePop(Segment segment, Integer index) {
        return null;
    }

    /** 
     * Grava um comand aritmético no arquivo de instruções VM.
     * @param coomand código da instrução a ser salva em linguagem de VM.
     * @return retorna a String do respectivo comando
     */
    public String writeArithmetic(Command command) {
        return null;
    }

    /** 
     * Grava um marcador (Lable) no arquivo de instruções VM.
     * @param label nome de marcador a ser usado na linha do arquivo.
     * @return retorna a String do respectivo comando
     */
    public String writeLabel(String label) {
        return null;
    }

    /** 
     * Grava uma instrução de goto (incondicional) no arquivo de instruções VM.
     * @param label nome do marcador para onde será realizado o salto de execução.
     * @return retorna a String do respectivo comando
     */
    public String writeGoto(String label) {
        return null;
    }

    /** 
     * Grava uma instrução de if-goto (goto condicional) no arquivo de instruções VM.
     * @param label nome do marcador para onde será realizado o salto de execução caso condição satisfeita.
     * @return retorna a String do respectivo comando
     */
    public String writeIf(String label) {
        return null;
    }

    /** 
     * Grava uma instrução call (usada para invocar uma subrotina) no arquivo de instruções VM.
     * @param name nome da subrotina a ser executada.
     * @param nArgs número de argumento que serão passados para a subrotina.
     * @return retorna a String do respectivo comando
     */
    public String writeCall(String name, Integer nArgs) {
        return null;
    }

    /** 
     * Declara uma função em linguagem VM no arquivo de instruções VM.
     * @param name nome da subrotina a ser criada.
     * @param nLocals número de espaços de memória local que devem ser reservados.
     * @return retorna a String do respectivo comando
     */
    public String writeFunction(String name, Integer nLocals) {
        return null;
    }

    /** 
     * Grava uma instrução de return no arquivo de instruções VM.
     * @return retorna a String do respectivo comando
     */
    public String writeReturn() {
        return null;
    }

    /** 
     * Grava um String, letra por letra, no arquivo de instruções VM.
     * Cada caracter é traduzido para seu código ASCII e colocado na pilha.
     * O módulo de Sistema Operaciona String.appendChar termina a execução.
     * @param text String a ser escrita em linguagem de máquina virtual à pilha.
     * @return retorna o numero de caracteres que foram detectados na String.
     */
    public Integer writeString(String text) {
        return null;
    }

    /** 
     * Fecha o arquivo de leitura.
     * O arquivo deve ser fechado ao final da gravação, senão dados podem não ser gravados de fato.
     */
    public void close() {
    
    }

}
