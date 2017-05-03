/**
 * Curso: Elementos de Sistemas
 * Arquivo: Code.java
 */
package assembler;
import java.util.Objects;
/**
 * Traduz mnemônicos da linguagem assembly para códigos binários da arquitetura Z0.
 */
public class Code {

    private String[] jumpInstructions = {"jmp","je","jne","jg","jge","jl","jle"};
    // /**
    //  * Retorna o código binário do(s) registrador(es) que vão receber o valor da instrução.
    //  * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
    //  * @return Opcode (String de 3 bits) com código em linguagem de máquina para a instrução.
    //

    public static String dest(String[] mnemonic) {
      return null;
    }

    // /**
    //  * Retorna o código binário do mnemônico para realizar uma operação de cálculo.
    //  * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
    //  * @return Opcode (String de 7 bits) com código em linguagem de máquina para a instrução.
    //  */
    public static String comp(String[] mnemonic) {
        System.out.println("Instruction Type: "+mnemonic[0]);
        String instructionMnemonic = mnemonic[0];
        String firstMnemonic = mnemonic[1];
        String secondMnemonic = "";
        if (mnemonic.length == 3){
            secondMnemonic = mnemonic[2];
        }

        if (Objects.equals(instructionMnemonic, "jmp") || Objects.equals(instructionMnemonic, "je") ||
                Objects.equals(instructionMnemonic, "jne") || Objects.equals(instructionMnemonic, "jg") ||
                Objects.equals(instructionMnemonic, "jge") || Objects.equals(instructionMnemonic, "jl") ||
                Objects.equals(instructionMnemonic, "jle")){
            return "0001100";

            // MOVW
        } else if (Objects.equals(instructionMnemonic,"movw")) {
            if (Objects.equals(firstMnemonic, "$0")){
                return "0101010";
            } else if (Objects.equals(firstMnemonic, "$1")){
                return "0111111";
            } else if (Objects.equals(firstMnemonic, "$-1")){
                return "0111010";
            } else if (Objects.equals(firstMnemonic, "%A")){
                return "0110000";
            } else if (Objects.equals(firstMnemonic,"%D")) {
                return "0001100";
            } else if (Objects.equals(firstMnemonic,"(%A)")) {
                return "1110000";
            } else {
                return null;
            }

            // ADDW
        } else if (Objects.equals(instructionMnemonic, "addw")) {
            if (Objects.equals(firstMnemonic, "$0") && Objects.equals(secondMnemonic, "%A") ||
                    Objects.equals(firstMnemonic, "%A") && Objects.equals(secondMnemonic, "$0")){
                return "0110000";
            } else if (Objects.equals(firstMnemonic, "$0") && Objects.equals(secondMnemonic, "%D") ||
                    Objects.equals(firstMnemonic, "%D") && Objects.equals(secondMnemonic, "$0")){
                return "0001100";
            } else if (Objects.equals(firstMnemonic, "$0") && Objects.equals(secondMnemonic, "(%A)") ||
                    Objects.equals(firstMnemonic, "(%A)") && Objects.equals(secondMnemonic, "$0")) {
                return "1110000";


            } else if (Objects.equals(firstMnemonic, "$1") && Objects.equals(secondMnemonic, "%A") ||
                    Objects.equals(firstMnemonic, "%A") && Objects.equals(secondMnemonic, "$1")){
                return "0110111";
            } else if (Objects.equals(firstMnemonic, "$1") && Objects.equals(secondMnemonic, "%D") ||
                    Objects.equals(firstMnemonic, "%D") && Objects.equals(secondMnemonic, "$1")){
                return "0011111";
            } else if (Objects.equals(firstMnemonic, "$1") && Objects.equals(secondMnemonic, "(%A)") ||
                    Objects.equals(firstMnemonic, "(%A)") && Objects.equals(secondMnemonic, "$1")){
                return "1110111";


            } else if (Objects.equals(firstMnemonic, "$-1") && Objects.equals(secondMnemonic, "%A") ||
                    Objects.equals(firstMnemonic, "%A") && Objects.equals(secondMnemonic, "$-1")){
                return "0110010";
            } else if (Objects.equals(firstMnemonic, "$-1") && Objects.equals(secondMnemonic, "%D") ||
                    Objects.equals(firstMnemonic, "%D") && Objects.equals(secondMnemonic, "$-1")){
                return "0001110";
            } else if (Objects.equals(firstMnemonic, "$-1") && Objects.equals(secondMnemonic, "(%A)") ||
                    Objects.equals(firstMnemonic, "(%A)") && Objects.equals(secondMnemonic, "$-1")){
                return "1110010";


            } else if (Objects.equals(firstMnemonic, "%A") && Objects.equals(secondMnemonic, "%D") ||
                    Objects.equals(firstMnemonic, "%D") && Objects.equals(secondMnemonic, "%A")){
                return "0000010";
            } else if (Objects.equals(firstMnemonic,"%D") && Objects.equals(secondMnemonic,"(%A)") ||
                    Objects.equals(firstMnemonic,"(%A)") && Objects.equals(secondMnemonic,"%D")) {
                return "1000010";
            } else {
                return null;
            }

            // SUBW
        } else if (Objects.equals(instructionMnemonic, "subw")){
            if (Objects.equals(firstMnemonic, "%A") && Objects.equals(secondMnemonic, "$1")){
                return "0110010";
            } else if (Objects.equals(firstMnemonic, "%D") && Objects.equals(secondMnemonic, "$1")){
                return "0001110";
            } else if (Objects.equals(firstMnemonic, "(%A)") && Objects.equals(secondMnemonic, "$1")){
                return "1110010";

            } else if (Objects.equals(firstMnemonic, "%D") && Objects.equals(secondMnemonic, "%A")){
                return "0010011";
            } else if (Objects.equals(firstMnemonic, "%A") && Objects.equals(secondMnemonic, "%D")) {
                return "0000111";
            } else if (Objects.equals(firstMnemonic, "%D") && Objects.equals(secondMnemonic, "(%A)")){
                return "1010011";
            } else if (Objects.equals(firstMnemonic, "(%A)") && Objects.equals(secondMnemonic, "%D")){
                return "1000111";
            } else {
                return null;
            }

            // RSUBW
        } else if (Objects.equals(instructionMnemonic, "rsubw")){
            if (Objects.equals(firstMnemonic, "%D") && Objects.equals(secondMnemonic, "%A")){
                return "0000111";
            } else if (Objects.equals(firstMnemonic, "%A") && Objects.equals(secondMnemonic, "%D")) {
                return "0010011";
            } else if (Objects.equals(firstMnemonic, "%D") && Objects.equals(secondMnemonic, "(%A)")){
                return "1000111";
            } else if (Objects.equals(firstMnemonic, "(%A)") && Objects.equals(secondMnemonic, "%D")){
                return "1010011";
            } else {
                return null;
            }

            // INCW
        } else if (Objects.equals(instructionMnemonic, "incw")){
            if (Objects.equals(firstMnemonic, "%A")){
                return "0110111";
            } else if (Objects.equals(firstMnemonic, "%D")){
                return "0011111";
            } else if (Objects.equals(firstMnemonic, "(%A)")){
                return "1110111";
            } else {
                return null;
            }


            // DECW
        } else if (Objects.equals(instructionMnemonic, "decw")){
            if (Objects.equals(firstMnemonic, "%A")){
                return "0110010";
            } else if (Objects.equals(firstMnemonic, "%D")){
                return "0001110";
            } else if (Objects.equals(firstMnemonic, "(%A)")){
                return "1110010";
            } else {
                return null;
            }

            // NOTW
        } else if (Objects.equals(instructionMnemonic, "notw")){
            if (Objects.equals(firstMnemonic, "%A")){
                return "0110001";
            } else if (Objects.equals(firstMnemonic, "%D")){
                return "0001101";
            } else if (Objects.equals(firstMnemonic, "(%A)")){
                return "1110001";
            } else {
                return null;
            }

            // NEGW
        } else if (Objects.equals(instructionMnemonic, "negw")){
            if (Objects.equals(firstMnemonic, "%A")){
                return "0110011";
            } else if (Objects.equals(firstMnemonic, "%D")){
                return "0001111";
            } else if (Objects.equals(firstMnemonic, "(%A)")){
                return "1110011";
            } else {
                return null;
            }

            // ANDW
        } else if (Objects.equals(instructionMnemonic, "andw")){
            if (Objects.equals(firstMnemonic, "%A") && Objects.equals(secondMnemonic, "%D") ||
                    Objects.equals(firstMnemonic, "%D") && Objects.equals(secondMnemonic, "%A")){
                return "0000000";
            } else if (Objects.equals(firstMnemonic, "(%A)") && Objects.equals(secondMnemonic, "%D") ||
                    Objects.equals(firstMnemonic, "%D") && Objects.equals(secondMnemonic, "(%A)")){
                return "1000000";
            } else {
                return null;
            }

            // ORW
        } else if (Objects.equals(instructionMnemonic, "orw")){
            if (Objects.equals(firstMnemonic, "%A") && Objects.equals(secondMnemonic, "%D") ||
                    Objects.equals(firstMnemonic, "%D") && Objects.equals(secondMnemonic, "%A")){
                return "0010101";
            } else if (Objects.equals(firstMnemonic, "(%A)") && Objects.equals(secondMnemonic, "%D") ||
                    Objects.equals(firstMnemonic, "%D") && Objects.equals(secondMnemonic, "(%A)")){
                return "1010101";
            } else {
                return null;
            }

            // NOP
        } else if (Objects.equals(instructionMnemonic, "nop")){
            return "0101010";

            // JUMPS
        } else if (instructionMnemonic.charAt(0) == 'j'){
            return "0001100";
        } else {
            System.out.println("Instrução de cálculo inválida");
            return null;
        }
    }
    // /**
    //  * Retorna o código binário do mnemônico para realizar uma operação de jump (salto).
    //  * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
    //  * @return Opcode (String de 3 bits) com código em linguagem de máquina para a instrução.
    //  */
    public static String jump(String[] mnemonic) {

        String jumpInstruction = "";
        if (mnemonic.length == 1 && !Objects.equals(mnemonic[0], "nop")){
            jumpInstruction = mnemonic[0];
        }

        if (Objects.equals(jumpInstruction, "jmp")){
            return "111";
        } else if (Objects.equals(jumpInstruction, "je")){
            return "010";
        } else if (Objects.equals(jumpInstruction, "jne")){
            return "101";
        } else if (Objects.equals(jumpInstruction, "jg")){
            return "001";
        } else if (Objects.equals(jumpInstruction, "jge")){
            return "011";
        } else if (Objects.equals(jumpInstruction, "jl")){
            return "100";
        } else if (Objects.equals(jumpInstruction, "jle")){
            return "110";
        } else {
            System.out.println("Instrução de jump inválida ou não é uma instrução de jump");
            return null;
        }
    }

    // /**
    //  * Retorna o código binário de um valor decimal armazenado numa String.
    //  * @param  symbol valor numérico decimal armazenado em uma String.
    //  * @return Valor em binário (String de 15 bits) representado com 0s e 1s.
    //  */
    public static String toBinary(String symbol) {
        Integer integer = Integer.parseInt(symbol);
        return Integer.toBinaryString(integer);
    }

}
