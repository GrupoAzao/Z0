# Curso de Elementos de Sistemas
# Desenvolvido por: Luciano Soares <lpsoares@insper.edu.br>
# Data de criação: 30/03/2017

import subprocess
import loadTestes
import time
import os
import argparse

def emulate(testes,in_dir,out_dir,processos):
	
	processes = set()
	max_processes = processos

	start_time = time.time()

	nomes_testes = loadTestes.testes(testes)

	error = 0
	done = 0

	count = 0

	for j in nomes_testes:

		nome = j.split()
		if int(nome[1]) > 0:
			for i in range(int(nome[1])):
				processes.add(subprocess.Popen(['java', '-jar', 'TestesSW/Elemulator/Elemulator.jar',
					out_dir+"{0}.hack".format(nome[0]),
					"-i",in_dir+"{0}{1}_in.mif".format(nome[0],i),
					"-o",out_dir+"{0}{1}_out.mif".format(nome[0],i),"-c",nome[2]]))
				count += 1
				while count >= max_processes:
					count = 0
					time.sleep(0.1)
					for p in processes:
						if p.poll() is None:
							count += 1
		elif int(nome[1]) == 0:
			processes.add(subprocess.Popen(['java', '-jar', 'TestesSW/Elemulator/Elemulator.jar',
				out_dir+"{0}.hack".format(nome[0]),
				"-i",in_dir+"{0}_in.mif".format(nome[0]),
				"-o",out_dir+"{0}_out.mif".format(nome[0]),"-c",nome[2]]))
			count += 1
			while count >= max_processes:
				count = 0
				time.sleep(0.1)
				for p in processes:
					if p.poll() is None:
						count += 1
		else:
			processes.add(subprocess.Popen(['java', '-jar', 'TestesSW/Elemulator/Elemulator.jar',
				out_dir+"{0}.hack".format(nome[0]),
				"-p",out_dir+"{0}.pbm".format(nome[0],i),
				"-i",in_dir+"{0}_in.mif".format(nome[0],i),
				"-o",out_dir+"{0}_out.mif".format(nome[0],i),"-c",nome[2]]))
			count += 1
			while count >= max_processes:
				count = 0
				time.sleep(0.1)
				for p in processes:
					if p.poll() is None:
						count += 1

	#Check if all the child processes were closed
	for p in processes:
		p.wait()
		if(p.returncode==0):
			done+=1
		else:
			error+=1

	elapsed_time = time.time() - start_time
	print('\033[92m'+"Emulated {0} process(es) in {1:.2f} seconds".format(done,elapsed_time)+'\033[0m') 

	if(error!=0):
		print('\033[91m'+"Failed {0} process(es)".format(error)+'\033[0m')
		exit(error)

if __name__ == "__main__":
	ap = argparse.ArgumentParser()
	ap.add_argument("-t", "--tests", required=True,help="arquivo com lista de testes")
	ap.add_argument("-in", "--in_dir", required=True,help="caminho para codigos")
	ap.add_argument("-out", "--out_dir", required=True,help="caminho para salvar resultado de testes")
	ap.add_argument("-p", "--processos", required=True,help="numero de threads a se paralelizar")
	args = vars(ap.parse_args())
	emulate(testes=args["tests"],in_dir=args["in_dir"],out_dir=args["out_dir"],processos=int(args["processos"]))
