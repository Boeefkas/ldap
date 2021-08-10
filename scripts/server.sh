#!/bin/bash

sudo yum install -y openldap openldap-servers openldap-clients
sudo systemctl start slapd
sudo systemctl enable slapd
sudo firewall-cmd --add-service=ldap
SSH_PASSWORD=$(sudo slappasswd -s $PASSWORD)
sudo sed -i "s|{SSHA}PASSWORD|${SSH_PASSWORD}|g" /resources/*
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /resources/ldaprootpasswd.ldif
sudo cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
sudo chown -R ldap:ldap /var/lib/ldap/DB_CONFIG
sudo systemctl restart slapd
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif 
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif
sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f /resources/ldapdomain.ldif
sudo ldapadd -x -w $PASSWORD -D "cn=Manager,dc=devopsldab,dc=com" -f /resources/baseldapdomain.ldif
sudo ldapadd -x -w $PASSWORD -D cn=Manager,dc=devopsldab,dc=com -f /resources/ldapgroup.ldif
sudo sed -i "s|\$(cat pass)|default_password|" /resources/ldapuser.ldif
sudo ldapadd -x -D "cn=Manager,dc=devopsldab,dc=com" -w $PASSWORD -f /resources/ldapuser.ldif

sudo yum --enablerepo=epel -y install phpldapadmin
sudo sed -i '397s+^//++' /etc/phpldapadmin/config.php
sudo sed -i '398s+^+//+' /etc/phpldapadmin/config.php
sudo rm /etc/httpd/conf.d/phpldapadmin.conf
sudo cat << EOF > phpldapadmin.conf 
Alias /phpldapadmin /usr/share/phpldapadmin/htdocs
Alias /ldapadmin /usr/share/phpldapadmin/htdocs
<Directory /usr/share/phpldapadmin/htdocs>
  <IfModule mod_authz_core.c>
    Require all granted
    Require local
    Require ip 10.0.0.0/24
  </IfModule>
  <IfModule !mod_authz_core.c>
    Order Allow, Deny
    Allow from all
    Allow from 127.0.0.1
    Allow from ::1
  </IfModule>
</Directory>
EOF
sudo cp phpldapadmin.conf /etc/httpd/conf.d/
sudo systemctl restart httpd