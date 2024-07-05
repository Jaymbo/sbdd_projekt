#!/bin/bash

# Überprüfen, ob der Unterordner-Name als Argument übergeben wurde
if [ -z "$1" ]; then
  echo "Bitte geben Sie den Namen des Unterordners als Argument an."
  exit 1
fi

# Der Name des Unterordners
SUBFOLDER=$1

# Starten der 'screen'-Sitzungen
screen -dmS "${SUBFOLDER}_redocking" bash -c "bash run_vina_redocking.sh $SUBFOLDER"
screen -dmS "${SUBFOLDER}_ligands" bash -c "bash run_vina_ligands.sh $SUBFOLDER"
screen -dmS "${SUBFOLDER}_decoys" bash -c "bash run_vina_decoys.sh $SUBFOLDER"

echo "Screen-Sitzungen wurden gestartet:"
echo "- ${SUBFOLDER}_redocking"
echo "- ${SUBFOLDER}_ligands"
echo "- ${SUBFOLDER}_decoys"
