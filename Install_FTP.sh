#!/bin/bash
echo "/*------------------------------------------------------------*\

        ;0NNKd.
      ;''MMMMMW.  ...,;cdo  |
      KMMMMMMMMWWMMMMMMMk.  |
       kMMMMMMMMMMNKOd:.    |  Funcion: Script para instalacion
        .MMMMMM:            |           y configuracion de FTP.
       .;MMMMMM,       .    |
       xMMMMMMMWWNNNNWMM.   |  
       ,MMMMMMMMMMMMMMx'    |
        ';::;;,'.lMMMK      |  Ejecutado: $(date)
        .xo;.    oMMMx      |
         dMMO    KMMM:      |
          :; ccoOMMMK       |
             .cOWXk:        
\*------------------------------------------------------------*/"
# Instalar vsftpd
echo ""
sudo apt-get update
sudo apt-get install vsftpd -y
echo ""
# Configurar vsftpd TLS y enjaulamiento de usuarios

sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.original
sudo sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
sudo sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/g' /etc/vsftpd.conf
sudo sed -i 's/#chroot_list_enable=YES/chroot_list_enable=YES/g' /etc/vsftpd.conf
sudo sed -i 's/#chroot_list_file=\/etc\/vsftpd.chroot_list/chroot_list_file=\/etc\/vsftpd.chroot_list/g' /etc/vsftpd.conf
sudo sed -i 's/rsa_cert_file=\/etc\/ssl\/certs\/ssl-cert-snakeoil.pem/rsa_cert_file=\/etc\/ssl\/certs\/vsftpd.pem/g' /etc/vsftpd.conf
sudo sed -i 's/rsa_private_key_file=\/etc\/ssl\/private\/ssl-cert-snakeoil.key/rsa_private_key_file=\/etc\/ssl\/private\/vsftpd.pem/g' /etc/vsftpd.conf
sudo sed -i 's/ssl_enable=NO/ssl_enable=YES/g' /etc/vsftpd.conf

echo "force_local_data_ssl=YES" | sudo tee -a /etc/vsftpd.conf
echo "force_local_logins_ssl=YES" | sudo tee -a /etc/vsftpd.conf
echo "ssl_tlsv1=YES" | sudo tee -a /etc/vsftpd.conf
echo "ssl_sslv2=NO" | sudo tee -a /etc/vsftpd.conf
echo "ssl_sslv3=NO" | sudo tee -a /etc/vsftpd.conf
echo "require_ssl_reuse=NO" | sudo tee -a /etc/vsftpd.conf
echo "ssl_ciphers=HIGH" | sudo tee -a /etc/vsftpd.conf


# Crear archivo de lista de usuarios permitidos

sudo touch /etc/vsftpd.chroot_list
sudo chmod 644 /etc/vsftpd.chroot_list

# Agregar usuarios a la lista de usuarios permitidos

echo "root" | sudo tee -a /etc/vsftpd.chroot_list
echo "jetson" | sudo tee -a /etc/vsftpd.chroot_list

# Crear certificado SSL

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/certs/vsftpd.pem -subj "/C=US/ST=PANAMA/L=PANAMA CITY/O=My Organization/OU=Jetson AGX Xavier/CN=Jetson"

# Reiniciar vsftpd
echo ""
sudo systemctl enable vsftpd
sudo systemctl restart vsftpd
echo ""
