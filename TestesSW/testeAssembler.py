#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Testador do Assembler
# Arquivo: testAssembler.py
# Criado por: Luciano Soares <lpsoares@insper.edu.br>
# Data: 16/03/2017

import sys, getopt
import unittest
import pytest	
import subprocess
import loadTestes
import checkUnitTests
import platform

# Rotinas para carregar os testes
nomes_testes = loadTestes.testes("TestesSW/testesAssembler.txt")

# Testes a serem realizados
@pytest.mark.skipif(checkUnitTests.checkUnitTests("Codigos/AssemblerZ0/target/"),
	reason="Testes unitários anteriores não passaram por completo, não executando teste de sistema.")
@pytest.mark.parametrize(('nomes_testes'),nomes_testes)
def test_Assembler(nomes_testes):

	out_dir = "TestesSW/machine_code/"

	rotina_mkdir = ["mkdir"]
	shell=False

	if platform.system()=="Windows":
		out_dir = out_dir.replace('/','\\')
		shell=True
	else:
		rotina_mkdir.append("-p") # para criar os subdiretórios no mkdir no UNIX

	rotina_mkdir.append(out_dir)

	subprocess.call(rotina_mkdir, shell=shell) # cria subdiretório para resultados


	# Assembler interno (desenvolvido por professor)
	error = subprocess.call(['java', '-jar', 'TestesSW/Assembler/AssemblerZ0.jar',
		"TestesSW/testesAssembly/{0}.nasm".format(nomes_testes),
		"-f",out_dir+"{0}_int.mif".format(nomes_testes)])
	assert (error==0),"Problema de execução interna do Assembler com arquivo {0}".format(nomes_testes)	

	# Assembler externo (desenvolvido por alunos)
	error = subprocess.call(['java', '-jar', 'Codigos/AssemblerZ0/target/AssemblerZ0-1.0.jar',
		"TestesSW/testesAssembly/{0}.nasm".format(nomes_testes),
		"-f",out_dir+"{0}_ext.mif".format(nomes_testes)])
	assert (error==0),"Problema de execução do Assembler com arquivo {0}".format(nomes_testes)	

	linhas_int = []
	with open(out_dir+"{0}_int.mif".format(nomes_testes), 'r') as arquivo_int:
		linhas_int = arquivo_int.read().splitlines()
	
	linhas_ext = []
	with open(out_dir+"{0}_ext.mif".format(nomes_testes), 'r') as arquivo_ext:
		linhas_ext = arquivo_ext.read().splitlines()
	
	dic_int = {}
	sep = "="
	for i in linhas_int:
		print(i)
		if i.strip():
			if i.strip()[:13]=="CONTENT BEGIN":
				sep = ":"
			elif i.strip()[:4]=="END;":
				break;
			else:
				dic_int[i.split(sep)[0].strip()]=i.split(sep)[1].strip()
	
	dic_ext = {}
	sep = "="
	for i in linhas_ext:
		print(i)
		if i.strip():
			if i.strip()[:13]=="CONTENT BEGIN":
				sep = ":"
			elif i.strip()[:4]=="END;":
				break;
			else:
				dic_ext[i.split(sep)[0].strip()]=i.split(sep)[1].strip()
		
	assert (dic_int["WIDTH"]==dic_ext["WIDTH"]),"WIDTH diferente"
	assert (dic_int["DEPTH"]==dic_ext["DEPTH"]),"DEPTH diferente"

	# na verdade os dados podem estar em formatos diferente, mas pelo momento quero que sejam iguais aos meus
	assert (dic_int["ADDRESS_RADIX"]==dic_ext["ADDRESS_RADIX"]),"ADDRESS_RADIX diferente"
	assert (dic_int["DATA_RADIX"]==dic_ext["DATA_RADIX"]),"DATA_RADIX diferente"

	for n in range( int(dic_int["DEPTH"][:-1]) ): 
		if dic_int[str(n)][13:16]=="111":  # caso um jump incondicional o calculo é irrelevante
			assert (dic_int[str(n)][10:]==dic_ext[str(n)][10:]),"instrução {0} diferente".format(n)
		else:
			assert (dic_int[str(n)]==dic_ext[str(n)]),"instrução {0} diferente".format(n)

