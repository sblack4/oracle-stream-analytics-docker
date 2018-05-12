#!/bin/env bash
# setup & entry script
# @sblack4 2018


# # install mysql
# apt-get -y update
# apt-get -y install mysql-server 

JAVA_HOME=${JAVA_HOME:-""}
# [ -z $JAVA_HOME ] || JAVA_HOME=$(update-alternatives --list java | tail -1)
echo JAVA_HOME 
OSA_HOME=${OSA_HOME:-"/opt/OSA-18.*/"}
OSA_BIN=$OSA_HOME/osa-base/bin
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-"oracle"}

# set up jetty-osa-datasource
chmod +x $OSA_HOME/osa-base/bin/start-osa.sh

# initialize metastore
bash $OSA_HOME/osa-base/bin/start-osa.sh dbroot=root dbroot_password=$MYSQL_ROOT_PASSWORD

# change admin passwd
java -cp $OSA_HOME/lib/jetty-util-9.4.7.v20170914.jar org.eclipse.jetty.util.security.Password osaadmin $MYSQL_ROOT_PASSWORD

service mysql enable
service mysql start 

mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE OSADB;" 

mysql -uroot -p${MYSQL_ROOT_PASSWORD}

# start osa
bash $OSA_HOME/osa-base/bin/start-osa.sh
