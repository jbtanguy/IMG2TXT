# IMG2TXT

A short shell script to process OCR for XVIIth century french textual data using kraken. 

##Model
We use the OCR model published by: Simon Gabay, Thibault Clérice, Christian Reul. OCR17: Ground Truth and Models for 17th c. French Prints (and hopefully more). 2020. ⟨hal-02577236⟩
It is available at: https://github.com/e-ditiones/OCR17

##Needed 
- python3
- virtualenv
- pdftoppm library

##How to use it?

First, create a directory named ```./data/``` and store your PDF in it. Then, launch the script with the following arguments.

###Argument 1
- ```-p```: PDFs in ```./data/```
- ```-j```: JPGs in ```./data/```
- ```-t```: TIFFs in ```./data/```

###Argument 2
- ```-t```: TXT format as output
- ```-h```: HTML format as output

###Examples
- ```sh pdf2txt.sh -p -t```: OCR is processed on PDF documents and the output is in TXT format
- ```sh pdf2txt.sh -j -h```: OCR is processed on JPG documents and the output is in HTML format
