#!/bin/bash

# Überprüfen, ob der Unterordner-Name als Argument übergeben wurde
if [ -z "$1" ]; then
  echo "Bitte geben Sie den Namen des Unterordners als Argument an."
  exit 1
fi

# Der Name des Unterordners
SUBFOLDER=$1

# Überprüfen, ob die Eingabedatei existiert
if [ ! -f "$SUBFOLDER/na-decoys.sdf" ]; then
  echo "Die Datei $SUBFOLDER/na-decoys.sdf wurde nicht gefunden."
  exit 1
fi

# Überprüfen, ob die Receptor-Datei existiert
if [ ! -f "$SUBFOLDER/receptor.pdbqt" ]; then
  echo "Die Datei $SUBFOLDER/receptor.pdbqt wurde nicht gefunden."
  exit 1
fi

# Erstellen des Unterordners und der notwendigen Verzeichnisse darin
mkdir -p "$SUBFOLDER/decoys"
mkdir -p "$SUBFOLDER/results_decoys"

# Schritt 1: Aufteilen der SDF-Datei in einzelne decoyen
obabel "$SUBFOLDER/na-decoys.sdf" -O "$SUBFOLDER/decoys/decoy_.pdbqt" -m

# Schritt 2: Führen Sie das Docking für jede decoyendatei durch
for f in "$SUBFOLDER/decoys/decoy_"*.pdbqt; do
  # Überprüfen, ob Datei existiert (Falls keine Dateien gefunden wurden, wird der Schleifeninhalt übersprungen)
  if [ -e "$f" ]; then
    # Extrahieren des Dateinamens ohne Verzeichnis
    filename=$(basename -- "$f")
    # Ausgabedatei im Verzeichnis 'results_decoys' speichern
    vina --config "$SUBFOLDER/config_vina.txt" --ligand "$f" --out "$SUBFOLDER/results_decoys/$filename" --receptor "$SUBFOLDER/receptor.pdbqt"
  fi
done
