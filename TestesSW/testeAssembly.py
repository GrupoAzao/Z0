# Testador de emulação
# Arquivo: testComp.nasm
# Criado por: Luciano Soares <lpsoares@insper.edu.br>
# Data: 16/03/2017

import sys, getopt
import unittest
import pytest
import loadTestes
import detectImage

nomes_testes = loadTestes.testes("TestesSW/testesAssembly.txt")

@pytest.mark.parametrize(('nomes_testes'),nomes_testes)
def test_Assembly(nomes_testes):

	nomes_testes = nomes_testes.split()

	if int(nomes_testes[1]) > 0:

		for i in range(int(nomes_testes[1])):

			resultado = "TestesSW/machine_code/{0}{1}_out.mif".format(nomes_testes[0],i)
			teste = "TestesSW/testesAssembly/{0}{1}_tst.mif".format(nomes_testes[0],i)
			debug = False

			ram = {}
			validacao = {}

			# rotina de leitura do resultado da emulação
			with open(resultado, 'r') as arquivo:
				linhas = arquivo.read().splitlines()

				for linha in linhas:
					alocacao = linha.split(":")
					ram[int(alocacao[0].strip())] = int("0b"+alocacao[1].strip(),2)
				
				if debug:
					print("RAM")
					for e,v in ram.items():
						print("|{0}|  =>  |{1:016b}|".format(e,v))
					print("\n")

			# rotina do teste da emulação
			with open(teste, 'r') as arquivo:
				linhas = arquivo.read().splitlines()

				for linha in linhas:
					alocacao = linha.split(":")
					validacao[int(alocacao[0].strip())] = int("0b"+alocacao[1].strip(),2)
				
				if debug:
					print("Teste")
					for e,v in validacao.items():
						print("|{0}|  =>  |{1:016b}|".format(e,v))
					print("\n")

				for e,v in validacao.items():
					assert (v==ram[e]),"Erro: {0}{1} RAM[{2}]={3:016b}, valor esperado ({4:016b})".format(nomes_testes[0],i,e,ram[e],v)	

	else:

		resultado = "TestesSW/machine_code/{0}_out.mif".format(nomes_testes[0])
		teste = "TestesSW/testesAssembly/{0}_tst.txt".format(nomes_testes[0])
		imagem = "TestesSW/machine_code/{0}.pbm".format(nomes_testes[0])
		debug = False

		linha = []
		# rotina do teste da emulação
		with open(teste, 'r') as arquivo:
			linhas = arquivo.read().splitlines()
			linha = linhas[0].split()

		tipo = "não reconhecido"
		poligonos = detectImage.maxpoly(imagem)
		if poligonos == 1:
			tipo = "ponto"
		elif poligonos == 2:
			tipo = "linha"
		elif poligonos == 3:
			tipo = "triângulo"
		elif poligonos == 4:
			tipo = "quadrado"
		elif poligonos == 5:
			tipo = "pentágono"
		elif poligonos == 6:
			tipo = "hexágono"
		elif poligonos > 6:
			tipo = "poligono com mais de 6 faces"
		
		assert (poligonos>=3),"Erro: {0} Geometria Detectada={1}, geometria esperada ({2})".format(nomes_testes[0],tipo,linha[0])	


