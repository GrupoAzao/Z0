# Checa se testes unitarios passsaram antes de fazer o teste de sistema
# Arquivo: checkUnitTests.py
# Criado por: Luciano Soares <lpsoares@insper.edu.br>
# Data: 10/05/2017

# Verificar se testes unitários passaram
def checkUnitTests(pasta):

	hasErrors = False

	nome_arquivo = pasta+"maven-status/maven-compiler-plugin/testCompile/default-testCompile/createdFiles.lst"

	testesJUnit = []

	# rotina de leitura dos arquivos que fizeram testes
	with open(nome_arquivo, 'r') as arquivo:
		tmp = arquivo.read().splitlines()

		for i in tmp:
			if i.strip():
				str = i.strip();
				str = str.replace("/",".")
				str = str.replace("class","txt")
				testesJUnit.append(str)

	
	for i in testesJUnit:

		# rotina de leitura do arquivo de teste
		with open(pasta+"surefire-reports/"+i, 'r') as arquivo:
			tmp = arquivo.read().splitlines()
			partes = tmp[3].split()
			for i in range(len(partes)):
				if(partes[i]=='Failures:'):
					if(partes[i+1]!='0,'):
						hasErrors = True
				if(partes[i]=='Errors:'):
					if(partes[i+1]!='0,'):
						hasErrors = True
				if(partes[i]=='Skipped:'):
					if(partes[i+1]!='0,'):
						hasErrors = True

	return hasErrors
