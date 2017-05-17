# Curso de Elementos de Sistemas
# Desenvolvido por: Luciano Soares <lpsoares@insper.edu.br>
# Data de criação: 30/03/2017
	
import subprocess
import loadTestes
import time
import argparse
import os.path

def assembler(testes,in_dir,out_dir,bits,processos):
	
	start_time = time.time()

	subprocess.call(["mkdir", "-p", out_dir])

	nomes_testes = loadTestes.testes(testes)

	error_code = 0
	n_done = 0
	n_error = 0
	n_skiped = 0

	for i in nomes_testes:

		nome = i.split()

		# Testa se arquivos existem, senão pula
		if os.path.exists(in_dir+"{0}.nasm".format(nome[0])):
			rotina = ['java', '-jar', 'TestesSW/Assembler/AssemblerZ0.jar',
				in_dir+"{0}.nasm".format(nome[0]),"-s",
				"-o",out_dir+"{0}.hack".format(nome[0]),
				"-f",out_dir+"{0}.mif".format(nome[0])]
			if bits==32:
				rotina.append("-b")
				rotina.append("32")
			error = subprocess.call(rotina)
			if(error!=0):
				error_code += error
				n_error += 1
			else:
				n_done += 1
		else:
			n_skiped += 1

	elapsed_time = time.time() - start_time
	print('\033[92m'+"Assembled {0} file(s) in {1:.2f} seconds".format(n_done,elapsed_time)+'\033[0m') 

	if(n_skiped!=0):
		print('\033[93m'+"Skipped {0} file(s)".format(n_skiped)+'\033[0m') 

	if(error_code!=0):
		print('\033[91m'+"Failed {0} file(s)".format(n_error)+'\033[0m') 
		exit(error_code)


if __name__ == "__main__":
	ap = argparse.ArgumentParser()
	ap.add_argument("-t", "--tests", required=True,help="arquivo com lista de testes")
	ap.add_argument("-in", "--in_dir", required=True,help="caminho para codigos")
	ap.add_argument("-out", "--out_dir", required=True,help="caminho para salvar resultado de testes")
	ap.add_argument("-p", "--processos", required=True,help="numero de threads a se paralelizar")
	ap.add_argument("-b", "--bits", required=False,help="bits da arquitetura")
	args = vars(ap.parse_args())

	if args["bits"]:
		bita = int(args["bits"])
	else:
		bita=16

	assembler(testes=args["tests"],in_dir=args["in_dir"],out_dir=args["out_dir"],bits=bita,processos=int(args["processos"]))
	
