# Testador do Assembler
# Arquivo: testAssembler.py
# Criado por: Luciano Soares <lpsoares@insper.edu.br>
# Data: 16/03/2017

import sys, getopt
import unittest
import pytest	
import subprocess

def loadTestesAssembler(nome_arquivo):

	nomes_testes = []

	# rotina de leitura dos arquivos para realizar o assembler
	with open(nome_arquivo, 'r') as arquivo:
		tmp = arquivo.read().splitlines()

		for i in tmp:
			if i.strip():
				if i.strip()[0]!='#':
					nomes_testes.append(i)

	return nomes_testes

nomes_testes = loadTestesAssembler("TestesSW/testesAssembler.txt")

@pytest.mark.parametrize(('nomes_testes'),nomes_testes)
def test_Assembler(nomes_testes):

	out_dir = "TestesSW/machine_code/"

	subprocess.call(["mkdir", "-p", out_dir])

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
		assert (dic_int[str(n)]==dic_ext[str(n)]),"instrução {0} diferente".format(n)

