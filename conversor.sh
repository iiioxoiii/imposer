#!/bin/bash

echo "Indica l'arxiu:"

# convertir el pdf en un ps
echo "canviant de format..."

pdftops <arxiu pdf>

#convertir l'arxiu generat de A4 a A5
echo "canviant de mida..."
psbook nuestro_libro.pdf.ps | psnup -pa4 -2 > nuestro_libro_A5.ps

#convertir una altra vegada a pdf
echo "convertint a pdf..."
ps2pdf nuestro_libro_A5.ps nuestro_libro_A5.pdf
