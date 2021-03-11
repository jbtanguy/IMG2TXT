#!/bin/sh
# Prérequis :
# pdftoppm
# python3
# virtualenv

inType=$1 # -p (PDF) -j (JPG) -t (TIF)
outType=$2 # -t (TXT) -h (HTML)
dir_path=$3

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
if [ $inType = "-p" ]; then
	for file in `ls $dir_path*.pdf`; do pdftoppm -png $file $file; done
fi

# 4. Binarisation des images
if [ $inType = "-p" ]; then
	for file in `ls $dir_path*.png`; do kraken -i $file $file"_bin.png" binarize; done
elif [ $inType = "-j" ]; then
	for file in `ls $dir_path*.jpg`; do kraken -i $file $file"_bin.png" binarize; done
elif [ $inType = "-t" ]; then
	for file in `ls $dir_path*.tif`; do kraken -i $file $file"_bin.png" binarize; done
fi

# 5. Segmentation et OCR
if [ $outType = "-t" ]; then
	for file in `ls $dir_path*_bin.png`; do kraken -i $file $file".txt" segment ocr -m ./CORPUS17.mlmodel; done
else
	for file in `ls $dir_path*_bin.png`; do kraken -i $file $file".html" segment ocr -m ./CORPUS17.mlmodel -h; done
fi

# 6. Rangement des fichiers de sorties
# Suppression des outputs des processus antérieurs
if [ -d "./out/" ]; then
	rm -R ./out/
fi
# Création des dossiers pour les output
mkdir ./out/
mkdir ./out/png/
if [ $outType = "-h" ]; then
	mkdir ./out/html/
else
	mkdir ./out/txt/
fi
cd $dir_path
# PNG 
for file in `ls *.png`; do mv $file ./../out/png/$file; done
# HTML
if [ $outType = "-h" ]; then
	for file in `ls *.html`; do mv $file ./../out/html/$file; done
else # TXT
	for file in `ls *.txt`; do mv $file ./../out/txt/$file; done
fi