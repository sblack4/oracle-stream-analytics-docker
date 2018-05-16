#!/bin/bash
# 
# installs osa (downloaded to /tmp)
# and mysql
# on ubuntu
#
# @sblack4
# following https://docs.oracle.com/en/middleware/osa/18.1/install-stream-analytics/how-install-oracle-stream-analytics.html

JAVA_HOME=${JAVA_HOME:-""}
# [ -z $JAVA_HOME ] || JAVA_HOME=$(update-alternatives --list java | tail -1)
OSA_HOME=${OSA_HOME:-"/opt/OSA-18.*/"}
OSA_BIN=$OSA_HOME/osa-base/bin
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-"oracle"}
DB_CONN_STR="localhost:3306/OSADB"
DB_USER=${DB_USER:-'root'}
DB_PWD=${DB_PWD:-"oracle"}
MAINDB=${MAINDB:-"OSADB"}

install() {
  apt-get update 
  apt-get install -y unzip 
  unzip /opt/OSA-18.1.0.0.0.zip -d /opt 
  rm -rf /opt/OSA-18.1.0.0.0.zip
}

set_osa_config() {
  sed -i '/#export JAVA_HOME=/c\export JAVA_HOME=${JAVA_HOME}' $OSA_HOME/osa-base/etc/osa-env.sh 
  sed -i '/#export SPARK_HOME=/c\export SPARK_HOME=${SPARK_HOME}' $OSA_HOME/osa-base/etc/osa-env.sh 
}


install_mysql() {
  # groupadd mysql
  # useradd -r -g mysql -s /bin/false mysql 

  apt-get install -y mysql-server 
  service mysql enable
  service mysql start 

  mysql -uroot --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'oracle';"
  # mysql -uroot --skip-password -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
  mysql -uroot --skip-password -e "CREATE USER ${DB_USER}@localhost IDENTIFIED BY '${DB_PWD}';"
  # mysql -uroot --skip-password -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'localhost';"
  mysql -uroot -poracle -e "FLUSH PRIVILEGES;"
} 

set_jetty_config() {
  # configure datasource
#   sed -i 's#myhost.example.com:3307/OSADB#mysql:3306/OSADB#g' $OSA_HOME/osa-base/etc/jetty-osa-datasource.xml 
#   sed -i 's#{OSA_USER_PWD}#oracle#g' $OSA_HOME/osa-base/etc/jetty-osa-datasource.xml

# ugh 
# just rewrite it 
echo --- REWRITING JETTY-OSA-DATASOURCE.XML --- 
  mv $OSA_HOME/osa-base/etc/jetty-osa-datasource.xml $OSA_HOME/osa-base/etc/jetty-osa-datasource.xml.bak
  datasource="<?xml version=\"1.0\"?>
<!DOCTYPE Configure PUBLIC \"-//Jetty//Configure//EN\" \"http://www.eclipse.org/jetty/configure_9_3.dtd\">
<Configure id=\"Server\" class=\"org.eclipse.jetty.server.Server\">
    <New id=\"osads\" class=\"org.eclipse.jetty.plus.jndi.Resource\">
        <Arg>
            <Ref refid=\"wac\"/>
        </Arg>
        <Arg>jdbc/OSADataSource</Arg>
        <Arg>
            <New class=\"com.mysql.jdbc.jdbc2.optional.MysqlConnectionPoolDataSource\">
                <Set name=\"URL\">jdbc:mysql://${DB_CONN_STR}</Set>
                <Set name=\"User\">root</Set>
                <Set name=\"Password\">oracle</Set>
            </New>
        </Arg>
    </New>
</Configure>"

  touch $OSA_HOME/osa-base/etc/jetty-osa-datasource.xml
  echo "$datasource" >> $OSA_HOME/osa-base/etc/jetty-osa-datasource.xml
  cat $OSA_HOME/osa-base/etc/jetty-osa-datasource.xml
}

initialize_metastore() {
  echo --- INITIALIZE METASTORE WITH start-osa.sh --- 
  chmod +x $OSA_HOME/osa-base/bin/start-osa.sh
  bash $OSA_HOME/osa-base/bin/start-osa.sh dbroot=root dbroot_password=$MYSQL_ROOT_PASSWORD
}

change_osa_pwd() {
  echo --- CHANGEING osaadmin PASSWORD ---
  java -cp $OSA_HOME/lib/jetty-util-9.4.7.v20170914.jar org.eclipse.jetty.util.security.Password osaadmin $MYSQL_ROOT_PASSWORD >>/home/mypasswd.txt 2>&1
  echo "--- GET YOUR PASSWORD HERE ..." 
  # looks like - 
  # oracle
  # OBF:1v2h1x1h1rwd1rwh1x151v1x
  # MD5:a189c633d9995e11bf8607170ec9a4b8
  # CRYPT:osIrDSntBazcU
  echo "-- PWD IS THE VALUE FOLLOWING 'OBF:'... 1v2h1x1h1rwd1rwh1x151v1x"
  cat ~/mypasswd.txt
  NEW_PWD=$(cat ~/mypasswd.txt | grep OBF | cut -d':' -f2)
  echo $NEW_PWD
}

seed_database() {
  echo --- SEED DATABASE ---
  mysql -uroot -p"${NEW_PWD}" ${MAINDB} < $OSA_HOME/osa-base/sql/seedMysqlSchema.sql
}

main () {
  install
  install_mysql
  set_osa_config
  set_jetty_config
  initialize_metastore
  change_osa_pwd
  seed_database
}

main "$@"
