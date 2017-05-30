#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Testador de emulação
# Arquivo: testJack.nasm
# Criado por: Luciano Soares <lpsoares@insper.edu.br>
# Data: 13/05/2017

##############################
#                            #
#  Baseado no testAssembly   #
# tentar unificar no futuro  #
#                            #
##############################

import sys, getopt
import unittest
import pytest
import loadTestes
import detectImage
import checkUnitTests

nomes_testes = loadTestes.testes("TestesSW/testesJack.txt")

@pytest.mark.parametrize(('nomes_testes'),nomes_testes)
def test_Assembly(nomes_testes):

	dir_dados = "TestesSW/jack_code/"

	nomes_testes = nomes_testes.split()

	#resultado = dir_dados+"{0}_out.mif".format(nomes_testes[0])
	teste = "TestesSW/testesJack/{0}_tst.txt".format(nomes_testes[0])
	imagem = dir_dados+"{0}.pbm".format(nomes_testes[0])
	#debug = False

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


