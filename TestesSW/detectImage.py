# Curso de Elementos de Sistemas
# Desenvolvido por: Luciano Soares <lpsoares@insper.edu.br>
# Data de criação: 30/03/2017

import cv2
import imutils

WHITE = [255,255,255]

def maxpoly(name):
    img = cv2.imread(name)    
    img_B = cv2.copyMakeBorder(img,6,6,6,6,cv2.BORDER_CONSTANT,value=WHITE)
    gray = cv2.cvtColor(img_B, cv2.COLOR_BGR2GRAY)
    ret,thresh = cv2.threshold(gray,60,255,1)
    contours = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_SIMPLE)
    contours = contours[0] if imutils.is_cv2() else contours[1]
    poly = 0
    for cnt in contours:
        peri = cv2.arcLength(cnt, True)
        approx = cv2.approxPolyDP(cnt, 0.01 * peri, True)
        if len(approx) > poly:
            poly = len(approx)

    return poly


if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("-i", "--image", required=True,help="caminho para a imagem")
    args = vars(ap.parse_args())
    print(maxpoly(args["image"]))