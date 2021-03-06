#!/bin/bash


# script que permet fer quadernets d'un pdf
# 1) Es canvia l'arxiu de format pdf a ps
# 2) Es canvia la mida d'A4

echo "Script de creació de quadernets"
echo "Indica el nom de l/'arxiu que vols imposar:"

read -p "Enter: " name
name=${name:-llibre.pdf}

echo "Aquesta es la info de l'arxiu triat:"
pdfinfo $name

read -p "Prem una tecla per continuar la conversi/ó" escape

echo "convertint a A4 el pdf i després a ps..."
if pdftops -level3 -paper A4 $name /var/tmp/output.ps
then
	echo "[OK] convertit a ps..."
else
	echo "error"
fi


#posant quadernets.
echo "fent els quadernets de 10"
if psbook -q -s40 /var/tmp/output.ps /var/tmp/output2.ps
then
        echo "[OK]"
else
        echo "error"
fi


# imposicio
echo "posant 2 pagines en A5 per full..."
if psnup -pa4 -2 /var/tmp/output2.ps /var/tmp/output_A5.ps
then
        echo "[OK]"
else
        echo "error"
fi


# convertir una altra vegada a pdf
echo "convertint a pdf..."
conversor= $( ps2pdf /var/tmp/output_A5.ps final_$name )

# notificació de l'èxit

echo "Felicitats!!. L'arxiu" final_$name "ja està llest per ser imprès"

read -p "Ja que has convertit pdf en llibre, vols esborrar l'arxiu original (s/n)?" REPLY
if $REPLY == "s"
then
	rm $name | echo $name "esborrat!"
else
	echo "[OK]"
fi


