import os
import sys
import glob
import re

def has_all_ocr(path, ext_in, ext_out):
    has_all = False
    liste_in = glob.glob(f"{path}/*." + ext_in)
    img = len(liste_in)
    liste_out = glob.glob(f"{path}/*." + ext_out)
    ocr = len(liste_out)
    if ocr == img:
        has_all = True
    return has_all

if __name__ == '__main__':
    if len(sys.argv) > 4:
        inType = sys.argv[1]
        outType = sys.argv[2]
        engine = sys.argv[3]
        paths = sys.argv[4:]
        
        paths = [path for path in paths if has_all_ocr(path) == False]

        i = 0
        NB_core = 3
        while i < len(paths):
            batch = paths[i:i+NB_core]
            list_cmd = ["./img2txt.sh " + inType + " " + outType + " " + engine + " %s/" % path for path in batch]
            cmd = " & ".join(liste)
            os.system(cmd)
            i += NB_core
    else:
        print("You must give 4 arguments.\n",
            "1: -p (PDF) or -j (JPG) or -P (PNG) or -t (TIF)\n",
            "2: -t (TXT) or -h (HTML or XML-alto)\n",
            "3: -k (Kraken), -t (Tesseract)\n",
            "4: paths to your data (intension paths, with *\n"
            )
