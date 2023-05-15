#!/bin/bash
echo "/*------------------------------------------------------------*\

        ;0NNKd.
      ;''MMMMMW.  ...,;cdo  |
      KMMMMMMMMWWMMMMMMMk.  |
       kMMMMMMMMMMNKOd:.    |  Funcion: Script para Instalación
        .MMMMMM:            |           de Fail2ban.
       .;MMMMMM,       .    |
       xMMMMMMMWWNNNNWMM.   |  
       ,MMMMMMMMMMMMMMx'    |
        ';::;;,'.lMMMK      |  Ejecutado: $(date)
        .xo;.    oMMMx      |
         dMMO    KMMM:      |
          :; ccoOMMMK       |
             .cOWXk:        
\*------------------------------------------------------------*/"
if ! command -v fail2ban &> /dev/null
then
    echo ""
	sudo apt update
	echo ""
    sudo apt-get install -y fail2ban
fi

# Verifica si el archivo jail.local existe y lo elimina
if [ -f /etc/fail2ban/jail.local ]; then
	echo ""
	echo -e "Eliminando archivo jail.local existente... \033[33m/etc/fail2ban/jail.local\033[0m"
    sudo rm /etc/fail2ban/jail.local
fi

# Crea un archivo de configuración fail2ban local para hacer cambios
echo ""
echo -e "Creando archivo jail.local... \033[33m/etc/fail2ban/jail.local\033[0m"
echo ""
sudo touch /etc/fail2ban/jail.local

# Configura fail2ban para monitorear el servicio xrdp
echo "Creando servicio xrdp"
sudo bash -c 'echo -e "[xrdp]\nenabled = true\nport = 3389\nfilter = xrdp\nlogpath = /var/log/xrdp-sesman.log\nmaxretry = 3\nbantime = 1800\n\n" >> /etc/fail2ban/jail.local'

# Configura fail2ban para monitorear el servicio ssh
echo ""
echo "Creando servicio sshd"
sudo bash -c 'echo -e "[sshd]\nenabled = true\nport = ssh\nfilter = sshd\nlogpath = /var/log/auth.log\nmaxretry = 3\nbantime = 1800\n\n" >> /etc/fail2ban/jail.local'

# Verifica si el archivo xrdp.conf existe y lo crea si no
if [ ! -f /etc/fail2ban/filter.d/xrdp.conf ]; then
	echo ""
    sudo touch /etc/fail2ban/filter.d/xrdp.conf
    sudo bash -c 'echo -e "[Definition]\nfailregex = .* ip=<HOST> .*\n\nignoreregex =\ndatepattern = %%Y%%m%%d-%%H:%%M:%%S" >> /etc/fail2ban/filter.d/xrdp.conf' >&2
fi

echo ""

if [ -f /etc/fail2ban/filter.d/xrdp.conf ]; then
		echo -e "Creando filtro para Xrdp... \033[33m/etc/fail2ban/filter.d/xrdp.conf\033[0m"
	fi

# Reinicia fail2ban para aplicar los cambios
sudo systemctl enable fail2ban
sudo service fail2ban restart
echo ""
