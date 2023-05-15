#!/bin/bash
echo "/*------------------------------------------------------------*\

        ;0NNKd.
      ;''MMMMMW.  ...,;cdo  |
      KMMMMMMMMWWMMMMMMMk.  |
       kMMMMMMMMMMNKOd:.    |  Funcion: Script para Instalación
        .MMMMMM:            |           servidor XRDP.
       .;MMMMMM,       .    |
       xMMMMMMMWWNNNNWMM.   |  
       ,MMMMMMMMMMMMMMx'    |
        ';::;;,'.lMMMK      |  Ejecutado: $(date)
        .xo;.    oMMMx      |
         dMMO    KMMM:      |
          :; ccoOMMMK       |
             .cOWXk:        
\*------------------------------------------------------------*/"
# Actualizar repositorios del sistema
echo ""
sudo apt update
echo ""
# Instalar el paquete wget si no está instalado
if ! command -v wget &> /dev/null
then
    sudo apt install wget
	echo ""
fi

#Instalar entorno Grafico xfce4
sudo apt-get install xfce4

# Descargar archivo
echo ""
echo "Descargando script de instalacion del xrdp "
wget https://www.c-nergy.be/downloads/xRDP/xrdp-installer-1.4.6.zip

# Descomprimir archivo
echo ""
echo "Descomprimiendo el archivo..."
unzip xrdp-installer-1.4.6.zip

# Dar permisos de ejecución al script
echo ""
echo "Asignando permisos de ejecucion"
chmod +x xrdp-installer-1.4.6.sh

# Ejecutar el script xrdp-installer.sh con la opción -c
echo ""
echo "Instalando xrdp custom -c"

./xrdp-installer-1.4.6.sh -c

echo ""
sudo ufw allow 3389/tcp
echo ""