#
# take jre 
# install spark v2.2.1
# install OSA v18.1
# start osa

# 
# FROM oracle/serverjre:8

# POC with 
# https://github.com/BirgerK/docker-apache-spark 
FROM birgerk/apache-spark
LABEL maintainer "steven.black@oracle.com"

# ENV JAVA_HOME 
ENV SPARK_HOME /usr/local/spark
ENV OSA_HOME /opt/OSA-18.1.0.0.0

# install Spark 
# RUN cd /opt \
#     curl -O https://www.apache.org/dyn/closer.lua/spark/spark-2.2.1/spark-2.2.1-bin-hadoop2.7.tgz \
#     tar xvzf spark-2.2.1-bin-hadoop2.7.tgz 

# install OSA 
COPY OSA-18.1.0.0.0.zip /opt

# set spark_home for osa
RUN sed 

# set java home for osa

