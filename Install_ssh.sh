#!/bin/bash
echo "/*------------------------------------------------------------*\

        ;0NNKd.
      ;''MMMMMW.  ...,;cdo  |
      KMMMMMMMMWWMMMMMMMk.  |
       kMMMMMMMMMMNKOd:.    |  Funcion: Script para Instalación
        .MMMMMM:            |           de servidor ssh.
       .;MMMMMM,       .    |
       xMMMMMMMWWNNNNWMM.   |  
       ,MMMMMMMMMMMMMMx'    |
        ';::;;,'.lMMMK      |  Ejecutado: $(date)
        .xo;.    oMMMx      |
         dMMO    KMMM:      |
          :; ccoOMMMK       |
             .cOWXk:        
\*------------------------------------------------------------*/"
# Instala el servidor SSH
echo ""
sudo apt-get update
sudo apt-get install -y openssh-server

# Realiza una copia de seguridad del archivo de configuración original
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original

# Configura el archivo de configuración de SSH
echo ""
echo "Editando el archivo de configuracion /etc/ssh/sshd_config"
sudo sed -i 's/^#*\s*Port\s\+.*/Port 2708/' /etc/ssh/sshd_config                                    # Cambia el puerto a uno personalizado
sudo sed -i 's/^#*\s*PermitRootLogin\s\+.*/PermitRootLogin no/' /etc/ssh/sshd_config                # Deshabilita el acceso root
sudo sed -i 's/^#*\s*PasswordAuthentication\s\+.*/PasswordAuthentication no/' /etc/ssh/sshd_config  # Deshabilita la autenticación por contraseña
sudo sed -i 's/^#*\s*PubkeyAuthentication\s\+.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config     # Habilita la autenticación por clave pública
sudo sed -i 's/^#*\s*Banner\s\+.*/Banner \/etc\/ssh\/mybanner/' /etc/ssh/sshd_config                # Habilitando banner ASCII de bienvenida

# Crea el archivo banner.txt en la ubicación /etc/ssh y escribe el banner ASCII en el archivo
sudo tee /etc/ssh/mybanner > /dev/null <<EOF
░░░░░██╗███████╗████████╗░██████╗░█████╗░███╗░░██╗  ░█████╗░░██████╗░██╗░░██╗
░░░░░██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗░██║  ██╔══██╗██╔════╝░╚██╗██╔╝
░░░░░██║█████╗░░░░░██║░░░╚█████╗░██║░░██║██╔██╗██║  ███████║██║░░██╗░░╚███╔╝░
██╗░░██║██╔══╝░░░░░██║░░░░╚═══██╗██║░░██║██║╚████║  ██╔══██║██║░░╚██╗░██╔██╗░
╚█████╔╝███████╗░░░██║░░░██████╔╝╚█████╔╝██║░╚███║  ██║░░██║╚██████╔╝██╔╝╚██╗
░╚════╝░╚══════╝░░░╚═╝░░░╚═════╝░░╚════╝░╚═╝░░╚══╝  ╚═╝░░╚═╝░╚═════╝░╚═╝░░╚═╝
EOF

echo ""
echo -e "Banner Actualizado... \033[33mcat /etc/ssh/mybanner\033[0m"
echo ""

# Buscar la línea en el archivo /etc/pam.d/sshd
if grep -Eq "^\s*#?\s*session\s+optional\s+pam_motd\.so\s+motd=/run/motd.dynamic" /etc/pam.d/sshd; then
    # Si la línea ya tiene un "#" adelante, no hacemos nada
    if grep -Eq "^\s*#\s*session\s+optional\s+pam_motd\.so\s+motd=/run/motd.dynamic" /etc/pam.d/sshd; then
        echo "La línea ya tiene un '#' adelante."
    # Si la línea no tiene un "#" adelante, le agregamos uno
    else
        sudo sed -i 's/^\(\s*session\s\+optional\s\+pam_motd\.so\s\+motd=\/run\/motd.dynamic\)/#\1/' /etc/pam.d/sshd
        echo "Se agregó un '#' adelante de la línea."
    fi
else
    echo "No se encontró la línea en el archivo."
fi

# Añade regla de firewall para permitir el tráfico por el puerto SSH
echo ""
echo -e "\033[33mse configura el firewall para permitir conexiones desde el puerto 2708\033[0m"
sudo ufw allow 2708/tcp
echo ""
ufw status

# Reinicia el servicio SSH

sudo systemctl enable ssh
echo ""
sudo systemctl restart ssh

echo ""
echo "***********************************************************"
echo -e "Genera un par de claves en tu cliente.\nEsto se puede hacer con el siguiente comando: \e[1;33mssh-keygen -t rsa\e[0m.\nEsto generará una clave pública y una clave privada en tu directorio de inicio, en la carpeta .ssh. \nCopia la clave pública generada en el paso anterior al servidor SSH."
echo ""