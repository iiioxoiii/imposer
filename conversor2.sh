#!/bin/bash


# script que permet fer quadernets d'un pdf
# 1) Es canvia l'arxiu de format pdf a ps
# 2) Es canvia la mida d'A4


echo "Indica el nom de l'arxiu a imposar:"
read -p "Enter: " name
name=${name:-llibre.pdf}

pdfinfo $name

read -p "Prem una tecla per continuar..." escape

echo "convertint de pdf a ps..."

if pdftops -paper A4 $name output.ps

then
	echo "[OK]"
else
	echo "error"
fi


#posant quadernets.

echo "fent quadernets..."
if psbook -q -s4 output.ps output2.ps
then
        echo "[OK]"
else
        echo "error"
fi

# imposicio
echo "posant 2 pagines per full..."
if psnup -pa4 -2 output2.ps output_A5.ps
then
        echo "[OK]"
else
        echo "error"
fi

rm output.ps

# convertir una altra vegada a pdf
echo "convertint a pdf..."
if ps2pdf output_A5.ps | pv > final_$name | mplayer /home/amos/music/Sponge.mp3
then
	echo "[OK]"
else
	echo "error"
fi

rm output_A5.ps

echo "Felicitats!!. Ha sigut creat amb exit l'arxiu" final_$name

read -p "Ja que has convertit pdf en llibre, vols esborrar l'arxiu original (s/n)?" REPLY
if $REPLY == "s"
then
	rm $name | echo $name "esborrat!"
else
	echo "[OK]"
fi

