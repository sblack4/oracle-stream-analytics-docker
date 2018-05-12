## 
# see https://docs.oracle.com/en/middleware/osa/18.1/install-stream-analytics/how-install-oracle-stream-analytics.html 
# @sblack4 2018
#
# ## To Install: 
#   - [x] take jre 
#   - [x] install spark v2.2.1
#   - [ ] install OSA v18.1
#       - [X] set JAVA_HOME & SPARK_HOME in osa-env.sh
#       - [ ] iitialize metadata (mysql) store
#   - [ ] start osa

# 
# FROM oracle/serverjre:8 
 
# POC with 
# https://github.com/BirgerK/docker-apache-spark 
FROM birgerk/apache-spark
LABEL maintainer "steven.black@oracle.com"

ENV SPARK_HOME=/usr/local/spark
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV OSA_HOME=/opt/OSA-18.1.0.0.0
# ENV HTTP_PROXY="http://www-proxy.us.oracle.com:80"

# install Spark 
# RUN cd /opt \
#     curl -O https://www.apache.org/dyn/closer.lua/spark/spark-2.2.1/spark-2.2.1-bin-hadoop2.7.tgz \
#     tar xvzf spark-2.2.1-bin-hadoop2.7.tgz 

# install OSA 
COPY OSA-18.1.0.0.0.zip /tmp/
COPY entrypoint.sh /home/

RUN [ -z $HTTP_PROXY ] || echo 'Acquire::http::Proxy "http://www-proxy.us.oracle.com:80";' >> /etc/apt/apt.conf

RUN apt-get update && \
    apt-get install -y unzip mysql-server && \
    unzip /tmp/OSA-18.1.0.0.0.zip -d /opt && \
    rm -rf /tmp/OSA-18.1.0.0.0.zip

RUN sed -i '/#export JAVA_HOME=/c\export JAVA_HOME=${JAVA_HOME}' $OSA_HOME/osa-base/etc/osa-env.sh && \
    sed -i '/#export SPARK_HOME=/c\export SPARK_HOME=${SPARK_HOME}' $OSA_HOME/osa-base/etc/osa-env.sh && \
    sed -i '34d;48d' $OSA_HOME/osa-base/etc/jetty-osa-datasource.xml && \
    sed -i 's#myhost.example.com:3307/OSADB#mysql:3306/OSADB#g' $OSA_HOME/osa-base/etc/jetty-osa-datasource.xml && \
    sed -i 's#{OSA_USER}#root#g' $OSA_HOME/osa-base/etc/jetty-osa-datasource.xml && \
    sed -i 's#{OSA_USER_PWD}#oracle#g' $OSA_HOME/osa-base/etc/jetty-osa-datasource.xml



ENTRYPOINT [ "bash", "/home/entrypoint.sh" ]