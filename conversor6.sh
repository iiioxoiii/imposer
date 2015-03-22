#!/bin/bash


# script que permet fer quadernets d'un pdf
# La primera var es el número de quaders, la segona es l'arxiu origen i la tercera el nom de larxiu destí

var=4
PLECS=`expr $1 \* $var`
echo $PLECS

# if [ -a $2 ]; then
# echo "L'arxiu existeix"


# if [$(( $1 % 4 ))] -eq 0; then
# echo "És multiple de quatre"


echo "Info de l'arxiu PDF origen:"
pdfinfo $2

read -p "Prem una tecla per continuar la conversi/ó" escape

echo "convertint a A4 el pdf i després a ps..."
if pdftops -level3 -paper A4 $2 /var/tmp/output.ps
then
	echo "[OK] convertit a ps..."
else
	echo "error"
fi


#posant quadernets.
echo "fent els quadernets de"
if psbook -q -s $PLECS /var/tmp/output.ps /var/tmp/output2.ps
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
conversor= $( ps2pdf /var/tmp/output_A5.ps /home/amos/documents/llibresimposats/$3)

# notificació de l'èxit

rm /var/tmp/output2.ps /var/tmp/output_A5.ps

read -p "Vols passar l\'archiu original a la carpeta \"libres\"  (s/n)?" REPLY
if $REPLY == "s"
then
	mv $1 ~/documents/llibresimposats/originals/$1
fi


