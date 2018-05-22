#!/bin/bash
# 
# installs osa (downloaded to /tmp)
# and mysql
# on ubuntu
#
# @sblack4
# following https://docs.oracle.com/en/middleware/osa/18.1/install-stream-analytics/how-install-oracle-stream-analytics.html
# 
# Install Steps: 
#   1. Prerequisites 
#     - Local JDK 8 U 131 +                   (done)
#     - Local Spark 2.2.1+ for Hadoop 2.7+    (done)
#     - Mysql 5.6+ or Oracle DB 11.2+         
#     - Kafka                                 
#   2. Install Spark                          (done for us)
#   3. Download & Unzip OSA-18                (done in $OSA_HOME)
#   4. Set env vars in $OSA_HOME/osa-base/etc/osa-env.sh
#     - SPARK_HOME
#     - JAVA_HOME
#   5. Configure DB in $OSA_HOME/osa-base/etc/jetty-osa-datasource.xml
#   6. Initialize Metadata Store 
#     - Run $OSA_HOME/osa-base/bin/start-osa.sh dbroot=$DBROOT dbroot_password=$DBROOT_PASSWORD
#     - Run $OSA_HOME/osa-base/bin/stop-osa.sh
#   7. Change Admin Password
#     - Run $OSA_HOME/lib/jetty-util-9.4.7.v20170914.jar org.eclipse.jetty.util.security.Password osaadmin $NEW_OSAADMIN_PASSWORD
#     - Get value following 'OBF', we'll call it $NEW_PWD
#   8. Update osaadmin password in DB
#     - Run update osa_users set pwd='$NEW_PWD' where username='osaadmin'
#   9. Launch OSA with $OSE_HOME/osa-base/bin/start-osa.sh 
# 
# If the install worked then 
#   - OSA is running at localhost:9080/osa
#   - Enter the osaadmin password 
# Else check $OSA_HOME/osa-base/logs


JAVA_HOME=${JAVA_HOME:-""}
# [ -z $JAVA_HOME ] || JAVA_HOME=$(update-alternatives --list java | tail -1)
OSA_HOME=${OSA_HOME:-"/opt/OSA-18.*/"}
OSA_BIN=$OSA_HOME/osa-base/bin
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-"oracle"}
DB_CONN_STR="localhost:3306/OSADB"
DB_USER=${DB_USER:-'root'}
DB_PWD=${DB_PWD:-"oracle"}
MAINDB=${MAINDB:-"OSADB"}

install_osa() {
  echo --- INSTALL OSA --- 
  apt-get update 
  apt-get install -y unzip 
  unzip /opt/OSA-18.1.0.0.0.zip -d /opt 
  rm -rf /opt/OSA-18.1.0.0.0.zip
}

set_osa_config() {
  echo --- SET OSA CONFIG --- 
  sed -i '/#export JAVA_HOME=/c\export JAVA_HOME=${JAVA_HOME}' $OSA_HOME/osa-base/etc/osa-env.sh 
  sed -i '/#export SPARK_HOME=/c\export SPARK_HOME=${SPARK_HOME}' $OSA_HOME/osa-base/etc/osa-env.sh 
}


install_mysql() {
  echo --- INSTALL MYSQL ---
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
  echo --- REWRITING JETTY-OSA-DATASOURCE.XML --- 
  # configure datasource
#   sed -i 's#myhost.example.com:3307/OSADB#mysql:3306/OSADB#g' $OSA_HOME/osa-base/etc/jetty-osa-datasource.xml 
#   sed -i 's#{OSA_USER_PWD}#oracle#g' $OSA_HOME/osa-base/etc/jetty-osa-datasource.xml

# ugh 
# just rewrite it 
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
  echo '--- INITIALIZE METASTORE WITH start-osa.sh ---'
  chmod +x $OSA_HOME/osa-base/bin/start-osa.sh
  bash $OSA_HOME/osa-base/bin/start-osa.sh dbroot='root' dbroot_password="$MYSQL_ROOT_PASSWORD"

  echo '--- INITIALIZE METASTORE WITH stop-osa.sh ---'
  chmod +x $OSA_HOME/osa-base/bin/start-osa.sh
  bash $OSA_HOME/osa-base/bin/stop-osa.sh
}

change_osa_pwd() {
  echo --- CHANGEING osaadmin PASSWORD ---
  java -cp $OSA_HOME/lib/jetty-util-9.4.7.v20170914.jar org.eclipse.jetty.util.security.Password osaadmin $MYSQL_ROOT_PASSWORD >>/home/mypasswd.txt 2>&1
  cat << EOF 
-+- GET YOUR PASSWORD HERE ---
 | looks like this:
 +- - - - - - - - - 
 | oracle
 | OBF:1v2h1x1h1rwd1rwh1x151v1x
 | MD5:a189c633d9995e11bf8607170ec9a4b8
 | CRYPT:osIrDSntBazcU
 + - - - - - - - - 
EOF
  echo "-- PWD IS THE VALUE FOLLOWING 'OBF:'... 1v2h1x1h1rwd1rwh1x151v1x"
  cat /home/mypasswd.txt
  NEW_PWD=$(cat /home/mypasswd.txt | grep OBF | cut -d':' -f2)
  NEW_PWD=${NEW_PWD:-"1v2h1x1h1rwd1rwh1x151v1x"}
  echo $NEW_PWD >> /home/osaadmin_password.txt
  echo "new password $NEW_PWD saved to /home/osaadmin_password.txt"

  echo --- UPDATEING PASSWORD IN DB --- 
  mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "UPDATE OSADB.osa_users SET pwd='$NEW_PWD' WHERE username='osaadmin';"
  mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
}

launch_osa() {
  echo --- LAUNCH OSA ---
  $OSA_BIN/start-osa.sh
  echo "OSA should be running at localhost:9080/osa"
}

seed_database() {
  echo --- SEED DATABASE ---
  mysql -uroot -p"${NEW_PWD}" ${MAINDB} < $OSA_HOME/osa-base/sql/seedMysqlSchema.sql
}

main () {
  install_osa
  install_mysql
  set_osa_config
  set_jetty_config
  initialize_metastore
  change_osa_pwd
  launch_osa
  # seed_database
  # launch_osa
}

main "$@"
