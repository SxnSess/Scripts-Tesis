#!/bin/bash
echo "/*------------------------------------------------------------*\

        ;0NNKd.
      ;''MMMMMW.  ...,;cdo  |
      KMMMMMMMMWWMMMMMMMk.  |
       kMMMMMMMMMMNKOd:.    |  Funcion: Script para Instalación
        .MMMMMM:            |           de OpenFoam.
       .;MMMMMM,       .    |
       xMMMMMMMWWNNNNWMM.   |  
       ,MMMMMMMMMMMMMMx'    |
        ';::;;,'.lMMMK      |  Ejecutado: $(date)
        .xo;.    oMMMx      |
         dMMO    KMMM:      |
          :; ccoOMMMK       |
             .cOWXk:        
\*------------------------------------------------------------*/"
# Instalar curl
echo ""
sudo apt-get update
sudo apt-get install curl -y
echo ""

# Instalacion de Docker
curl -fsSL https://get.docker.com/ | sh


# Agregar usuarios a grupo Docker
sudo usermod -aG docker $(whoami)
sudo usermod -aG docker antonio
sudo usermod -aG docker deykel


# Descargar script de instalación de OpenFOAM desde Docker
curl -o openfoam-docker-arm https://raw.githubusercontent.com/gerlero/openfoam-docker-arm/main/openfoam-docker-arm


# Dar permisos necesarios al script
chmod 755 openfoam-docker-arm


# Mover script a la ruta /usr/bin/
sudo mv openfoam-docker-arm /usr/bin/


# Creamos la carpeta de trabajo
mkdir -p $HOME/OpenFOAM/${USER}-2212
echo ""