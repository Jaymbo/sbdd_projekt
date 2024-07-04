#!/bin/bash

# Schritt 1: Aufteilen der SDF-Datei in einzelne Liganden
# obabel na-ligands.sdf -O ./ligands/ligand_.pdbqt -m

# Schritt 2: Führen Sie das Docking für jede Ligandendatei durch
for f in ligands/ligand_*.pdbqt; do
  vina --receptor 1a4g-receptor.pdbqt --ligand $f --center_x -7.621 --center_y 37.6475 --center_z 1.485 --size_x 18.0 --size_y 25.0 --size_z 19.0 --out result_${f%.pdb} 
done
