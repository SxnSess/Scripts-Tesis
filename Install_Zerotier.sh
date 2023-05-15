#!/bin/bash
echo "/*------------------------------------------------------------*\

        ;0NNKd.
      ;''MMMMMW.  ...,;cdo  |
      KMMMMMMMMWWMMMMMMMk.  |
       kMMMMMMMMMMNKOd:.    |  Funcion: Script para Instalación
        .MMMMMM:            |           de Zerotier.
       .;MMMMMM,       .    |
       xMMMMMMMWWNNNNWMM.   |  
       ,MMMMMMMMMMMMMMx'    |
        ';::;;,'.lMMMK      |  Ejecutado: $(date)
        .xo;.    oMMMx      |
         dMMO    KMMM:      |
          :; ccoOMMMK       |
             .cOWXk:        
\*------------------------------------------------------------*/"
echo ""
echo "Seleccione una opción:"
echo ""
echo "1. Instalación de Zerotier con SSL"
echo "2. Instalación de Zerotier con GPG"
echo ""

while read option; do
    if [[ "$option" != "1" && "$option" != "2" ]]; then
        echo "Error: opción inválida. Seleccione una opción válida:"
    else
        break
    fi
done

echo ""

# Opción 1: Instalación con SSL
if [ $option -eq 1 ]; then
    echo "Instalando dependencias..."
    sudo apt-get install openssl -y
	echo ""
    echo "Ejecutando comando de instalación con SSL..."
    curl -s https://install.zerotier.com | sudo bash
	echo ""
fi


# Opción 2: Instalación con GPG
if [ $option -eq 2 ]; then
	echo ""
    echo "Instalando dependencias..."
    sudo apt-get install gnupg -y
	echo ""
	
    echo "Importando la clave GPG..."
    curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import

    echo "Ejecutando comando de instalación con GPG..."
    if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi
	echo ""
fi

echo ""
echo "Ingrese el ID del servidor al que desea unirse:"
read server_id
echo ""

echo -e "¿Desea unirse al servidor con ID \e[32m$server_id\e[0m? (s/n)"
while read join_server; do
    if [[ "$join_server" != "s" && "$join_server" != "n" ]]; then
        echo "Error: respuesta inválida. Ingrese 's' o 'n':"
		echo ""
    else
        break
    fi
done

echo ""

if [[ "$join_server" == "s" ]]; then
    sudo zerotier-cli join "$server_id"
    echo -e "Se ha unido al servidor con ID \e[32m$server_id\e[0m"
	echo ""
else
    echo "No se ha unido al servidor"
	echo ""
fi

