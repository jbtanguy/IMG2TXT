# PDF2TXT

A short shell script to process OCR for XVIIth century french textual data using kraken. 

We use the OCR model published by: Simon Gabay, Thibault Clérice, Christian Reul. OCR17: Ground Truth and Models for 17th c. French Prints (and hopefully more). 2020. ⟨hal-02577236⟩
It is available at: https://github.com/e-ditiones/OCR17

Needed: 
- python3
- virtualenv
- pdftoppm library

How to use it?
- ```sh pdf2txt.sh -t```: TXT format as output
- ```sh pdf2txt.sh -h```: HTML format as output
