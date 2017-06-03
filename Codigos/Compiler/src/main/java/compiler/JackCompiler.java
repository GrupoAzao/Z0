/**
 * Curso: Elementos de Sistemas
 * Arquivo: JackCompiler.java
 * Created by Luciano Soares <lpsoares@insper.edu.br>
 * Date: 4/05/2017
 */

package compiler;

import java.io.*;
import java.nio.file.*;
import java.util.ArrayList;

/**
 * Classe principal (main) que orquestra a tradu��o do arquivo em linguagem de m�quina virtual � pilha.
 * Essa classe � respons�vel por ler os parametros da execu��o do programa pela linha de c�digo, ou
 * seja, se o programa for invocado com par�metros esses dever�o ser carregados.
 * Op��es:
 *   <arquivo/diret�rio jack>    primeiro parametro � o nome do arquivo jack a ser aberto
 *   -o <diret�rio jack>   parametro (opcional) que indica onde ser� salvo os arquivos gerados .vm
 *   -x                          gera arquivos de sa�da da an�lise sint�tica em XML
 */
class JackCompiler {

	/**
	 * M�todo est�tico que � carregado na execu��o do programa.
	 * Os par�metros de linha de comando dever ser tratados nessa rotina.
	 */ 
	public static void main(String[] args) {

		if (args.length < 1)  // checa se arquivo foi passado
			Error.error("nome do arquivo não encontrado");

		String inputFilename = null;    // Usado para armazenar argumento com nome do arquivo de entrada (.jack).
		String outputFilename = null;   // Usado para armazenar argumento com nome do arquivo de sa�da (.vm).

		String outputFilenameX = null;  // Define nome do arquivo para salvar �rvore sint�tica em XML.
		String outputFilenameT = null;  // Define nome do arquivo para salvar parsing simples em XML.
		String outputFilenameV = null;  // Define nome do arquivo para salvar c�digo gerado em linguagem VM.

		//boolean debug = false;

		boolean createXML = false;

		for (int i = 0; i < args.length; i++) {
			switch (args[i].charAt(0)) {
			case '-':
				if (args[i].charAt(1) == 'h') {
				} else if (args[i].charAt(1) == 'o') {
					outputFilename = args[i+1]; // nome gen�rico do arquivo de sa�da
					i++;
				} else if (args[i].charAt(1) == 'x') {
					createXML = true; // gera arquivos XML de sa�da
				} else {
					Error.error("Argumento n�o reconhecido: "+args[i]);
				}
				break;
			default:
				inputFilename = args[i];
				break;
			}
		}

		try {

			Path path = new File(inputFilename).toPath().toAbsolutePath();

			ArrayList<String> files = new ArrayList<String>();

			// Cria um arquivo de sa�da dependendo se diret�rio.
			if(Files.isDirectory(path)) {  // caso diret�rio

				// descobre o indice do �ltimo nome de diret�rio
				int indexName = path.getNameCount()-1;
				if(path.getName(indexName).toString().equals(".")) {
					indexName--;
				}

				DirectoryStream<Path> directoryStream = Files.newDirectoryStream(path);
				for (Path p : directoryStream) {

					String extension = "";
					int i = p.toString().lastIndexOf('.');
					if (i > 0) {
						extension = p.toString().substring(i+1);
					}
					if(extension.equals("jack")) {
						files.add(p.toString());
					}
				}
			} else {   // N�o � diret�rio, ent�o � um arquivo
				files.add(inputFilename);
			}

			for (String file : files) {

				if(outputFilename==null) {
					outputFilenameV = file.replace(".jack",".vm");
					outputFilenameX = file.replace(".jack",".xml");
					outputFilenameT = file.replace(".jack","T.xml");
				} else {
					outputFilenameV = outputFilename+file.substring(file.lastIndexOf('/')).replace(".jack",".vm");
					outputFilenameX = outputFilename+file.substring(file.lastIndexOf('/')).replace(".jack",".xml");
					outputFilenameT = outputFilename+file.substring(file.lastIndexOf('/')).replace(".jack","T.xml");
				}

				CompilationEngine codeVM = new CompilationEngine(file,outputFilenameV);
				codeVM.compileClass();  // todo arquivo deve come�ar com uma declara��o de classe.
				codeVM.close();

				if(createXML) {
					CompilationEngine codeXML = new CompilationEngine(file,outputFilenameX,outputFilenameT);
					codeXML.compileClass();  // todo arquivo deve come�ar com uma declara��o de classe.
					codeXML.close();
				}

			}

		} catch (IOException e) {
			Error.error("uma excessao de i/o foi lancada");
			System.exit(1);
		}
	}
}
