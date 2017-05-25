@echo off
rem Todos os Testes do Z0
rem Arquivo: tests.bat
rem Criado por: Luciano Soares <lpsoares@insper.edu.br>
rem Data: 18/05/2017

rem Testes para VHDL
set vhdl=F
if "%1"=="" set vhdl=T
if "%~1"=="vhdl" set vhdl=T
if "%vhdl%"=="T" (
	echo.
	echo "Testes para VHDL"
	echo.
	python TestesHW/run.py -p3
)

rem Testes para codigos em Assembly
set assembly=F
if "%1"=="" set assembly=T
if "%~1"=="assembly" set assembly=T
if "%assembly%"=="T" (
	echo.
	echo "Testes para codigos em Assembly"
	echo.
	python TestesSW/assembler.py -j TestesSW/Assembler/AssemblerZ0.jar -t TestesSW/testesAssembly.txt -in Codigos/Assembly/ -out TestesSW/machine_code/ -p 3
	python TestesSW/emulate.py -t TestesSW/testesAssembly.txt -in TestesSW/testesAssembly/ -out TestesSW/machine_code/ -p 3 -r 512,256
	python -m pytest -v TestesSW/testeAssembly.py -rxs
)

rem Testes para AssemblerZ0
set assembler=F
if "%1"=="" set assembler=T
if "%~1"=="assembler" set assembler=T
if "%assembler%"=="T" (
	echo.
	echo "Testes para AssemblerZ0"
	echo.
	mvn -f Codigos/AssemblerZ0 package
	python -m pytest -v TestesSW/testeAssembler.py -rxs
)


rem Testes para o VMTranslator
set vmtranslator=F
if "%1"=="" set vmtranslator=T
if "%~1"=="vmtranslator" set vmtranslator=T
if "%vmtranslator%"=="T" (
	echo.
	echo "Testes para o VMTranslator"
	echo.
	mvn -f Codigos/VMTranslator package
	python TestesSW/vmtranslator.py -j Codigos/VMTranslator/target/VMTranslator-1.0.jar -t TestesSW/testesVMTranslator.txt -in Codigos/VMTranslator/src/test/resources/ -out TestesSW/vm_code/ -p 3
	python TestesSW/assembler.py -j TestesSW/Assembler/AssemblerZ0.jar -t TestesSW/testesVMTranslator.txt -in TestesSW/vm_code/ -out TestesSW/vm_code/ -p 3
	python TestesSW/emulate.py -t TestesSW/testesVMTranslator.txt -in TestesSW/testesVMTranslator/ -out TestesSW/vm_code/ -p 3
	python -m pytest -v TestesSW/testeVMTranslator.py -rxs
)


rem Testes para codigos em Jack
set jack=F
if "%1"=="" set jack=T
if "%~1"=="jack" set jack=T
if "%jack%"=="T" (
	echo.
	echo "Testes para codigos em Jack"
	echo.
	python TestesSW/compiler.py -t TestesSW/testesJack.txt -in Codigos/Jack/ -out TestesSW/jack_code/ -p 3
	python TestesSW/vmtranslator.py -j TestesSW/VMTranslator/VMTranslator.jar -t TestesSW/testesJack.txt -in TestesSW/jack_code/ -out TestesSW/jack_code/ -p 3
	python TestesSW/assembler.py -j TestesSW/Assembler/AssemblerZ0.jar -t TestesSW/testesJack.txt -in TestesSW/jack_code/ -out TestesSW/jack_code/ -p 3 -b 32
	python TestesSW/emulate.py -t TestesSW/testesJack.txt -out TestesSW/jack_code/ -p 3 -b 32 -r 512,256
	python -m pytest -v TestesSW/testeJack.py -rxs
)

rem Testes para o Compiler
set compiler=F
if "%1"=="" set compiler=T
if "%~1"=="compiler" set compiler=T
if "%compiler%"=="T" (
	echo.
	echo "Testes para o Compiler"
	echo.
	mvn-color -f Codigos/Compiler package
	python TestesSW/compiler.py -j Codigos/Compiler/target/JackCompiler-1.0.jar -t TestesSW/testesCompiler.txt -in Codigos/Compiler/src/test/resources/ -out TestesSW/compiled_code/ -p 3
	python TestesSW/vmtranslator.py -j TestesSW/VMTranslator/VMTranslator.jar -t TestesSW/testesCompiler.txt -in TestesSW/compiled_code/ -out TestesSW/compiled_code/ -p 3
	python TestesSW/assembler.py -j TestesSW/Assembler/AssemblerZ0.jar -t TestesSW/testesCompiler.txt -in TestesSW/compiled_code/ -out TestesSW/compiled_code/ -p 3 -b 32
	python TestesSW/emulate.py -t TestesSW/testesCompiler.txt -in TestesSW/testesCompiler/ -out TestesSW/compiled_code/ -p 3 -b 32 -r 512,256
	python -m pytest -v TestesSW/testeCompiler.py -rxs
)
