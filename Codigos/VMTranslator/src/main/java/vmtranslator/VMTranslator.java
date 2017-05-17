/**
* Curso: Elementos de Sistemas
* Arquivo: VMTranslator.java
*/

package vmtranslator;

import java.io.File;
/**
 * Classe principal que orquestra a tradução do arquivo em linguagem de máquina virtual à pilha.
 * Opções:
 *   <arquivo vm>         primeiro parâmetro é o nome do arquivo vm a ser aberto
 *   -o <arquivo nasm>    parâmetro indica onde será salvo o arquivo gerado .nasm
 *   -n                   parâmetro indica não colocar rotina de bootstrap (conveniente para testar)
 */
class VMTranslator {
import vmtranslator.Parser.CommandType;

/**
* Classe principal que orquestra a tradução do arquivo em linguagem de máquina virtual à pilha.
* Opções:
*   <arquivo vm>         primeiro parametro é o nome do arquivo vm a ser aberto
*   -o <arquivo nasm>    parametro indica onde será salvo o arquivo gerado .nasm
*   -n                   parametro indica não colocar rotina de bootstrap (conveniente para testar)
*/
class VMTranslator {

  public static void main(String[] args) {
    Parser parser = null;
    Code code = null;
    for (int i = 0;i<args.length;i++){
      if (args[i].endsWith("-o")){
        String argument = args[i+1];
        i++;
        code = new Code(argument);
      }else if (args[i].startsWith("/")){
        File file = new File(args[i]);

        boolean exists =      file.exists();      // Check if the file exists
        boolean isDirectory = file.isDirectory(); // Check if it's a directory
        boolean isFile =      file.isFile();      // Check if it's a regular file
        if (exists){
          if (isFile){
            parser = new Parser(args[i]);
          }else if (isDirectory){
            File[] directoryListing = file.listFiles();
            if (directoryListing != null) {
              for (File child : directoryListing) {
                if (child.toString().endsWith(".vm")){
                  parser = new Parser(child.toString());
                  if (code != null){
                    processFile(parser,code);
                  }else{
                    achararg:
                    for (int a = 0;i<args.length;a++){
                      if (args[a].endsWith("-o")){
                        String argument = args[a+1];
                        a++;
                        code = new Code(argument);
                        break achararg;
                      }
                    }
                    processFile(parser,code);
                  }
                }
              }
            }
          }
        }
      }else {
        parser = new Parser(args[i]);
        if (code != null){
          processFile(parser,code);
        }else{
          achararg:
          for (int a = 0;i<args.length;a++){
            if (args[a].endsWith("-o")){
              String argument = args[a+1];
              a++;
              code = new Code(argument);
              break achararg;
            }
          }
          processFile(parser,code);
        }
      }
    }
  }

  public static void processFile(Parser parser,Code code){
    while (parser.advance()){
      String command = parser.command();
      CommandType commandType = parser.commandType(command);
      if (commandType == CommandType.C_ARITHMETIC){
        code.writeArithmetic(command);
      }else if (commandType == CommandType.C_PUSH){
        code.writePushPop(commandType, parser.arg1(command), parser.arg2(command));
      }else if (commandType == CommandType.C_POP){
        code.writePushPop(commandType, parser.arg1(command), parser.arg2(command));
      }else if (commandType == CommandType.C_LABEL){
        code.writeLabel(command);
      }else if (commandType == CommandType.C_GOTO){
        code.writeGoto(parser.arg1(command));
      }else if (commandType == CommandType.C_IF){
        code.writeIf(command);
      }else if (commandType == CommandType.C_FUNCTION){
        code.writeFunction(parser.arg1(command),parser.arg2(command));
      }else if (commandType == CommandType.C_CALL){
        code.writeCall(parser.arg1(command),parser.arg2(command));
      }else if (commandType == CommandType.C_RETURN){
        code.writeReturn();
      }
    }
  }
}
