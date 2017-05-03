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

    public static String dest(String[] mnemnonic) {
        String instructionMnemonic = mnemonic[0];
        String firstMnemonic = mnemonic[1];
        String secondMnemonic = mnemonic[2];
        String thirdMnemonic = mnemonic[3];

        if (Objects.equals(instructionMnemonic, "jmp") || Objects.equals(instructionMnemonic, "je") ||
                Objects.equals(instructionMnemonic, "jne") || Objects.equals(instructionMnemonic, "jg") ||
                Objects.equals(instructionMnemonic, "jge") || Objects.equals(instructionMnemonic, "jl") ||
                Objects.equals(instructionMnemonic, "jle")){
            return "000";
        }

        // MOVW
        else if (Objects.equals(instructionMnemonic,"movw")){
            if(Objects.equals(secondMnemonic, "%A")){
                return "100";
            }
            else if(Objects.equals(secondMnemonic, "(%A)")){
                return "001";
            }
            else if(Objects.equals(secondMnemonic, "%D")){
                return "010";
            }

        // ADDW
        else if (Objects.equals(instructionMnemonic, "addw")){
            if(Objects.equals(thirdMnemonic, "%A")){
                return "100";
            }
            else if(Objects.equals(thirdMnemonic, "(%A)")){
                return "001";
            }
            else if(Objects.equals(thirdMnemonic, "%D")){
                return "010";
            }
        }

        // SUBW
        else if (Objects.equals(instructionMnemonic, "subw")){
            if(Objects.equals(thirdMnemonic, "%A")){
                return "100";
            }
            else if(Objects.equals(thirdMnemonic, "(%A)")){
                return "001";
            }
            else if(Objects.equals(thirdMnemonic, "%D")){
                return "010";
            }
        } 

        // RSUBW
        else if (Objects.equals(instructionMnemonic, "rsubw")){
            if(Objects.equals(thirdMnemonic, "%A")){
                return "100";
            }
            else if(Objects.equals(thirdMnemonic, "(%A)")){
                return "001";
            }
            else if(Objects.equals(thirdMnemonic, "%D")){
                return "010";
            }
        }

        // INCW
        else if (Objects.equals(instructionMnemonic, "incw")){
            if(Objects.equals(firstMnemonic, "%A")){
                return "100";
            }
            else if(Objects.equals(firstMnemonic, "(%A)")){
                return "001";
            }
            else if(Objects.equals(firstMnemonic, "%D")){
                return "010";
            }
        }

        // DECW
        else if (Objects.equals(instructionMnemonic, "decw")){
            if(Objects.equals(firstMnemonic, "%A")){
                return "100";
            }
            else if(Objects.equals(firstMnemonic, "(%A)")){
                return "001";
            }
            else if(Objects.equals(firstMnemonic, "%D")){
                return "010";
            }
        }

        // NOTW
        else if (Objects.equals(instructionMnemonic, "notw")){
            if(Objects.equals(firstMnemonic, "%A")){
                return "100";
            }
            else if(Objects.equals(firstMnemonic, "(%A)")){
                return "001";
            }
            else if(Objects.equals(firstMnemonic, "%D")){
                return "010";
            }
        }

        // NEGW
        else if (Objects.equals(instructionMnemonic, "negw")){
            if(Objects.equals(firstMnemonic, "%A")){
                return "100";
            }
            else if(Objects.equals(firstMnemonic, "(%A)")){
                return "001";
            }
            else if(Objects.equals(firstMnemonic, "%D")){
                return "010";
            }           
        }

        // ANDW
        else if (Objects.equals(instructionMnemonic, "andw")){
            if(Objects.equals(thirdMnemonic, "%A")){
                return "100";
            }
            else if(Objects.equals(thirdMnemonic, "(%A)")){
                return "001";
            }
            else if(Objects.equals(thirdMnemonic, "%D")){
                return "010";
            }
        }

        // ORW
        else if (Objects.equals(instructionMnemonic, "orw")){
            if(Objects.equals(thirdMnemonic, "%A")){
                return "100";
            }
            else if(Objects.equals(thirdMnemonic, "(%A)")){
                return "001";
            }
            else if(Objects.equals(thirdMnemonic, "%D")){
                return "010";
            }
        }

        // NOP
        else if (Objects.equals(instructionMnemonic, "nop")){
            return "000"; 
        }

            
    }

    // /**
    //  * Retorna o código binário do mnemônico para realizar uma operação de cálculo.
    //  * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
    //  * @return Opcode (String de 7 bits) com código em linguagem de máquina para a instrução.
    //  */
    public static String comp(String[] mnemonic) {
        //CODIGO DO FRED
        //CODIGO DO FRED
        //CODIGO DO FRED
        //CODIGO DO FRED
        //CODIGO DO FRED
    }
    // /**
    //  * Retorna o código binário do mnemônico para realizar uma operação de jump (salto).
    //  * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
    //  * @return Opcode (String de 3 bits) com código em linguagem de máquina para a instrução.
    //  */
    public static String jump(String[] mnemonic) {
        //CODIGO DO FRED
        //CODIGO DO FRED
        //CODIGO DO FRED
        //CODIGO DO FRED
        //CODIGO DO FRED
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
