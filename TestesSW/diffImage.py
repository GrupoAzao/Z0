#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Curso de Elementos de Sistemas
# Desenvolvido por: Luciano Soares <lpsoares@insper.edu.br>
# Data de criação: 24/05/2017

import cv2

def diffImage(image1,image2):
    img1 = cv2.imread(image1)
    img2 = cv2.imread(image2)
    diff = int(cv2.norm( img1, img2));
    if diff == 0:
        return True
    return False

if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("-i", "--image1", required=True,help="caminho para a imagem")
    ap.add_argument("-t", "--image2", required=True,help="caminho para a imagem")
    args = vars(ap.parse_args())
    print(diffImage(args["image1"],args["image2"]))