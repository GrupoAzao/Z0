# Curso de Elementos de Sistemas
# Desenvolvido por: Luciano Soares <lpsoares@insper.edu.br>
# Data de criação: 5/04/2017

import argparse
import os

# rotina para traduzir de HACK para MIF
def traduz(nome_arquivo):
	
	with open(nome_arquivo, 'r') as arquivoHack:
		hack = arquivoHack.read().splitlines()

		with open(os.path.splitext(nome_arquivo)[0]+'.mif', 'w') as arquivoMif:

			arquivoMif.write("\nWIDTH=16;\n")
			arquivoMif.write("DEPTH={0};\n".format(len(hack)))

			arquivoMif.write("\nADDRESS_RADIX=UNS;\n")
			arquivoMif.write("DATA_RADIX=BIN;\n")

			arquivoMif.write("\nCONTENT BEGIN\n")

			for idx, val in enumerate(hack):
				if val.strip():
					arquivoMif.write(" {0:5d} : {1}\n".format(idx,val))
					
			arquivoMif.write("END;")


if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("arquivo")
    args = vars(ap.parse_args())
    traduz(args["arquivo"])
