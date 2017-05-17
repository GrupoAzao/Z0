# Curso de Elementos de Sistemas
# Desenvolvido por: Luciano Soares <lpsoares@insper.edu.br>
# Data de criação: 30/03/2017

import subprocess
import loadTestes
import time
import os
import argparse

def emulate(testes,in_dir,out_dir,bits,processos,resolution):
	
	processes = set()
	max_processes = processos

	start_time = time.time()

	nomes_testes = loadTestes.testes(testes)

	n_error = 0
	n_done = 0
	n_skiped = 0

	count = 0

	for j in nomes_testes:

		nome = j.split()
		if int(nome[1]) > 0:
			for i in range(int(nome[1])):

				# Testa se arquivos existem, senão pula
				if os.path.exists(out_dir+"{0}.hack".format(nome[0])):

					rotina = ['java', '-jar', 'TestesSW/Elemulator/Elemulator.jar',
						out_dir+"{0}.hack".format(nome[0]),
						"-i",in_dir+"{0}{1}_in.mif".format(nome[0],i),
						"-o",out_dir+"{0}{1}_out.mif".format(nome[0],i),"-c",nome[2]]
					if bits==32:
						rotina.append("-b")
						rotina.append("32")

					print("\nEmulating: "+nome[0]+" >> Exec: "+" ".join(rotina))
					processes.add(subprocess.Popen(rotina))
					count += 1
					while count >= max_processes:
						count = 0
						time.sleep(0.1)
						for p in processes:
							if p.poll() is None:
								count += 1
				else:
					n_skiped += 1

		elif int(nome[1]) == 0:	# caso só um teste

			# Testa se arquivos existem, senão pula
			if os.path.exists(out_dir+"{0}.hack".format(nome[0])):

				rotina = ['java', '-jar', 'TestesSW/Elemulator/Elemulator.jar',
					out_dir+"{0}.hack".format(nome[0]),
					"-i",in_dir+"{0}_in.mif".format(nome[0]),
					"-o",out_dir+"{0}_out.mif".format(nome[0]),"-c",nome[2]]
				if bits==32:
					rotina.append("-b")
					rotina.append("32")

				print("\nEmulating: "+nome[0]+" >> Exec: "+" ".join(rotina))
				processes.add(subprocess.Popen(rotina))
				count += 1
				while count >= max_processes:
					count = 0
					time.sleep(0.1)
					for p in processes:
						if p.poll() is None:
							count += 1
			else:
				n_skiped += 1

		else:	# caso saida gráfica

			# Testa se arquivos existem, senão pula
			if os.path.exists(out_dir+"{0}.hack".format(nome[0])):

				rotina = ['java', '-jar', 'TestesSW/Elemulator/Elemulator.jar',
					out_dir+"{0}.hack".format(nome[0]),
					"-p",out_dir+"{0}.pbm".format(nome[0]),
					"-o",out_dir+"{0}_out.mif".format(nome[0]),
					"-c",nome[2],"-r",resolution[0],resolution[1]]

				if in_dir:
					rotina.append("-i")
					rotina.append(in_dir+"{0}_in.mif".format(nome[0]))
				if bits==32:
					rotina.append("-b")
					rotina.append("32")

				print("\nEmulating: "+nome[0]+" >> Exec: "+" ".join(rotina))
				processes.add(subprocess.Popen(rotina))
				count += 1
				while count >= max_processes:
					count = 0
					time.sleep(0.1)
					for p in processes:
						if p.poll() is None:
							count += 1
			else:
				n_skiped += 1

	#Check if all the child processes were closed
	for p in processes:
		p.wait()
		if(p.returncode==0):
			n_done+=1
		else:
			n_error+=1

	# exibe as imagens no terminal
	for i in nomes_testes:
		nome = i.split()
		if int(nome[1]) < 0:
			subprocess.call(['echo',"\n{0}.pbm".format(nome[0],i)])
			subprocess.call(['img2txt',out_dir+"{0}.pbm".format(nome[0],i)])

	elapsed_time = time.time() - start_time
	print('\033[92m'+"Emulated {0} process(es) in {1:.2f} seconds".format(n_done,elapsed_time)+'\033[0m') 

	if(n_skiped!=0):
		print('\033[93m'+"Skipped {0} file(s)".format(n_skiped)+'\033[0m') 

	if(n_error!=0):
		print('\033[91m'+"Failed {0} process(es)".format(n_error)+'\033[0m')
		exit(n_error)

if __name__ == "__main__":
	ap = argparse.ArgumentParser()
	ap.add_argument("-t", "--tests", required=True,help="arquivo com lista de testes")
	ap.add_argument("-in", "--in_dir", required=False,help="caminho para codigos")
	ap.add_argument("-out", "--out_dir", required=True,help="caminho para salvar resultado de testes")
	ap.add_argument("-p", "--processos", required=True,help="numero de threads a se paralelizar")
	ap.add_argument("-r", "--resolution", required=False,help="resolução em X e Y")
	ap.add_argument("-b", "--bits", required=False,help="bits da arquitetura")
	args = vars(ap.parse_args())
	proc = int(args["processos"])

	if args["bits"]:
		bita = int(args["bits"])
	else:
		bita=16

	if args["resolution"] != None:
		res = args["resolution"].split(",")
	else:
		res = ['320', '240']	# valor padrão
	emulate(testes=args["tests"],in_dir=args["in_dir"],out_dir=args["out_dir"],bits=bita,processos=proc,resolution=res)
