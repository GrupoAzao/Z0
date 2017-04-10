# Curso de Elementos de Sistemas
# Desenvolvido por: Luciano Soares <lpsoares@insper.edu.br>
# Data de criação: 30/03/2017
	
import subprocess
import loadTestes
import time

def assembler():
	
	start_time = time.time()

	subprocess.call(["mkdir", "-p", "TestesSW/machine_code"])

	nomes_testes = loadTestes.testes("TestesSW/testes.txt")

	error_code = 0
	done = 0

	for i in nomes_testes:

		nome = i.split()
		error = subprocess.call(['java', '-jar', 'TestesSW/Assembler/AssemblerZ0.jar',
			"Codigos/Assembly/{0}.nasm".format(nome[0]),"-s",
			"-o","TestesSW/machine_code/{0}.hack".format(nome[0]),
			"-f","TestesSW/machine_code/{0}.mif".format(nome[0])])
		if(error!=0):
			error_code += error
		else:
			done += 1

	elapsed_time = time.time() - start_time
	print('\033[92m'+"Assembled {0} file(s) in {1:.2f} seconds".format(done,elapsed_time)+'\033[0m') 

	if(error_code!=0):
		print('\033[91m'+"Failed {0} file(s)".format(len(nomes_testes)-done)+'\033[0m') 
		exit(error_code)


if __name__ == '__main__':
	assembler()

