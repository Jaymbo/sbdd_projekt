#!/bin/bash

# Überprüfen, ob der Unterordner-Name als Argument übergeben wurde
if [ -z "$1" ]; then
  echo "Bitte geben Sie den Namen des Unterordners als Argument an."
  exit 1
fi

# Der Name des Unterordners
SUBFOLDER=$1

# Überprüfen, ob die Eingabedatei existiert
if [ ! -f "$SUBFOLDER/redocking_ligand.cif" ]; then
  echo "Die Datei $SUBFOLDER/redocking_ligand.cif wurde nicht gefunden."
  exit 1
fi

# Überprüfen, ob die Receptor-Datei existiert
if [ ! -f "$SUBFOLDER/receptor.pdbqt" ]; then
  echo "Die Datei $SUBFOLDER/receptor.pdbqt wurde nicht gefunden."
  exit 1
fi

# Erstellen des Unterordners und der notwendigen Verzeichnisse darin
mkdir -p "$SUBFOLDER/redockings"
mkdir -p "$SUBFOLDER/results_redockings"

# Schritt 1: Aufteilen der SDF-Datei in einzelne redockingen
obabel "$SUBFOLDER/redocking_ligand.cif" -O "$SUBFOLDER/redockings/redocking_.pdbqt" -m

# Schritt 2: Führen Sie das Docking für jede redockingendatei durch
for f in "$SUBFOLDER/redockings/redocking_"*.pdbqt; do
  # Überprüfen, ob Datei existiert (Falls keine Dateien gefunden wurden, wird der Schleifeninhalt übersprungen)
  if [ -e "$f" ]; then
    # Extrahieren des Dateinamens ohne Verzeichnis
    filename=$(basename -- "$f")
    # Ausgabedatei im Verzeichnis 'results_redockings' speichern
    vina --config "$SUBFOLDER/config_vina.txt" --ligand "$f" --out "$SUBFOLDER/results_redockings/$filename" --receptor "$SUBFOLDER/receptor.pdbqt"
  fi
done
