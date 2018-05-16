#!/bin/env bash
# setup & entry script
# @sblack4 2018

cat /etc/passwd


chmod +x /home/install-osa.sh
source /home/install-osa.sh

echo --- START OSA --- 
# start osa
bash $OSA_HOME/osa-base/bin/start-osa.sh
echo --- OSA STARTED ---

echo --- TAILING LOGS --- 
ls -lha $OSA_HOME/osa-base/logs
tail -f $(ls $OSA_HOME/osa-base/logs | tail -n 1)

while true; do sleep 2; tail -f $(ls $OSA_HOME/osa-base/logs | tail -n 1) ; done