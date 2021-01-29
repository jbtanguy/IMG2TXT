#!/bin/sh
# Prérequis :
# pdftoppm
# python3
# virtualenv

echo "add '-h' to have html file as output"
outType=$1

# 1. Environnement virtuel
if [ ! -d "./venv_kraken/" ]; then
	echo "Création de l'environnment virtuel pour accueillir Kraken."
	mkdir ./venv_kraken/
	virtualenv -p python3 venv_kraken
	. ./venv_kraken/bin/activate
	echo "Environnement virtuel venv_kraken créé.\n\nTéléchargement de Kraken."
	pip3 install kraken
else
	. ./venv_kraken/bin/activate
fi

# 2. Modèle d'OCR
# Simon Gabay, Thibault Clérice, Christian Reul. OCR17: Ground Truth and Models for 17th c. French Prints (and hopefully more). 2020. ⟨hal-02577236⟩
# if [ ! -f "./CORPUS17.mlmodel" ]; then
# 	echo "Téléchargement du modèle d'OCR."
# 	wget https://zenodo.org/record/3826894/files/OCR17.zip?download=1 -O CORPUS17.mlmodel
# fi

# 3. Segmentation des pages
for file in `ls ./data/*.pdf`; do pdftoppm -png $file $file; done

# 4. Binarisation des images
for file in `ls ./data/*.png`; do kraken -i $file $file"_bin.png" binarize; done

# 5. Segmentation et OCR
if [ $outType = "-h" ]; then
	for file in `ls ./data/*_bin.png`; do kraken -i $file $file".html" segment ocr -m ./CORPUS17.mlmodel -h; done
else
	for file in `ls ./data/*_bin.png`; do kraken -i $file $file".txt" segment ocr -m ./CORPUS17.mlmodel; done
fi

# 6. Rangement des fichiers de sorties
if [ -d "./out/" ]; then
	rm -R ./out/
fi
mkdir ./out/ ./out/pdf/ ./out/png/
if [ $outType = "-h" ]; then
	mkdir ./out/html/
else
	mkdir ./out/txt/
fi
cd ./data/
# PDF
for file in `ls *.pdf`; do mv $file ./../out/pdf/$file; done
# PNG 
for file in `ls *.png`; do mv $file ./../out/png/$file; done
# HTML
if [ $outType = "-h" ]; then
	for file in `ls *.html`; do mv $file ./../out/html/$file; done
else # TXT
	for file in `ls *.txt`; do mv $file ./../out/txt/$file; done
fi
