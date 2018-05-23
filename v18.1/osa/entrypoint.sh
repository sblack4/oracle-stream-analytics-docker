#!/bin/env bash
# setup & entry script
# @sblack4 2018

cat /etc/passwd


chmod +x /home/install-osa.sh
echo "--- RUNNING OSA INSTALL SCRIPT ---"
source /home/install-osa.sh

chmod +x /home/install-kafka.sh
echo "--- RUNNING KAFKA INSTALL SCRIPT ---"
source /home/install-kafka.sh

echo --- UPDATEING PASSWORD IN DB --- 
NEW_PWD=`cat /home/osaadmin_password.txt`
mysql -uroot -poracle -e "UPDATE OSADB.osa_users SET pwd='$NEW_PWD' WHERE username='osaadmin';"
mysql -uroot -poracle -e "FLUSH PRIVILEGES;"

echo "--- START OSA ---"
bash $OSA_HOME/osa-base/bin/start-osa.sh

echo "OSA should be running at localhost:9080/osa"

# don't go to sleep plz
tail -f /dev/null