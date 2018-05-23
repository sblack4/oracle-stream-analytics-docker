## 
# see https://docs.oracle.com/en/middleware/osa/18.1/install-stream-analytics/how-install-oracle-stream-analytics.html 
# @sblack4 2018
#

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
COPY OSA-18.1.0.0.0.zip /opt/
COPY entrypoint.sh /home/
COPY install-osa.sh /home/
COPY install-kafka.sh /home/

# delete line if not on proxy
RUN [ -z $HTTP_PROXY ] || echo 'Acquire::http::Proxy "http://www-proxy.us.oracle.com:80";' >> /etc/apt/apt.conf

    # RUN chmod +x /home/install-osa.sh && \
        # bash /home/install-osa.sh


ENTRYPOINT [ "bash", "/home/entrypoint.sh" ]