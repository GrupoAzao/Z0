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
 * Classe principal (main) que orquestra a tradução do arquivo em linguagem de máquina virtual à pilha.
 * Essa classe é responsável por ler os parametros da execução do programa pela linha de código, ou
 * seja, se o programa for invocado com parâmetros esses deverão ser carregados.
 * Opções:
 *   <arquivo/diretório jack>    primeiro parametro é o nome do arquivo jack a ser aberto 
 *   -o <diretório jack>   parametro (opcional) que indica onde será salvo os arquivos gerados .vm
 *   -x                          gera arquivos de saída da análise sintática em XML
 */
class JackCompiler {

	/**
	 * Método estático que é carregado na execução do programa.
	 * Os parâmetros de linha de comando dever ser tratados nessa rotina.
	 */ 
	public static void main(String[] args) {

		if (args.length < 1)  // checa se arquivo foi passado
			Error.error("informe o nome do arquivo jack");

		String inputFilename = null;    // Usado para armazenar argumento com nome do arquivo de entrada (.jack).
		String outputFilename = null;   // Usado para armazenar argumento com nome do arquivo de saída (.vm).

		String outputFilenameX = null;  // Define nome do arquivo para salvar árvore sintática em XML.
		String outputFilenameT = null;  // Define nome do arquivo para salvar parsing simples em XML.
		String outputFilenameV = null;  // Define nome do arquivo para salvar código gerado em linguagem VM.

		//boolean debug = false;

		boolean createXML = false;

		for (int i = 0; i < args.length; i++) {
			switch (args[i].charAt(0)) {
			case '-':
				if (args[i].charAt(1) == 'h') {
					System.out.println("Opções");
					System.out.println("<arquivo/diretório> : programa em linguagem de alto nível (jack) a ser carregado");
					System.out.println("-o <diretório> : nome do arquivo para salvar no formato VM");
					System.out.println("-x : gera arquivos de saída da análise sintática em XML");
				} else if (args[i].charAt(1) == 'o') {
					outputFilename = args[i+1]; // nome genérico do arquivo de saída
					i++;
				} else if (args[i].charAt(1) == 'x') {
					createXML = true; // gera arquivos XML de saída
				} else {
					Error.error("Argumento não reconhecido: "+args[i]);
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

			// Cria um arquivo de saída dependendo se diretório.
			if(Files.isDirectory(path)) {  // caso diretório

				// descobre o indice do último nome de diretório
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
			} else {   // Não é diretório, então é um arquivo    
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

				System.out.println(outputFilenameV);

				CompilationEngine codeVM = new CompilationEngine(file,outputFilenameV);
				codeVM.compileClass();  // todo arquivo deve começar com uma declaração de classe.
				codeVM.close();

				if(createXML) {
					CompilationEngine codeXML = new CompilationEngine(file,outputFilenameX,outputFilenameT);
					codeXML.compileClass();  // todo arquivo deve começar com uma declaração de classe.
					codeXML.close();
				}            
				
			}
			
		} catch (IOException e) {
			Error.error("uma excessao de i/o foi lancada");
			System.exit(1);
		}
	}
}
