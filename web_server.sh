#!/bin/bash
sudo apt update
sudo apt install apache2
sudo apt install wordpress php libapache2-mod-php mysql-server php-mysql
mkdir /etc/apache2/sites-available/wordpress.conf
cd /etc/apache2/sites-available
echo "Alias /blog /usr/share/wordpress
<Directory /usr/share/wordpress>
    Options FollowSymLinks
    AllowOverride Limit Options FileInfo
    DirectoryIndex index.php
    Order allow,deny
    Allow from all
</Directory>
<Directory /usr/share/wordpress/wp-content>
    Options FollowSymLinks
    Order allow,deny
    Allow from all
</Directory>" wordpress.conf
sudo a2ensite wordpress
sudo a2enmod rewrite
sudo service apache2 reload
sudo mysql -u root
CREATE DATABASE wordpress;
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER
    -> ON wordpress.*
    -> TO wordpress@localhost
    -> IDENTIFIED BY '<your-password>';
FLUSH PRIVILEGES;
quit
cd /etc/wordpress
echo "<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'wordpress');
define('DB_PASSWORD', '<your-password>');
define('DB_HOST', 'localhost');
define('DB_COLLATE', 'utf8_general_ci');
define('WP_CONTENT_DIR', '/usr/share/wordpress/wp-content');
?>" config-localhost.php
sudo service mysql start