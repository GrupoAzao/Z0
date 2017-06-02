/**
 * Curso: Elementos de Sistemas
 * Arquivo: VMWriter.java
 */

package compiler;

import java.io.*;
import java.nio.charset.StandardCharsets;

/**
 * Encapsula o código para gravar as instruções em Liguagem de Máquina Virtual à Pilha.
 * Responsável por abrir o arquivo para gravar instruções, possui funcionalidades para gravar as instruções.
 */
public class VMWriter {
    private File file;
    private Writer writer;
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
    public VMWriter(File file) throws FileNotFoundException, UnsupportedEncodingException {
        this.file = file;
        this.writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(this.file,true), StandardCharsets.UTF_8));
    }

    private void write(String output) {
        try {
            this.writer.write(output);
            this.writer.write(System.getProperty("line.separator"));
        }
        catch (IOException ex) {
            System.out.print("Error when writing to file");
        }

    }

    /** 
     * Grava um comand "push" no arquivo de instruções VM.
     * Adicionalmente o método tem a possibilidade de retornar a instrução gerada.
     * @param segment código do segmento usado no VMWriter.
     * @param index índice do segmento de memória a ser usado.
     * @return retorna a String do respectivo comando
     */
    public String writePush(Segment segment, Integer index) {
        String segmentString = "";
        if (segment == Segment.CONST){
            segmentString = "constant";
            write("push " + segmentString + " " + index.toString());
        } else if (segment == Segment.ARG){
            segmentString = "argument";
            write("push " + segmentString + " " + index.toString());
        } else if (segment == Segment.LOCAL){
            segmentString = "local";
            write("push " + segmentString + " " + index.toString());
        } else if (segment == Segment.STATIC){
            segmentString = "static";
            write("push " + segmentString + " " + index.toString());
        } else if (segment == Segment.THIS){
            segmentString = "this";
            write("push " + segmentString + " " + index.toString());
        } else if (segment == Segment.THAT){
            segmentString = "that";
            write("push " + segmentString + " " + index.toString());
        } else if (segment == Segment.POINTER){
            segmentString = "pointer";
            write("push " + segmentString + " " + index.toString());
        } else if (segment == Segment.TEMP) {
            segmentString = "temp";
            write("push " + segmentString + " " + index.toString());
        }
        return "push "+ segmentString + " " + index.toString();
    }

    /** 
     * Grava um comand "pop" no arquivo de instruções VM.
     * @param segment código do segmento usado no VMWriter.
     * @param index índice do segmento de memória a ser usado.
     * @return retorna a String do respectivo comando
     */
    public String writePop(Segment segment, Integer index) {
        String segmentString = "";
        if (segment == Segment.CONST){
            segmentString = "constant";
            write("pop " + segmentString + " " + index.toString());
        } else if (segment == Segment.ARG){
            segmentString = "argument";
            write("pop " + segmentString + " " + index.toString());
        } else if (segment == Segment.LOCAL){
            segmentString = "local";
            write("pop " + segmentString + " " + index.toString());
        } else if (segment == Segment.STATIC){
            segmentString = "static";
            write("pop " + segmentString + " " + index.toString());
        } else if (segment == Segment.THIS){
            segmentString = "this";
            write("pop " + segmentString + " " + index.toString());
        } else if (segment == Segment.THAT){
            segmentString = "that";
            write("pop " + segmentString + " " + index.toString());
        } else if (segment == Segment.POINTER){
            segmentString = "pointer";
            write("pop " + segmentString + " " + index.toString());
        } else if (segment == Segment.TEMP) {
            segmentString = "temp";
            write("pop " + segmentString + " " + index.toString());
        }
        return "pop "+ segmentString + " " + index.toString();
    }

    /** 
     * Grava um comand aritmético no arquivo de instruções VM.
     * @param command código da instrução a ser salva em linguagem de VM.
     * @return retorna a String do respectivo comando
     */
    public String writeArithmetic(Command command) {
        String output = command.toString().toLowerCase();
        write(output);
        return output;
    }

    /** 
     * Grava um marcador (Label) no arquivo de instruções VM.
     * @param label nome de marcador a ser usado na linha do arquivo.
     * @return retorna a String do respectivo comando
     */
    public String writeLabel(String label) {
        String output = "label" + " " + label;
        write(output);
        return output;
    }

    /** 
     * Grava uma instrução de goto (incondicional) no arquivo de instruções VM.
     * @param label nome do marcador para onde será realizado o salto de execução.
     * @return retorna a String do respectivo comando
     */
    public String writeGoto(String label) {
        String output = "goto" + " " + label;
        write(output);
        return output;
    }

    /** 
     * Grava uma instrução de if-goto (goto condicional) no arquivo de instruções VM.
     * @param label nome do marcador para onde será realizado o salto de execução caso condição satisfeita.
     * @return retorna a String do respectivo comando
     */
    public String writeIf(String label) {
        String output = "if-goto" + " " + label;
        write(output);
        return output;
    }

    /** 
     * Grava uma instrução call (usada para invocar uma subrotina) no arquivo de instruções VM.
     * @param name nome da subrotina a ser executada.
     * @param nArgs número de argumento que serão passados para a subrotina.
     * @return retorna a String do respectivo comando
     */
    public String writeCall(String name, Integer nArgs) {
        String output = "call" + " " + name + " " + nArgs;
        write(output);
        return output;
    }

    /** 
     * Declara uma função em linguagem VM no arquivo de instruções VM.
     * @param name nome da subrotina a ser criada.
     * @param nLocals número de espaços de memória local que devem ser reservados.
     * @return retorna a String do respectivo comando
     */
    public String writeFunction(String name, Integer nLocals) {
        String output = "function" + " " + name + " " + nLocals;
        write(output);
        return output;
    }

    /** 
     * Grava uma instrução de return no arquivo de instruções VM.
     * @return retorna a String do respectivo comando
     */
    public String writeReturn() {
        String output = "return";
        write(output);
        return output;
    }

    /** 
     * Grava um String, letra por letra, no arquivo de instruções VM.
     * Cada caracter é traduzido para seu código ASCII e colocado na pilha.
     * O módulo de Sistema Operaciona String.appendChar termina a execução.
     * @param text String a ser escrita em linguagem de máquina virtual à pilha.
     * @return retorna o numero de caracteres que foram detectados na String.
     */
    public Integer writeString(String text) {

        writePush(Segment.CONST,text.length());
        writeCall("String.new",1);

        Character[] characters = new Character[text.length()];
        for (int i = 0;i < text.length(); i++){
            characters[i] = text.charAt(i);
            int ascii = (int) characters[i];
            writePush(Segment.CONST,ascii);
            writeCall("String.appendChar",2);
        }
        
//        System.out.println(text.length());
        return text.length();
    }

    /** 
     * Fecha o arquivo de leitura.
     * O arquivo deve ser fechado ao final da gravação, senão dados podem não ser gravados de fato.
     */
    public void close() {
        try {
            this.writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
