/**
 * Curso: Elementos de Sistemas
 * Arquivo: SymbolTableTest.java
 * Created by Luciano Soares <lpsoares@insper.edu.br> 
 * Date: 16/04/2017
 */

package assembler;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

import assembler.SymbolTable;

public class SymbolTableTest extends TestCase  {

    SymbolTable st = null;

    /**
     * Create the test case
     *
     * @param testName name of the test case
     */
    public SymbolTableTest( String testName ) {
        super( testName );
        st = new SymbolTable();
    }

    /**
     * @return the suite of tests being tested
     */
    public static Test suite() {
        return new TestSuite( SymbolTableTest.class );
    }

    /**
     * Teste verificar símbolos padrões, inserido ao iniciar o sistema
     */
    public void testSymbolTable_iniciais() {

        try {

            assertNotNull("Falha a criar o SymbolTable",st);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R0",st.contains("R0"));
            assertTrue("Verificando se R0 vale 0 na Tabela de Símbolos",st.getAddress("R0")==0);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R1",st.contains("R1"));
            assertTrue("Verificando se R1 vale 1 na Tabela de Símbolos",st.getAddress("R1")==1);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R2",st.contains("R2"));
            assertTrue("Verificando se R2 vale 2 na Tabela de Símbolos",st.getAddress("R2")==2);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R3",st.contains("R3"));
            assertTrue("Verificando se R3 vale 3 na Tabela de Símbolos",st.getAddress("R3")==3);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R4",st.contains("R4"));
            assertTrue("Verificando se R4 vale 4 na Tabela de Símbolos",st.getAddress("R4")==4);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R5",st.contains("R5"));
            assertTrue("Verificando se R5 vale 5 na Tabela de Símbolos",st.getAddress("R5")==5);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R6",st.contains("R6"));
            assertTrue("Verificando se R6 vale 6 na Tabela de Símbolos",st.getAddress("R6")==6);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R7",st.contains("R7"));
            assertTrue("Verificando se R7 vale 7 na Tabela de Símbolos",st.getAddress("R7")==7);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R8",st.contains("R8"));
            assertTrue("Verificando se R8 vale 8 na Tabela de Símbolos",st.getAddress("R8")==8);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R9",st.contains("R9"));
            assertTrue("Verificando se R9 vale 9 na Tabela de Símbolos",st.getAddress("R9")==9);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R10",st.contains("R10"));
            assertTrue("Verificando se R10 vale 10 na Tabela de Símbolos",st.getAddress("R10")==10);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R11",st.contains("R11"));
            assertTrue("Verificando se R11 vale 11 na Tabela de Símbolos",st.getAddress("R11")==11);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R12",st.contains("R12"));
            assertTrue("Verificando se R12 vale 12 na Tabela de Símbolos",st.getAddress("R12")==12);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R13",st.contains("R13"));
            assertTrue("Verificando se R13 vale 13 na Tabela de Símbolos",st.getAddress("R13")==13);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R14",st.contains("R14"));
            assertTrue("Verificando se R14 vale 14 na Tabela de Símbolos",st.getAddress("R14")==14);

            assertTrue("Testando se Tabela de Símbolos CONTÉM R15",st.contains("R15"));
            assertTrue("Verificando se R15 vale 15 na Tabela de Símbolos",st.getAddress("R15")==15);

            assertTrue("Testando se Tabela de Símbolos CONTÉM KBD",st.contains("KBD"));
            assertTrue("Verificando se KBD vale 24576 na Tabela de Símbolos",st.getAddress("KBD")==24576);

            assertTrue("Testando se Tabela de Símbolos CONTÉM SCREEN",st.contains("SCREEN"));
            assertTrue("Verificando se SCREEN vale 16384 na Tabela de Símbolos",st.getAddress("SCREEN")==16384);

            assertTrue("Testando se Tabela de Símbolos CONTÉM SP",st.contains("SP"));
            assertTrue("Verificando se SP vale 0 na Tabela de Símbolos",st.getAddress("SP")==0);

            assertTrue("Testando se Tabela de Símbolos CONTÉM LCL",st.contains("LCL"));
            assertTrue("Verificando se LCL vale 1 na Tabela de Símbolos",st.getAddress("LCL")==1);

            assertTrue("Testando se Tabela de Símbolos CONTÉM ARG",st.contains("ARG"));
            assertTrue("Verificando se ARG vale 2 na Tabela de Símbolos",st.getAddress("ARG")==2);

            assertTrue("Testando se Tabela de Símbolos CONTÉM THIS",st.contains("THIS"));
            assertTrue("Verificando se THIS vale 3 na Tabela de Símbolos",st.getAddress("THIS")==3);

            assertTrue("Testando se Tabela de Símbolos CONTÉM THAT",st.contains("THAT"));
            assertTrue("Verificando se THAT vale 4 na Tabela de Símbolos",st.getAddress("THAT")==4);

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Teste para adicionar e checar se símbolos já inserido
     */
    public void testSymbolTable_adicionados() {

        try {

            assertFalse("Testando se Tabela de Símbolos NÃO contém A",st.contains("A"));
            st.addEntry("A",127);
            assertTrue("Testando se Tabela de Símbolos CONTÉM A",st.contains("A"));
            assertTrue("Verificando se A vale 127 na Tabela de Símbolos",st.getAddress("A")==127);

            assertFalse("Testando se Tabela de Símbolos NÃO contém i",st.contains("i"));
            st.addEntry("i",16);
            assertTrue("Testando se Tabela de Símbolos CONTÉM A",st.contains("i"));
            assertTrue("Verificando se i vale 16 na Tabela de Símbolos",st.getAddress("i")==16);

            assertFalse("Testando se Tabela de Símbolos NÃO contém WxYz",st.contains("WxYz"));
            st.addEntry("WxYz",16383);
            assertTrue("Testando se Tabela de Símbolos CONTÉM WxYz",st.contains("WxYz"));
            assertTrue("Verificando se WxYz vale 16 na Tabela de Símbolos",st.getAddress("WxYz")==16383);

            assertFalse("Testando se Tabela de Símbolos NÃO contém _123",st.contains("_123"));
            st.addEntry("_123",123);
            assertTrue("Testando se Tabela de Símbolos CONTÉM _123",st.contains("_123"));
            assertTrue("Verificando se _123 vale 16 na Tabela de Símbolos",st.getAddress("_123")==123);

            assertFalse("Testando se Tabela de Símbolos NÃO contém LOOP",st.contains("LOOP"));
            st.addEntry("LOOP",0);
            assertTrue("Testando se Tabela de Símbolos CONTÉM LOOP",st.contains("LOOP"));
            assertTrue("Verificando se LOOP vale 16 na Tabela de Símbolos",st.getAddress("LOOP")==0);


        } catch(Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * Teste para adicionar e checar vários símbolos inseridos
     */
    public void testSymbolTable_repetitivo() {

        try {

            for (int i = 0; i < 16384; i++) {
                st.addEntry("TESTE"+i,0);
            }

            for (int i = 0; i < 16384; i++) {
                assertTrue("Testando intensamente Tabela de Símbolos",st.contains("TESTE"+i));
            }

            for (int i = 0; i < 16384; i++) {
                assertTrue("Verificando intensamente existência de Símbolos",st.getAddress("TESTE"+i)==0);
            }

            for (int i = 0; i < 16384; i++) {
                st.addEntry("END"+i,16383);
            }

            for (int i = 0; i < 16384; i++) {
                assertTrue("Testando intensamente Tabela de Símbolos",st.contains("END"+i));
            }

            for (int i = 0; i < 16384; i++) {
                assertTrue("Verificando intensamente existência de Símbolos",st.getAddress("END"+i)==16383);
            }


        } catch(Exception e) {
            e.printStackTrace();
        }

    }


}