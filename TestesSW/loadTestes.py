def testes(nome_arquivo):

	nomes_testes = []

	# rotina de leitura do resultado da emulação
	with open(nome_arquivo, 'r') as arquivo:
		tmp = arquivo.read().splitlines()

		for i in tmp:
			if i.strip():
				if i.strip()[0]!='#':
					nomes_testes.append(i)

	return nomes_testes
