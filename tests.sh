#!/usr/bin/env bash

# Todos os Testes do Z0
# Arquivo: tests.sh
# Criado por: Luciano Soares <lpsoares@insper.edu.br>
# Data: 27/04/2017

# Formatting constants
export BOLD=`tput bold`
export UNDERLINE_ON=`tput smul`
export UNDERLINE_OFF=`tput rmul`
export TEXT_BLACK=`tput setaf 0`
export TEXT_RED=`tput setaf 1`
export TEXT_GREEN=`tput setaf 2`
export TEXT_YELLOW=`tput setaf 3`
export TEXT_BLUE=`tput setaf 4`
export TEXT_MAGENTA=`tput setaf 5`
export TEXT_CYAN=`tput setaf 6`
export TEXT_WHITE=`tput setaf 7`
export BACKGROUND_BLACK=`tput setab 0`
export BACKGROUND_RED=`tput setab 1`
export BACKGROUND_GREEN=`tput setab 2`
export BACKGROUND_YELLOW=`tput setab 3`
export BACKGROUND_BLUE=`tput setab 4`
export BACKGROUND_MAGENTA=`tput setab 5`
export BACKGROUND_CYAN=`tput setab 6`
export BACKGROUND_WHITE=`tput setab 7`
export RESET_FORMATTING=`tput sgr0`
 
# Wrapper function for Maven's mvn command.
mvn-color()
{
  # Filter mvn output using sed
  mvn -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn -B $@ | sed \
  			   -e "s/\(\[INFO\]\ \-.*\)/${TEXT_BLUE}${BOLD}\1/g" \
               -e "s/\(\[INFO\]\ \[ .*\)/${RESET_FORMATTING}${BOLD}\1${RESET_FORMATTING}/g" \
               -e "s/\(\[INFO\]\ BUILD SUCCESSFUL\)/${BOLD}${TEXT_GREEN}\1${RESET_FORMATTING}/g" \
               -e "s/\(\[WARNING\].*\)/${BOLD}${TEXT_YELLOW}\1${RESET_FORMATTING}/g" \
               -e "s/\(\[ERROR\].*\)/${BOLD}${TEXT_RED}\1${RESET_FORMATTING}/g" \
               -e "s/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/${BOLD}${TEXT_GREEN}Tests run: \1${RESET_FORMATTING}, Failures: ${BOLD}${TEXT_RED}\2${RESET_FORMATTING}, Errors: ${BOLD}${TEXT_RED}\3${RESET_FORMATTING}, Skipped: ${BOLD}${TEXT_YELLOW}\4${RESET_FORMATTING}/g"
 
  # Make sure formatting is reset
  echo -ne ${RESET_FORMATTING}
}

let "n_error=0"


# Testes para VHDL
if [ -z "$1" ] || [ $1 == "vhdl" ]; then
	echo -e "\n\n"
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\t                \t\t\t"${RESET_FORMATTING}
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\tTestes para VHDL\t\t\t"${RESET_FORMATTING}
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\t                \t\t\t"${RESET_FORMATTING}
	echo -e "\n"
	python TestesHW/run.py -p3
	let "n_error+=$?"
fi


# Testes para codigos em Assembly
if [ -z "$1" ] || [ $1 == "assembly" ] ; then
	echo -e "\n\n"
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\t                               \t\t\t"${RESET_FORMATTING}
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\tTestes para codigos em Assembly\t\t\t"${RESET_FORMATTING}
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\t                               \t\t\t"${RESET_FORMATTING}
	echo -e "\n"
	python TestesSW/assembler.py -j TestesSW/Assembler/AssemblerZ0.jar -t TestesSW/testesAssembly.txt -in Codigos/Assembly/ -out TestesSW/machine_code/ -p 3
	let "n_error+=$?"
	python TestesSW/emulate.py -t TestesSW/testesAssembly.txt -in TestesSW/testesAssembly/ -out TestesSW/machine_code/ -p 3 -r 512,256
	let "n_error+=$?"
	python -m pytest -v TestesSW/testeAssembly.py -rxs
	let "n_error+=$?"
fi

# Testes para AssemblerZ0
if [ -z "$1" ] || [ $1 == "assembler" ] ; then
	echo -e "\n\n"
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\t                       \t\t\t"${RESET_FORMATTING}
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\tTestes para AssemblerZ0\t\t\t"${RESET_FORMATTING}
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\t                       \t\t\t"${RESET_FORMATTING}
	echo -e "\n"
	mvn-color -f Codigos/AssemblerZ0 package
	let "n_error+=$?"
	python -m pytest -v TestesSW/testeAssembler.py -rxs
	### O CERTO SERIA COLOCAR NO EMULADOR ###
	let "n_error+=$?"
fi

# Testes para codigos VM
### NÃO FEITO E NEM NO CURSO, FAZER ###


# Testes para o VMTranslator
if [ -z "$1" ] || [ $1 == "vmtranslator" ] ; then
	echo -e "\n\n"
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\t                          \t\t\t"${RESET_FORMATTING}
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\tTestes para o VMTranslator\t\t\t"${RESET_FORMATTING}
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\t                          \t\t\t"${RESET_FORMATTING}
	echo -e "\n"
	mvn-color -f Codigos/VMTranslator package
	let "n_error+=$?"
	python TestesSW/vmtranslator.py -j Codigos/VMTranslator/target/VMTranslator-1.0.jar -t TestesSW/testesVMTranslator.txt -in Codigos/VMTranslator/src/test/resources/ -out TestesSW/vm_code/ -p 3
	let "n_error+=$?"
	python TestesSW/assembler.py -j TestesSW/Assembler/AssemblerZ0.jar -t TestesSW/testesVMTranslator.txt -in TestesSW/vm_code/ -out TestesSW/vm_code/ -p 3
	let "n_error+=$?"
	python TestesSW/emulate.py -t TestesSW/testesVMTranslator.txt -in TestesSW/testesVMTranslator/ -out TestesSW/vm_code/ -p 3
	let "n_error+=$?"
	python -m pytest -v TestesSW/testeVMTranslator.py -rxs
	let "n_error+=$?"
fi

# Testes para codigos em Jack
if [ -z "$1" ] || [ $1 == "jack" ] ; then
	echo -e "\n\n"
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\t                           \t\t\t"${RESET_FORMATTING}
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\tTestes para codigos em Jack\t\t\t"${RESET_FORMATTING}
	echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\t                           \t\t\t"${RESET_FORMATTING}
	echo -e "\n"
	python TestesSW/compiler.py -j TestesSW/Compiler/JackCompiler.jar -t TestesSW/testesJack.txt -in Codigos/Jack/ -out TestesSW/jack_code/ -p 3
	let "n_error+=$?"
	python TestesSW/vmtranslator.py -j TestesSW/VMTranslator/VMTranslator.jar -t TestesSW/testesJack.txt -in TestesSW/jack_code/ -out TestesSW/jack_code/ -p 3
	let "n_error+=$?"
	python TestesSW/assembler.py -j TestesSW/Assembler/AssemblerZ0.jar -t TestesSW/testesJack.txt -in TestesSW/jack_code/ -out TestesSW/jack_code/ -p 3 -b 32
	let "n_error+=$?"
	python TestesSW/emulate.py -t TestesSW/testesJack.txt -out TestesSW/jack_code/ -p 3 -b 32 -r 512,256
	let "n_error+=$?"
	python -m pytest -v TestesSW/testeJack.py -rxs
	let "n_error+=$?"
fi

# Testes para o Compiler
if [ -z "$1" ] || [ $1 == "compiler" ] ; then
	#echo -e "\n\n"
	#echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\t                      \t\t\t"${RESET_FORMATTING}
	#echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\tTestes para o Compiler\t\t\t"${RESET_FORMATTING}
	#echo -e ${TEXT_MAGENTA}${BACKGROUND_CYAN}"\t\t\t                      \t\t\t"${RESET_FORMATTING}
	#echo -e "\n"
	mvn-color -f Codigos/Compiler package
	let "n_error+=$?"
	python TestesSW/compiler.py -j Codigos/Compiler/target/JackCompiler-1.0.jar -t TestesSW/testesCompiler.txt -in Codigos/Compiler/src/test/resources/ -out TestesSW/compiled_code/ -p 3
	let "n_error+=$?"
	python TestesSW/vmtranslator.py -j TestesSW/VMTranslator/VMTranslator.jar -t TestesSW/testesCompiler.txt -in TestesSW/compiled_code/ -out TestesSW/compiled_code/ -p 3
	let "n_error+=$?"
	python TestesSW/assembler.py -j TestesSW/Assembler/AssemblerZ0.jar -t TestesSW/testesCompiler.txt -in TestesSW/compiled_code/ -out TestesSW/compiled_code/ -p 3 -b 32
	let "n_error+=$?"	
	python TestesSW/emulate.py -t TestesSW/testesCompiler.txt -in TestesSW/testesCompiler/ -out TestesSW/compiled_code/ -p 3 -b 32 -r 512,256
	let "n_error+=$?"
	python -m pytest -v TestesSW/testeCompiler.py -rxs
	let "n_error+=$?"
fi

exit $n_error
