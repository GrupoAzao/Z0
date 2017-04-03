import subprocess
import loadTestes
import time


def emulate():
	
	start_time = time.time()

	nomes_testes = loadTestes.testes("TestesSW/testes.txt")

	error_code = 0
	done = 0

	for j in nomes_testes:

		nome = j.split()
		if int(nome[1]) > 0:
			for i in range(int(nome[1])):
				error = subprocess.call(['java', '-jar', 'TestesSW/Elemulator/Elemulator.jar',
					"TestesSW/machine_code/{0}.hack".format(nome[0]),
					"-i","TestesSW/testesAssembly/{0}{1}_in.mif".format(nome[0],i),
					"-o","TestesSW/machine_code/{0}{1}_out.mif".format(nome[0],i),"-c",nome[2]])
				if(error!=0):
					error_code += error
				else:
					done += 1
		else:
			error = subprocess.call(['java', '-jar', 'TestesSW/Elemulator/Elemulator.jar',
				"TestesSW/machine_code/{0}.hack".format(nome[0]),
				"-p","TestesSW/machine_code/{0}.pbm".format(nome[0],i),
				"-i","TestesSW/testesAssembly/{0}_in.mif".format(nome[0],i),
				"-o","TestesSW/machine_code/{0}_out.mif".format(nome[0],i),"-c",nome[2]])
			if(error!=0):
				error_code += error
			else:
				done += 1

	elapsed_time = time.time() - start_time
	print('\033[92m'+"Emulated {0} file(s) in {1:.2f} seconds".format(done,elapsed_time)+'\033[0m') 

	if(error_code!=0):
		print('\033[91m'+"Failed {0} file(s)".format(len(nomes_testes)-done)+'\033[0m')
		exit(error_code)

if __name__ == '__main__':
	emulate()

