#!/usr/bin/env python
# -*- coding: utf-8 -*-

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
					if (hack[idx][0]=='1') and (hack[idx][13:16]!="000"):
						if idx<len(hack)-1 :
							if hack[idx+1].strip():
								if (hack[idx+1][0]!='1') or (hack[idx+1][10:16]!="000000"):
									print("WARNING: código não roda no Z0, jump sem NOP na seqüência, linha {0}.".format(idx))
						else:
							print("WARNING: última linha possui um jump sem um NOP após.")
					if (hack[idx][0]=='1') and (hack[idx][3]=='1') and (hack[idx][12]=='1'):
						print("WARNING: código não roda no Z0, lendo e gravando na RAM ao mesmo tempo, linha {0}.".format(idx))
				else:
					break
					
			arquivoMif.write("END;")


if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("arquivo")
    args = vars(ap.parse_args())
    traduz(args["arquivo"])
