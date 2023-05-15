#!/bin/bash
echo "/*------------------------------------------------------------*\

        ;0NNKd.
      ;''MMMMMW.  ...,;cdo  |
      KMMMMMMMMWWMMMMMMMk.  |
       kMMMMMMMMMMNKOd:.    |  Funcion: Script para Eliminar todas
        .MMMMMM:            |            las apps incesesarias.
       .;MMMMMM,       .    |
       xMMMMMMMWWNNNNWMM.   |  
       ,MMMMMMMMMMMMMMx'    |
        ';::;;,'.lMMMK      |  Ejecutado: $(date)
        .xo;.    oMMMx      |
         dMMO    KMMM:      |
          :; ccoOMMMK       |
             .cOWXk:        
\*------------------------------------------------------------*/"
# Eliminar aplicaciones innecesarias en Ubuntu 20.04
echo ""
sudo apt-get remove --purge aisleriot -y

sudo apt-get remove --purge gnome-sudoku -y

# Desinstalar Mahjongg
sudo apt-get remove --purge gnome-mahjongg -y

# Desinstalar Mines
sudo apt-get remove --purge gnome-mines -y

# Desinstalar Password and Keys
sudo apt-get remove --purge seahorse -y

# Desinstalar Remmina
sudo apt-get remove --purge remmina* -y

# Desinstalar Rhythmbox
sudo apt-get remove --purge rhythmbox* -y

# Desinstalar Thunderbird Mail
sudo apt-get remove --purge thunderbird* -y

# Desinstalar LibreOffice
sudo apt-get remove --purge libreoffice* -y

# Limpiar paquetes no necesarios
sudo apt-get autoremove -y

# Actualizar lista de paquetes
sudo apt-get update

# Limpiar caché de paquetes
sudo apt-get clean

echo "Se eliminaron las aplicaciones innecesarias del Jetson AGX Xavier"
echo ""