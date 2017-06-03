/**
 * Curso: Elementos de Sistemas
 * Arquivo: TokenizerTest.java
 * Created by Luciano Soares <lpsoares@insper.edu.br> 
 * Date: 2/05/2017
 */

package compiler;

import org.junit.Test;
import org.junit.Rule;
import org.junit.rules.TemporaryFolder;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertNotNull;

import java.io.File;
import java.io.IOException;
import java.io.*;
import java.lang.*;
import java.util.*;

import compiler.VMWriter;

public class VMWriterTest {

	@Rule
    public TemporaryFolder testFolder = new TemporaryFolder();

	/**
	 * Create the test case
	 */
	public VMWriterTest() {
	}

	/**
	 * Teste para gravar arquivo vm com instrução writePush
	 */
	@Test
	public void testTokenizer_writePush() {

		File tempFolder = null;
		File tempFile = null;
		VMWriter writer = null;

		try {
			tempFolder = testFolder.newFolder("tests");
			tempFile = testFolder.newFile("teste_writePush.vm");
			writer = new VMWriter(tempFile);
		} catch(Exception e) {
			e.printStackTrace();
		}

		try {
			org.junit.Assume.assumeNotNull( writer.writePush(VMWriter.Segment.CONST,0) );	// ignora test se não consegue gravar dados
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue("writePush CONST 0",writer.writePush(VMWriter.Segment.CONST,0).equals("push constant 0"));
			assertTrue("writePush CONST 1",writer.writePush(VMWriter.Segment.CONST,1).equals("push constant 1"));
			assertTrue("writePush CONST 2",writer.writePush(VMWriter.Segment.CONST,2).equals("push constant 2"));
			assertTrue("writePush CONST 3",writer.writePush(VMWriter.Segment.CONST,3).equals("push constant 3"));
			assertTrue("writePush CONST 4",writer.writePush(VMWriter.Segment.CONST,4).equals("push constant 4"));
			assertTrue("writePush CONST 5",writer.writePush(VMWriter.Segment.CONST,5).equals("push constant 5"));

			assertTrue("writePush ARG 0",writer.writePush(VMWriter.Segment.ARG,0).equals("push argument 0"));
			assertTrue("writePush LOCAL 1",writer.writePush(VMWriter.Segment.LOCAL,1).equals("push local 1"));
			assertTrue("writePush STATIC 2",writer.writePush(VMWriter.Segment.STATIC,2).equals("push static 2"));
			assertTrue("writePush THIS 3",writer.writePush(VMWriter.Segment.THIS,3).equals("push this 3"));
			assertTrue("writePush THAT 4",writer.writePush(VMWriter.Segment.THAT,4).equals("push that 4"));
			assertTrue("writePush POINTER 5",writer.writePush(VMWriter.Segment.POINTER,5).equals("push pointer 5"));
			assertTrue("writePush TEMP 6",writer.writePush(VMWriter.Segment.TEMP,6).equals("push temp 6"));

      		writer.close();

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		BufferedReader fileReader = null;       // leitor de arquivo

		try {
            fileReader = new BufferedReader(new FileReader(tempFile));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        try {

            String currentLine;

            // Teste do assumeNotNull
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push constant 0 != "+currentLine,currentLine.equals("push constant 0"));

            // Teste do primeiro assertTrue
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push constant 0 != "+currentLine,currentLine.equals("push constant 0"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push constant 1 != "+currentLine,currentLine.equals("push constant 1"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push constant 2 != "+currentLine,currentLine.equals("push constant 2"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push constant 3 != "+currentLine,currentLine.equals("push constant 3"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push constant 4 != "+currentLine,currentLine.equals("push constant 4"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push constant 5 != "+currentLine,currentLine.equals("push constant 5"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push argument 0 != "+currentLine,currentLine.equals("push argument 0"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push local 1 != "+currentLine,currentLine.equals("push local 1"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push static 2 != "+currentLine,currentLine.equals("push static 2"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push this 3 != "+currentLine,currentLine.equals("push this 3"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push that 4 != "+currentLine,currentLine.equals("push that 4"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push pointer 5 != "+currentLine,currentLine.equals("push pointer 5"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push temp 6 != "+currentLine,currentLine.equals("push temp 6"));

        } catch (IOException e) {
            e.printStackTrace();
        }

	}

	/**
	 * Teste para gravar arquivo vm com instrução writePop
	 */
	@Test
	public void testTokenizer_writePop() {

		File tempFolder = null;
		File tempFile = null;
		VMWriter writer = null;

		try {
			tempFolder = testFolder.newFolder("tests");
			tempFile = testFolder.newFile("teste_writePop.vm");
			writer = new VMWriter(tempFile);
		} catch(Exception e) {
			e.printStackTrace();
		}

		try {
			org.junit.Assume.assumeNotNull( writer.writePop(VMWriter.Segment.LOCAL,0) );	// ignora test se não consegue gravar dados
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue("writePop LOCAL 0",writer.writePop(VMWriter.Segment.LOCAL,0).equals("pop local 0"));
			assertTrue("writePop LOCAL 1",writer.writePop(VMWriter.Segment.LOCAL,1).equals("pop local 1"));
			assertTrue("writePop LOCAL 2",writer.writePop(VMWriter.Segment.LOCAL,2).equals("pop local 2"));
			assertTrue("writePop LOCAL 3",writer.writePop(VMWriter.Segment.LOCAL,3).equals("pop local 3"));
			assertTrue("writePop LOCAL 4",writer.writePop(VMWriter.Segment.LOCAL,4).equals("pop local 4"));
			assertTrue("writePop LOCAL 5",writer.writePop(VMWriter.Segment.LOCAL,5).equals("pop local 5"));

			assertTrue("writePop ARG 0",writer.writePop(VMWriter.Segment.ARG,0).equals("pop argument 0"));
			assertTrue("writePop TEMP 1",writer.writePop(VMWriter.Segment.TEMP,1).equals("pop temp 1"));
			assertTrue("writePop STATIC 2",writer.writePop(VMWriter.Segment.STATIC,2).equals("pop static 2"));
			assertTrue("writePop THIS 3",writer.writePop(VMWriter.Segment.THIS,3).equals("pop this 3"));
			assertTrue("writePop THAT 4",writer.writePop(VMWriter.Segment.THAT,4).equals("pop that 4"));
			assertTrue("writePop POINTER 5",writer.writePop(VMWriter.Segment.POINTER,5).equals("pop pointer 5"));
			assertTrue("writePop TEMP 6",writer.writePop(VMWriter.Segment.TEMP,6).equals("pop temp 6"));

      		writer.close();

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		BufferedReader fileReader = null;       // leitor de arquivo

		try {
            fileReader = new BufferedReader(new FileReader(tempFile));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        try {

            String currentLine;

            // Teste do assumeNotNull
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("pop local 0 != "+currentLine,currentLine.equals("pop local 0"));

            // Teste do primeiro assertTrue
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("pop local 0 != "+currentLine,currentLine.equals("pop local 0"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("pop local 1 != "+currentLine,currentLine.equals("pop local 1"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("pop local 2 != "+currentLine,currentLine.equals("pop local 2"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("pop local 3 != "+currentLine,currentLine.equals("pop local 3"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("pop local 4 != "+currentLine,currentLine.equals("pop local 4"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("pop local 5 != "+currentLine,currentLine.equals("pop local 5"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("pop argument 0 != "+currentLine,currentLine.equals("pop argument 0"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("pop temp 1 != "+currentLine,currentLine.equals("pop temp 1"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("pop static 2 != "+currentLine,currentLine.equals("pop static 2"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("pop this 3 != "+currentLine,currentLine.equals("pop this 3"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("pop that 4 != "+currentLine,currentLine.equals("pop that 4"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("pop pointer 5 != "+currentLine,currentLine.equals("pop pointer 5"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("pop temp 6 != "+currentLine,currentLine.equals("pop temp 6"));

        } catch (IOException e) {
            e.printStackTrace();
        }

	}

	/**
	 * Teste para gravar arquivo vm com instrução writeArithmetic
	 */
	@Test
	public void testTokenizer_writeArithmetic() {

		File tempFolder = null;
		File tempFile = null;
		VMWriter writer = null;

		try {
			tempFolder = testFolder.newFolder("tests");
			tempFile = testFolder.newFile("teste_writeArithmetic.vm");
			writer = new VMWriter(tempFile);
		} catch(Exception e) {
			e.printStackTrace();
		}

		try {
			org.junit.Assume.assumeNotNull( writer.writeArithmetic(VMWriter.Command.ADD) );	// ignora test se não consegue gravar dados
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue("writeArithmetic ADD",writer.writeArithmetic(VMWriter.Command.ADD).equals("add"));
			assertTrue("writeArithmetic SUB",writer.writeArithmetic(VMWriter.Command.SUB).equals("sub"));
			assertTrue("writeArithmetic NEG",writer.writeArithmetic(VMWriter.Command.NEG).equals("neg"));
			assertTrue("writeArithmetic EQ",writer.writeArithmetic(VMWriter.Command.EQ).equals("eq"));
			assertTrue("writeArithmetic GT",writer.writeArithmetic(VMWriter.Command.GT).equals("gt"));
			assertTrue("writeArithmetic LT",writer.writeArithmetic(VMWriter.Command.LT).equals("lt"));
			assertTrue("writeArithmetic AND",writer.writeArithmetic(VMWriter.Command.AND).equals("and"));
			assertTrue("writeArithmetic OR",writer.writeArithmetic(VMWriter.Command.OR).equals("or"));
			assertTrue("writeArithmetic NOT",writer.writeArithmetic(VMWriter.Command.NOT).equals("not"));

      		writer.close();

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		BufferedReader fileReader = null;       // leitor de arquivo

		try {
            fileReader = new BufferedReader(new FileReader(tempFile));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        try {

            String currentLine;

            // Teste do assumeNotNull
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("add != "+currentLine,currentLine.equals("add"));

            // Teste do primeiro assertTrue
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("add != "+currentLine,currentLine.equals("add"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("sub != "+currentLine,currentLine.equals("sub"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("neg != "+currentLine,currentLine.equals("neg"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("eq != "+currentLine,currentLine.equals("eq"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("gt != "+currentLine,currentLine.equals("gt"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("lt != "+currentLine,currentLine.equals("lt"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("and != "+currentLine,currentLine.equals("and"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("or != "+currentLine,currentLine.equals("or"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("not != "+currentLine,currentLine.equals("not"));

        } catch (IOException e) {
            e.printStackTrace();
        }

	}

	/**
	 * Teste para gravar arquivo vm com instrução writeLabel
	 */
	@Test
	public void testTokenizer_writeLabel() {

		File tempFolder = null;
		File tempFile = null;
		VMWriter writer = null;

		try {
			tempFolder = testFolder.newFolder("tests");
			tempFile = testFolder.newFile("teste_writeLabel.vm");
			writer = new VMWriter(tempFile);
		} catch(Exception e) {
			e.printStackTrace();
		}

		try {
			org.junit.Assume.assumeNotNull( writer.writeLabel("LOOP") );	// ignora test se não consegue gravar dados
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue("writeLabel LOOP",writer.writeLabel("LOOP").equals("label LOOP"));
			assertTrue("writeLabel banana",writer.writeLabel("banana").equals("label banana"));
			assertTrue("writeLabel a123",writer.writeLabel("a123").equals("label a123"));
			assertTrue("writeLabel x_z",writer.writeLabel("x_z").equals("label x_z"));

      		writer.close();

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		BufferedReader fileReader = null;       // leitor de arquivo

		try {
            fileReader = new BufferedReader(new FileReader(tempFile));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        try {

            String currentLine;

            // Teste do assumeNotNull
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("label LOOP != "+currentLine,currentLine.equals("label LOOP"));

            // Teste do primeiro assertTrue
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("label LOOP != "+currentLine,currentLine.equals("label LOOP"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("label banana != "+currentLine,currentLine.equals("label banana"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("label a123 != "+currentLine,currentLine.equals("label a123"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("label x_z != "+currentLine,currentLine.equals("label x_z"));
			
        } catch (IOException e) {
            e.printStackTrace();
        }

	}

	/**
	 * Teste para gravar arquivo vm com instrução writeGoto
	 */
	@Test
	public void testTokenizer_writeGoto() {

		File tempFolder = null;
		File tempFile = null;
		VMWriter writer = null;

		try {
			tempFolder = testFolder.newFolder("tests");
			tempFile = testFolder.newFile("teste_writeGoto.vm");
			writer = new VMWriter(tempFile);
		} catch(Exception e) {
			e.printStackTrace();
		}

		try {
			org.junit.Assume.assumeNotNull( writer.writeGoto("LOOP") );	// ignora test se não consegue gravar dados
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue("writeGoto LOOP",writer.writeGoto("LOOP").equals("goto LOOP"));
			assertTrue("writeGoto banana",writer.writeGoto("banana").equals("goto banana"));
			assertTrue("writeGoto a123",writer.writeGoto("a123").equals("goto a123"));
			assertTrue("writeGoto x_z",writer.writeGoto("x_z").equals("goto x_z"));

      		writer.close();

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		BufferedReader fileReader = null;       // leitor de arquivo

		try {
            fileReader = new BufferedReader(new FileReader(tempFile));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        try {

            String currentLine;

            // Teste do assumeNotNull
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("goto LOOP != "+currentLine,currentLine.equals("goto LOOP"));

            // Teste do primeiro assertTrue
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("goto LOOP != "+currentLine,currentLine.equals("goto LOOP"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("goto banana != "+currentLine,currentLine.equals("goto banana"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("goto a123 != "+currentLine,currentLine.equals("goto a123"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("goto x_z != "+currentLine,currentLine.equals("goto x_z"));
			
        } catch (IOException e) {
            e.printStackTrace();
        }

	}

	/**
	 * Teste para gravar arquivo vm com instrução writeIf
	 */
	@Test
	public void testTokenizer_writeIf() {

		File tempFolder = null;
		File tempFile = null;
		VMWriter writer = null;

		try {
			tempFolder = testFolder.newFolder("tests");
			tempFile = testFolder.newFile("teste_writeIf.vm");
			writer = new VMWriter(tempFile);
		} catch(Exception e) {
			e.printStackTrace();
		}

		try {
			org.junit.Assume.assumeNotNull( writer.writeIf("LOOP") );	// ignora test se não consegue gravar dados
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue("writeIf LOOP",writer.writeIf("LOOP").equals("if-goto LOOP"));
			assertTrue("writeIf banana",writer.writeIf("banana").equals("if-goto banana"));
			assertTrue("writeIf a123",writer.writeIf("a123").equals("if-goto a123"));
			assertTrue("writeIf x_z",writer.writeIf("x_z").equals("if-goto x_z"));

      		writer.close();

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		BufferedReader fileReader = null;       // leitor de arquivo

		try {
            fileReader = new BufferedReader(new FileReader(tempFile));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        try {

            String currentLine;

            // Teste do assumeNotNull
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("if-goto LOOP != "+currentLine,currentLine.equals("if-goto LOOP"));

            // Teste do primeiro assertTrue
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("if-goto LOOP != "+currentLine,currentLine.equals("if-goto LOOP"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("if-goto banana != "+currentLine,currentLine.equals("if-goto banana"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("if-goto a123 != "+currentLine,currentLine.equals("if-goto a123"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("if-goto x_z != "+currentLine,currentLine.equals("if-goto x_z"));
			
        } catch (IOException e) {
            e.printStackTrace();
        }

	}

	/**
	 * Teste para gravar arquivo vm com instrução writeCall
	 */
	@Test
	public void testTokenizer_writeCall() {

		File tempFolder = null;
		File tempFile = null;
		VMWriter writer = null;

		try {
			tempFolder = testFolder.newFolder("tests");
			tempFile = testFolder.newFile("teste_writeCall.vm");
			writer = new VMWriter(tempFile);
		} catch(Exception e) {
			e.printStackTrace();
		}

		try {
			org.junit.Assume.assumeNotNull( writer.writeCall("LOOP",0) );	// ignora test se não consegue gravar dados
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue("writeCall LOOP 0",writer.writeCall("LOOP",0).equals("call LOOP 0"));
			assertTrue("writeCall banana 1",writer.writeCall("banana",1).equals("call banana 1"));
			assertTrue("writeCall a123 2",writer.writeCall("a123",2).equals("call a123 2"));
			assertTrue("writeCall x_z 3",writer.writeCall("x_z",3).equals("call x_z 3"));

      		writer.close();

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		BufferedReader fileReader = null;       // leitor de arquivo

		try {
            fileReader = new BufferedReader(new FileReader(tempFile));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        try {

            String currentLine;

            // Teste do assumeNotNull
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("call LOOP 0 != "+currentLine,currentLine.equals("call LOOP 0"));

            // Teste do primeiro assertTrue
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("call LOOP 0 != "+currentLine,currentLine.equals("call LOOP 0"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("call banana 1 != "+currentLine,currentLine.equals("call banana 1"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("call a123 2 != "+currentLine,currentLine.equals("call a123 2"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("call x_z 3 != "+currentLine,currentLine.equals("call x_z 3"));
			
        } catch (IOException e) {
            e.printStackTrace();
        }

	}

	/**
	 * Teste para gravar arquivo vm com instrução writeFunction
	 */
	@Test
	public void testTokenizer_writeFunction() {

		File tempFolder = null;
		File tempFile = null;
		VMWriter writer = null;

		try {
			tempFolder = testFolder.newFolder("tests");
			tempFile = testFolder.newFile("teste_writeFunction.vm");
			writer = new VMWriter(tempFile);
		} catch(Exception e) {
			e.printStackTrace();
		}

		try {
			org.junit.Assume.assumeNotNull( writer.writeFunction("LOOP",0) );	// ignora test se não consegue gravar dados
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue("writeFunction LOOP 0",writer.writeFunction("LOOP",0).equals("function LOOP 0"));
			assertTrue("writeFunction banana 1",writer.writeFunction("banana",1).equals("function banana 1"));
			assertTrue("writeFunction a123 2",writer.writeFunction("a123",2).equals("function a123 2"));
			assertTrue("writeFunction x_z 3",writer.writeFunction("x_z",3).equals("function x_z 3"));

      		writer.close();

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		BufferedReader fileReader = null;       // leitor de arquivo

		try {
            fileReader = new BufferedReader(new FileReader(tempFile));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        try {

            String currentLine;

            // Teste do assumeNotNull
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("function LOOP 0 != "+currentLine,currentLine.equals("function LOOP 0"));

            // Teste do primeiro assertTrue
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("function LOOP 0 != "+currentLine,currentLine.equals("function LOOP 0"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("function banana 1 != "+currentLine,currentLine.equals("function banana 1"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("function a123 2 != "+currentLine,currentLine.equals("function a123 2"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("function x_z 3 != "+currentLine,currentLine.equals("function x_z 3"));
			
        } catch (IOException e) {
            e.printStackTrace();
        }

	}

	/**
	 * Teste para gravar arquivo vm com instrução writeReturn
	 */
	@Test
	public void testTokenizer_writeReturn() {

		File tempFolder = null;
		File tempFile = null;
		VMWriter writer = null;

		try {
			tempFolder = testFolder.newFolder("tests");
			tempFile = testFolder.newFile("teste_writeReturn.vm");
			writer = new VMWriter(tempFile);
		} catch(Exception e) {
			e.printStackTrace();
		}

		try {
			org.junit.Assume.assumeNotNull( writer.writeReturn() );	// ignora test se não consegue gravar dados
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {
			
			assertTrue("writeReturn",writer.writeReturn().equals("return"));

      		writer.close();

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		BufferedReader fileReader = null;       // leitor de arquivo

		try {
            fileReader = new BufferedReader(new FileReader(tempFile));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        try {

            String currentLine;

            // Teste do assumeNotNull
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("return != "+currentLine,currentLine.equals("return"));

            // Teste do primeiro assertTrue
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("return != "+currentLine,currentLine.equals("return"));


        } catch (IOException e) {
            e.printStackTrace();
        }

	}


	@Test
	public void testTokenizer_writeString() {

		File tempFolder = null;
		File tempFile = null;
		VMWriter writer = null;

		try {
			tempFolder = testFolder.newFolder("tests");
			tempFile = testFolder.newFile("teste_writeString.vm");
			writer = new VMWriter(tempFile);
		} catch(Exception e) {
			e.printStackTrace();
		}

		try {
			org.junit.Assume.assumeNotNull( writer.writeString("A") );	// ignora test se não consegue gravar dados
		} catch(Exception e) { 
			org.junit.Assume.assumeNoException(e);
		}
		
		try {

			assertTrue("writeString \"B 1\"",writer.writeString("B 1")==3);

      		writer.close();

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		BufferedReader fileReader = null;       // leitor de arquivo

		try {
            fileReader = new BufferedReader(new FileReader(tempFile));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        try {

            String currentLine;

            // Teste do assumeNotNull "A"
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push constant 1 != "+currentLine,currentLine.equals("push constant 1"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("call String.new 1 != "+currentLine,currentLine.equals("call String.new 1"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push constant 65 != "+currentLine,currentLine.equals("push constant 65"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("call String.appendChar 2 != "+currentLine,currentLine.equals("call String.appendChar 2"));


            // Teste do primeiro assertTrue
            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push constant 3 != "+currentLine,currentLine.equals("push constant 3"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("call String.new 1 != "+currentLine,currentLine.equals("call String.new 1"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push constant 66 != "+currentLine,currentLine.equals("push constant 66"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("call String.appendChar 2 != "+currentLine,currentLine.equals("call String.appendChar 2"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push constant 32 != "+currentLine,currentLine.equals("push constant 32"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("call String.appendChar 2 != "+currentLine,currentLine.equals("call String.appendChar 2"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("push constant 49 != "+currentLine,currentLine.equals("push constant 49"));

            currentLine = fileReader.readLine();
            assertNotNull("readline",currentLine);
            assertTrue("call String.appendChar 2 != "+currentLine,currentLine.equals("call String.appendChar 2"));

        } catch (IOException e) {
            e.printStackTrace();
        }

	}

}
