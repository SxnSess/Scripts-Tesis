#!/bin/bash
echo "/*------------------------------------------------------------*\

        ;0NNKd.
      ;''MMMMMW.  ...,;cdo  |
      KMMMMMMMMWWMMMMMMMk.  |
       kMMMMMMMMMMNKOd:.    |  Funcion: Script para creacion
        .MMMMMM:            |           de usuario.
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
echo "¿Cuántos usuarios desea crear?"
while read num_users; do
    if [[ ! "$num_users" =~ ^[0-9]+$ ]]; then
        echo "Error: $num_users no es un número válido. Introduzca un número válido:"
    else
        break
    fi
done
echo ""

created_users=()

for ((i=1; i<=$num_users; i++)); do
    while true; do
        echo "Introduzca el nombre del usuario $i en minúsculas:"
        read username
        username=$(echo "$username" | tr '[:upper:]' '[:lower:]') # Convertimos a minúsculas
        echo ""
        
        # Comprobamos si el usuario ya existe
        if id "$username" >/dev/null 2>&1; then     
            echo "El usuario $username ya existe. Introduzca otro nombre de usuario."
			echo ""
        else
            break
        fi
    done
    
    # Creamos el usuario
    adduser --disabled-password --gecos "" "$username"
    echo ""
    echo "Se ha creado el usuario $username correctamente."
    echo ""
    echo "Introduzca una contraseña para el usuario $username:"
    echo ""
    passwd "$username"
    echo ""
    created_users+=("$username")
done

# Imprimimos los usuarios creados
echo ""
echo -e "\e[1m\e[32mLos siguientes usuarios se han creado:\e[0m"  # texto en verde y en negrita
echo ""
for user in "${created_users[@]}"; do
    echo -e "\e[34m$user\e[0m"  # texto en azul
done
echo ""