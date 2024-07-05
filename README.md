# sbdd_projekt


## Vorarbeit
in pymol sauber machen und speichern als .cif und auf server übertragen in den Ordner mit dem molekülname
```
fetch 1a4g
select ligand
cmd.create(None,"sele",zoom=0)
print cmd.get_coords('sele', 1)
```
File>Export Struckture>Export Molecule
selection: receptor/obj01
optionen alle deaktivieren
speichern als .cif

## lokales setup
in powershell
```
wsl --install -d Ubuntu
#einrichtung abschließen
sudo apt install miniconda3
conda install -c conda-forge vina
conda install openbabel
```

## server setup
```
ssh ibmstud0*@sshgw.cs.uni-tuebingen.de
ssh ibminode06
source /thiel/source_miniconda3
conda activate sbdd24-py310
```

### Daten laden
```
cd sbdd_projekt
cp  config_vina_template.txt config_vina.txt 
nano 1a4g_na/config_vina.txt
cd 1a4g_na
obabel receptor.cif -xr -O receptor.pdbqt
```



config anpassen mit Koordinaten aus Pymol

## Docking
einzeln laufen zu lassen:
```
screen -dmS redocking_docking bash run_vina_redocking.sh 1a4g_na
screen -dmS ligands_docking bash run_vina_ligands.sh 1a4g_na
screen -dmS decoys_docking bash run_vina_decoys.sh 1a4g_na
```

auf einmal laufen zu lassen
```
bash run_vina_mole.sh 1a4g_na
```

um anzuschauen, was gerade passiert
```
screen -r
```
und 2-mal 'tab' drücken und das entsprechnde fenster auswählen

