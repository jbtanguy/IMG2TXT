# IMG2TXT

A short shell script to process OCR for XVIIth century french textual data using kraken. 

## Model
We use the OCR model published by: Simon Gabay, Thibault Clérice, Christian Reul. OCR17: Ground Truth and Models for 17th c. French Prints (and hopefully more). 2020. ⟨hal-02577236⟩
It is available at: https://github.com/e-ditiones/OCR17

## Needed 
- python3
- virtualenv
- pdftoppm library

## How to use it?

Launch the script with the following arguments.

### Argument 1
- ```-p```: PDFs in ```./data/```
- ```-P```: PNGs in ```./data/```
- ```-j```: JPGs in ```./data/```
- ```-t```: TIFFs in ```./data/```

### Argument 2
- ```-t```: TXT format as output
- ```-h```: HTML format as output

### Argument 3
- ```-k```: Kraken
- ```-t```: Tesseract

### Argument 4
Paths to the directories where images are stored.
Ex.: ```./data/*/jpg/``` the ```*``` means all the directories in ./data/ that has got a jpg/ directory in it.



### Examples
- ```python3 launch_pipeline_multiple_cores -p -t -k ./data/*/pdf/ ```: OCR is processed with Kraken on PDF documents stored in ```./data/*/pdf/``` directories and the output is in TXT format
- ```python3 launch_pipeline_multiple_cores -j -h -t ./data/*/jpg/```: OCR is processed with Tesseract on JPG documents stored in ```./data/*/jpg/``` directories and the output is in HTML format
