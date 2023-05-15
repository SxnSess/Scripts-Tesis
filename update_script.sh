#!/bin/bash
echo "/*------------------------------------------------------------*\

        ;0NNKd.
      ;''MMMMMW.  ...,;cdo  |
      KMMMMMMMMWWMMMMMMMk.  |
       kMMMMMMMMMMNKOd:.    |  Funcion: Script para mantener el
        .MMMMMM:            |           sistema Actualizado.
       .;MMMMMM,       .    |
       xMMMMMMMWWNNNNWMM.   |  
       ,MMMMMMMMMMMMMMx'    |
        ';::;;,'.lMMMK      |  Ejecutado: $(date)
        .xo;.    oMMMx      |
         dMMO    KMMM:      |
          :; ccoOMMMK       |
             .cOWXk:        
\*------------------------------------------------------------*/"
USERNAME=$USER
RUTA=/var/log

# Obtener la hora del sistema y almacenarla en una variable
HORA=$(date +"%I:%M:%S %p")

# Establecer la hora deseada para la tarea programada
NUEVA_HORA="20 20 * * *"

# Actualiza la lista de paquetes disponibles
echo ""
sudo apt-get update

# Actualiza los paquetes instalados
echo ""
sudo apt-get upgrade -y
echo ""

# Verifica si la tarea programada ya existe en el archivo de crontab
EXISTE_TAREA=$(crontab -l | grep -q "$NUEVA_HORA /etc/cron.daily/update_script.sh" && echo "1" || echo "0")
EXISTE_HORA=$(crontab -l | grep -q "^$NUEVA_HORA" && echo "1" || echo "0")

if [ "$EXISTE_TAREA" -eq 0 ] && [ "$EXISTE_HORA" -eq 0 ]; then
  # Agrega la tarea programada en el archivo de crontab si no existe
  (crontab -l ; echo "$NUEVA_HORA /etc/cron.daily/update_script.sh") | crontab -
  echo -e "\e[33mLa tarea programada ha sido agregada a crontab.\e[0m"
  echo ""
else
  echo -e "\e[33mLa tarea programada ya existe en crontab o hay otra tarea programada con la misma hora.\e[0m"
  echo ""
fi



echo "================================================="
crontab -l
echo "================================================="

echo ""
echo "El script se ejecutó correctamente a la $HORA" >> $RUTA/update_script.log 2>&1
