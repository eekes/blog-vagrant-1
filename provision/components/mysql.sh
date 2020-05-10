#!/bin/bash

DBHOST=localhost
DBNAME=mydb
DBUSER=myuser
DBPASSWD=password

apt-get update

debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"

apt-get -y install mysql-server-5.7

CMD="mysql -uroot -p$DBPASSWD -e"

$CMD "CREATE DATABASE IF NOT EXISTS $DBNAME"
$CMD "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSER'@'%' IDENTIFIED BY '$DBPASSWD';"
$CMD "FLUSH PRIVILEGES;"

sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

sudo service mysql restart