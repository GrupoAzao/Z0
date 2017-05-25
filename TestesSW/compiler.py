#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Curso de Elementos de Sistemas
# Desenvolvido por: Luciano Soares <lpsoares@insper.edu.br>
# Data de criação: 6/05/2017
	
import subprocess
import loadTestes
import time
import argparse
import platform

def compiler(jar,testes,in_dir,out_dir,processos):
	
	start_time = time.time()

	rotina_mkdir = ["mkdir"]

	shell=False

	if platform.system()=="Windows":
		testes = testes.replace('/','\\')
		in_dir = in_dir.replace('/','\\')
		out_dir = out_dir.replace('/','\\')
		shell=True
	else:
		rotina_mkdir.append("-p") # para criar os subdiretórios no mkdir no UNIX

	rotina_mkdir.append(out_dir)

	subprocess.call(rotina_mkdir, shell=shell) # cria subdiretório para resultados

	nomes_testes = loadTestes.testes(testes)

	error_code = 0
	done = 0

	for i in nomes_testes:

		nome = i.split()
		
		directory = False

		for f in range(3,len(nome)):
			if(nome[f]=="/"):
				directory = True

		if directory:
			entrada = in_dir+"{0}".format(nome[0])
		else:
			entrada = in_dir+"{0}.jack".format(nome[0])
		
		saida = out_dir+"{0}".format(nome[0])

		rotina = ['java', '-jar', jar, entrada,"-o",saida]

		if platform.system()=="Windows":
			subprocess.call(["mkdir", out_dir+nome[0]], shell=True)
			subprocess.call(["copy","/Y","TestesSW\\OS\\*.vm",out_dir+nome[0]],shell=True)
		else:
			subprocess.call(["mkdir", "-p", out_dir+nome[0]])
			subprocess.call(["cp {0} {1}".format("TestesSW/OS/*.vm",out_dir+nome[0]	)],shell=True)

		error = subprocess.call(rotina,shell=shell)
		if(error!=0):
			error_code += error
		else:
			done += 1
	

	elapsed_time = time.time() - start_time
	print('\033[92m'+"Compiled {0} file(s) in {1:.2f} seconds".format(done,elapsed_time)+'\033[0m') 

	if(error_code!=0):
		print('\033[91m'+"Failed {0} file(s)".format(len(nomes_testes)-done)+'\033[0m') 
		exit(error_code)

	
if __name__ == "__main__":
	ap = argparse.ArgumentParser()
	ap.add_argument("-j", "--jar", required=True,help="arquivo jar para executar")
	ap.add_argument("-t", "--tests", required=True,help="arquivo com lista de testes")
	ap.add_argument("-in", "--in_dir", required=True,help="caminho para codigos")
	ap.add_argument("-out", "--out_dir", required=True,help="caminho para salvar resultado de testes")
	ap.add_argument("-p", "--processos", required=True,help="numero de threads a se paralelizar")
	args = vars(ap.parse_args())
	compiler(jar=args["jar"],testes=args["tests"],in_dir=args["in_dir"],out_dir=args["out_dir"],processos=int(args["processos"]))
	
