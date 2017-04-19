#!/bin/sh

python TestesHW/run.py -p3
python TestesSW/assembler.py
python TestesSW/emulate.py
python -m pytest -v TestesSW/teste.py 
mvn -f Codigos/AssemblerZ0 package
python -m pytest -v TestesSW/testeAssembler.py 
