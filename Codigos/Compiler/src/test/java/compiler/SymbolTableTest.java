/**
 * Curso: Elementos de Sistemas
 * Arquivo: SymbolTableTest.java
 * Created by Luciano Soares <lpsoares@insper.edu.br> 
 * Date: 12/05/2017
 */

package compiler;

import org.junit.Test;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import compiler.SymbolTable;

public class SymbolTableTest {

    SymbolTable table = null;

    /**
     * Create the test case
     */
    public SymbolTableTest() {
        table = new SymbolTable();
    }

    /**
     * Teste verificar símbolos são criados na ordem cera e o startSubroutine está funcionando.
     */
    @Test
    public void testSymbolTable_define_startSubroutine() {

        assertNotNull("Falha a criar o SymbolTable",table);

        try {
        	org.junit.Assume.assumeNotNull( table.define("X","int",Symbol.Kind.ARG) );  // ignora test
        } catch(Exception e) { 
        	org.junit.Assume.assumeNoException(e);
        }
        
        try {

            table.startSubroutine();

            assertTrue("define X int ARG == 0",table.define("X","int",Symbol.Kind.ARG)==0);
            assertTrue("define Y int ARG == 1",table.define("Y","int",Symbol.Kind.ARG)==1);
            assertTrue("define Z int ARG == 2",table.define("Z","int",Symbol.Kind.ARG)==2);

            table.startSubroutine();
            
            assertTrue("define A int ARG == 0",table.define("A","int",Symbol.Kind.ARG)==0);
            assertTrue("define B int ARG == 1",table.define("B","int",Symbol.Kind.ARG)==1);
            assertTrue("define C int ARG == 2",table.define("C","int",Symbol.Kind.ARG)==2);

            table.startSubroutine();

            assertTrue("define r char VAR == 0",table.define("r","char",Symbol.Kind.VAR)==0);
            assertTrue("define s char VAR == 1",table.define("s","char",Symbol.Kind.VAR)==1);
            assertTrue("define t char VAR == 2",table.define("t","char",Symbol.Kind.VAR)==2);

            table.startSubroutine();
            
            assertTrue("define d char VAR == 0",table.define("d","char",Symbol.Kind.VAR)==0);
            assertTrue("define e char VAR == 1",table.define("e","char",Symbol.Kind.VAR)==1);
            assertTrue("define f char VAR == 2",table.define("f","char",Symbol.Kind.VAR)==2);


        } catch(Exception e) {
            e.printStackTrace();
        }
    }



    /**
     * Teste verificar a contagem de variaveis de um tipo na tabela.
     */
    @Test
    public void testSymbolTable_varCount() {

        assertNotNull("Falha a criar o SymbolTable",table);

        try {
            org.junit.Assume.assumeNotNull( table.define("X","int",Symbol.Kind.ARG) );  // ignora test
        } catch(Exception e) { 
            org.junit.Assume.assumeNoException(e);
        }
        
        try {

            table.startSubroutine();

            assertTrue("define X int ARG == 0",table.define("X","int",Symbol.Kind.ARG)==0);
            assertTrue("define Y int ARG == 1",table.define("Y","int",Symbol.Kind.ARG)==1);
            assertTrue("define Z int ARG == 2",table.define("Z","int",Symbol.Kind.ARG)==2);

            assertTrue("varCount STATIC",table.varCount(Symbol.Kind.STATIC) ==0);
            assertTrue("varCount FIELD" ,table.varCount(Symbol.Kind.FIELD)  ==0);
            assertTrue("varCount ARG"   ,table.varCount(Symbol.Kind.ARG)    ==3);
            assertTrue("varCount VAR"   ,table.varCount(Symbol.Kind.VAR)    ==0);

            assertTrue("define A int ARG == 3",table.define("A","int",Symbol.Kind.ARG)==3);
            assertTrue("define B int ARG == 4",table.define("B","int",Symbol.Kind.ARG)==4);
            assertTrue("define C int ARG == 5",table.define("C","int",Symbol.Kind.ARG)==5);

            assertTrue("varCount STATIC",table.varCount(Symbol.Kind.STATIC) ==0);
            assertTrue("varCount FIELD" ,table.varCount(Symbol.Kind.FIELD)  ==0);
            assertTrue("varCount ARG"   ,table.varCount(Symbol.Kind.ARG)    ==6);
            assertTrue("varCount VAR"   ,table.varCount(Symbol.Kind.VAR)    ==0);

            assertTrue("define r char VAR == 0",table.define("r","char",Symbol.Kind.VAR)==0);
            assertTrue("define s char VAR == 1",table.define("s","char",Symbol.Kind.VAR)==1);
            assertTrue("define t char VAR == 2",table.define("t","char",Symbol.Kind.VAR)==2);
            
            assertTrue("varCount STATIC",table.varCount(Symbol.Kind.STATIC) ==0);
            assertTrue("varCount FIELD" ,table.varCount(Symbol.Kind.FIELD)  ==0);
            assertTrue("varCount ARG"   ,table.varCount(Symbol.Kind.ARG)    ==6);
            assertTrue("varCount VAR"   ,table.varCount(Symbol.Kind.VAR)    ==3);

            assertTrue("define d char VAR == 3",table.define("d","char",Symbol.Kind.VAR)==3);
            assertTrue("define e char VAR == 4",table.define("e","char",Symbol.Kind.VAR)==4);
            assertTrue("define f char VAR == 5",table.define("f","char",Symbol.Kind.VAR)==5);

            assertTrue("varCount STATIC",table.varCount(Symbol.Kind.STATIC) ==0);
            assertTrue("varCount FIELD" ,table.varCount(Symbol.Kind.FIELD)  ==0);
            assertTrue("varCount ARG"   ,table.varCount(Symbol.Kind.ARG)    ==6);
            assertTrue("varCount VAR"   ,table.varCount(Symbol.Kind.VAR)    ==6);

            assertTrue("define h AAA FIELD  == 0",table.define("h","AAA",Symbol.Kind.FIELD)  ==0);
            assertTrue("define i BBB FIELD  == 1",table.define("i","BBB",Symbol.Kind.FIELD)  ==1);
            assertTrue("define j CCC STATIC == 0",table.define("j","CCC",Symbol.Kind.STATIC) ==0);

            assertTrue("varCount STATIC",table.varCount(Symbol.Kind.STATIC) ==1);
            assertTrue("varCount FIELD" ,table.varCount(Symbol.Kind.FIELD)  ==2);
            assertTrue("varCount ARG"   ,table.varCount(Symbol.Kind.ARG)    ==6);
            assertTrue("varCount VAR"   ,table.varCount(Symbol.Kind.VAR)    ==6);

            table.startSubroutine();

            //assertTrue("varCount STATIC",table.varCount(Symbol.Kind.STATIC) ==0);
            //assertTrue("varCount FIELD" ,table.varCount(Symbol.Kind.FIELD)  ==0);
            assertTrue("varCount ARG"   ,table.varCount(Symbol.Kind.ARG)    ==0);
            assertTrue("varCount VAR"   ,table.varCount(Symbol.Kind.VAR)    ==0);


        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Teste verificar os tipos das variáveis armazenadas na tabela.
     */
    @Test
    public void testSymbolTable_typeOf() {

        assertNotNull("Falha a criar o SymbolTable",table);

        try {
            org.junit.Assume.assumeNotNull( table.define("X","int",Symbol.Kind.ARG) );  // ignora test
        } catch(Exception e) { 
            org.junit.Assume.assumeNoException(e);
        }
        
        try {

            table.startSubroutine();

            assertTrue("define X int ARG == 0",table.define("X","int",Symbol.Kind.ARG)==0);
            assertTrue("define Y int ARG == 1",table.define("Y","int",Symbol.Kind.ARG)==1);
            assertTrue("define Z int ARG == 2",table.define("Z","int",Symbol.Kind.ARG)==2);

            assertTrue("typeOf X",table.typeOf("X").equals("int"));
            assertTrue("typeOf Y",table.typeOf("Y").equals("int"));
            assertTrue("typeOf Z",table.typeOf("Z").equals("int"));

            assertTrue("define r char VAR == 0",table.define("r","char",Symbol.Kind.VAR)==0);
            assertTrue("define s char VAR == 1",table.define("s","char",Symbol.Kind.VAR)==1);
            assertTrue("define t char VAR == 2",table.define("t","char",Symbol.Kind.VAR)==2);
            
            assertTrue("typeOf r",table.typeOf("r").equals("char"));
            assertTrue("typeOf s",table.typeOf("s").equals("char"));
            assertTrue("typeOf t",table.typeOf("t").equals("char"));

            assertTrue("define h AAA FIELD  == 0",table.define("h","AAA",Symbol.Kind.FIELD)==0);
            assertTrue("define i BBB FIELD  == 1",table.define("i","BBB",Symbol.Kind.FIELD)==1);
            assertTrue("define j CCC STATIC == 0",table.define("j","CCC",Symbol.Kind.STATIC)==0);
            
            assertTrue("typeOf h",table.typeOf("h").equals("AAA"));
            assertTrue("typeOf i",table.typeOf("i").equals("BBB"));
            assertTrue("typeOf j",table.typeOf("j").equals("CCC"));

        } catch(Exception e) {
            e.printStackTrace();
        }
    }



    /**
     * Teste verificar os tipo de posicionamento das variáveis armazenadas na tabela.
     */
    @Test
    public void testSymbolTable_kindOf() {

        assertNotNull("Falha a criar o SymbolTable",table);

        try {
            org.junit.Assume.assumeNotNull( table.define("X","int",Symbol.Kind.ARG) );  // ignora test
        } catch(Exception e) { 
            org.junit.Assume.assumeNoException(e);
        }
        
        try {

            table.startSubroutine();

            assertTrue("define X int ARG == 0",table.define("X","int",Symbol.Kind.ARG)==0);
            assertTrue("define Y int ARG == 1",table.define("Y","int",Symbol.Kind.ARG)==1);
            assertTrue("define Z int ARG == 2",table.define("Z","int",Symbol.Kind.ARG)==2);

            assertTrue("kindOf X",table.kindOf("X")==Symbol.Kind.ARG);
            assertTrue("kindOf Y",table.kindOf("Y")==Symbol.Kind.ARG);
            assertTrue("kindOf Z",table.kindOf("Z")==Symbol.Kind.ARG);

            assertTrue("define r char VAR == 0",table.define("r","char",Symbol.Kind.VAR)==0);
            assertTrue("define s char VAR == 1",table.define("s","char",Symbol.Kind.VAR)==1);
            assertTrue("define t char VAR == 2",table.define("t","char",Symbol.Kind.VAR)==2);
            
            assertTrue("kindOf r",table.kindOf("r")==Symbol.Kind.VAR);
            assertTrue("kindOf s",table.kindOf("s")==Symbol.Kind.VAR);
            assertTrue("kindOf t",table.kindOf("t")==Symbol.Kind.VAR);

            assertTrue("define h AAA FIELD  == 0",table.define("h","AAA",Symbol.Kind.FIELD)==0);
            assertTrue("define i BBB FIELD  == 1",table.define("i","BBB",Symbol.Kind.FIELD)==1);
            assertTrue("define j CCC STATIC == 0",table.define("j","CCC",Symbol.Kind.STATIC)==0);
            
            assertTrue("kindOf h",table.kindOf("h")==Symbol.Kind.FIELD);
            assertTrue("kindOf i",table.kindOf("i")==Symbol.Kind.FIELD);
            assertTrue("kindOf j",table.kindOf("j")==Symbol.Kind.STATIC);

        } catch(Exception e) {
            e.printStackTrace();
        }
    }



    /**
     * Teste verificar o indice das variáveis armazenadas na tabela.
     */
    @Test
    public void testSymbolTable_indexOf() {

        assertNotNull("Falha a criar o SymbolTable",table);

        try {
            org.junit.Assume.assumeNotNull( table.define("X","int",Symbol.Kind.ARG) );  // ignora test
        } catch(Exception e) { 
            org.junit.Assume.assumeNoException(e);
        }
        
        try {

            table.startSubroutine();

            assertTrue("define X int ARG == 0",table.define("X","int",Symbol.Kind.ARG)==0);
            assertTrue("define Y int ARG == 1",table.define("Y","int",Symbol.Kind.ARG)==1);
            assertTrue("define Z int ARG == 2",table.define("Z","int",Symbol.Kind.ARG)==2);

            assertTrue("indexOf X",table.indexOf("X")==0);
            assertTrue("indexOf Y",table.indexOf("Y")==1);
            assertTrue("indexOf Z",table.indexOf("Z")==2);

            assertTrue("define r char VAR == 0",table.define("r","char",Symbol.Kind.VAR)==0);
            assertTrue("define s char VAR == 1",table.define("s","char",Symbol.Kind.VAR)==1);
            assertTrue("define t char VAR == 2",table.define("t","char",Symbol.Kind.VAR)==2);
            
            assertTrue("indexOf r",table.indexOf("r")==0);
            assertTrue("indexOf s",table.indexOf("s")==1);
            assertTrue("indexOf t",table.indexOf("t")==2);

            assertTrue("define h AAA FIELD  == 0",table.define("h","AAA",Symbol.Kind.FIELD)==0);
            assertTrue("define i BBB FIELD  == 1",table.define("i","BBB",Symbol.Kind.FIELD)==1);
            assertTrue("define j CCC STATIC == 0",table.define("j","CCC",Symbol.Kind.STATIC)==0);
            
            assertTrue("indexOf h",table.indexOf("h")==0);
            assertTrue("indexOf i",table.indexOf("i")==1);
            assertTrue("indexOf j",table.indexOf("j")==0);

        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    


    /**
     * Teste para adicionar e checar se símbolos já inserido
     */
    @Test
    public void testSymbolTable_notInsert() {

        assertNotNull("Falha a criar o SymbolTable",table);

        try {
            org.junit.Assume.assumeNotNull( table.define("X","int",Symbol.Kind.ARG) );  // ignora test
        } catch(Exception e) { 
            org.junit.Assume.assumeNoException(e);
        }
        
        try {

            table.startSubroutine();

            assertTrue("define X int ARG == 0",table.define("X","int",Symbol.Kind.ARG)==0);
            assertTrue("define Y int ARG == 1",table.define("Y","int",Symbol.Kind.ARG)==1);
            assertTrue("define Z int ARG == 2",table.define("Z","int",Symbol.Kind.ARG)==2);

            assertNull("typeOf r",table.typeOf("r"));
            assertNull("typeOf s",table.typeOf("s"));
            assertNull("typeOf t",table.typeOf("t"));

            assertNull("kindOf r",table.kindOf("r"));
            assertNull("kindOf s",table.kindOf("s"));
            assertNull("kindOf t",table.kindOf("t"));

            assertNull("indexOf h",table.indexOf("h"));
            assertNull("indexOf i",table.indexOf("i"));
            assertNull("indexOf j",table.indexOf("j"));


        } catch(Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * Teste para adicionar e checar vários símbolos inseridos
     */
    @Test
    public void testSymbolTable_repetitive() {


        assertNotNull("Falha a criar o SymbolTable",table);

        try {
            org.junit.Assume.assumeNotNull( table.define("X","int",Symbol.Kind.ARG) );  // ignora test
        } catch(Exception e) { 
            org.junit.Assume.assumeNoException(e);
        }
        
        try {
    	
            table.startSubroutine();

            for (int i = 0; i < 16384; i++) {
                assertTrue("loop define == i",table.define("TESTE"+i,"int",Symbol.Kind.ARG)==i);
            }

            for (int i = 0; i < 16384; i++) {
                assertTrue("Testando intensamente Tabela de Símbolos",table.indexOf("TESTE"+i)==i);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

    }


}