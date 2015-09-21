#!/bin/sh

# Auteur : Skippythekangoo
# Contact jabber : Skippythekangoo CHEZ jabber POINT fr 
# Contact courriel : Skippythekangoo CHEZ yahoo POINT fr

# http://serverfault.com/questions/461203/how-to-use-hdparm-to-fix-a-pending-sector

# Repère et "répare" les blocks defectueux d'un disque dur
# Bien vérifier qu'aucune partition ne soit montées sur le disque à réparer.

#baddrive=/dev/sda
#badsect=1
baddrive=$1
badsect=$2

echo "disque $baddrive"
echo "secteur $badsect"

while true; do
  # stop tout les jobs de smarctl sur $baddrive
  smartctl -X $baddrive 2>&1 >> /dev/null
  #echo Testing from LBA $badsect
  echo Test de LBA $badsect
  smartctl -t select,${badsect}-max ${baddrive} 2>&1 >> /dev/null

  #echo "Waiting for test to stop (each dot is 5 sec)"
  echo "Attente de la fin du test (chaque point représente 5 secondes)"
  while [ "$(smartctl -l xselftest $baddrive | awk '/# 1  Selective offline/ {print $5}')" != "Completed:" ]; do
    echo -n .
    sleep 5
  done
  echo

  badsect=$(smartctl -l xselftest $baddrive | awk '/# 1  Selective offline   Completed: read failure/ {print $10}')
  if [ $badsect = "-" ]
  then
    echo "fin du test"
    smartctl -X $baddrive 2>&1 >> /dev/null
    exit 0
  fi

  #echo Attempting to fix sector $badsect on $baddrive
  echo Tentative de fixer le secteur $badsect sur $baddrive
  hdparm --write-sector ${badsect} --yes-i-know-what-i-am-doing $baddrive
  echo Continue le test
done

