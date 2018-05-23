#!/bin/bash

cd /opt
wget http://apache.claz.org/kafka/0.11.0.2/kafka_2.11-0.11.0.2.tgz
tar xzvf kafka_2.11-0.11.0.2.tgz
cd kafka_2.11-0.11.0.2
bin/zookeeper-server-start.sh config/zookeeper.properties &> zookeeper-start.log 
bin/kafka-server-start.sh config/server.properties &> kafka-start.log &

