# Oracle Streaming on Docker in Oracle Cloud! 


## About 
*Justifying this repos existance*

Real-time data analytics is HOT 🔥 and good Data Engineers are hard to come by. Your company 

[spark](https://spark.apache.org/), and 
[oracle streaming](https://guidoschmutz.wordpress.com/2015/03/29/installing-oracle-stream-explorer-in-a-docker-image/)

I love Spark and Scala because they are so easy to work with
and discovered oracle stream analytics (OSA) which

**Disclaimer**   
*this is informational materials only and meant to be notes to my future self or anyone else that might be interested*   
*Opinions & views expressed are soley my(our?) own and not those of my Employer*

## Getting Started

### Oracle Streaming Analytics (OSA)
OSA is available in many ways:
- On-Premises software
- As part of oracle data integrator
- as part of data integration platform cloud (DIPC v18.2+)
- as part of oracle integration cloud service 

Fortunately the kind folk of the internet have provided a docker image to be our little playground :smiley:

### Make it Run Now
```bash
# --- STEP ONE DOWNLOAD FILES ---
#   As far as I undertsand this process must be done manually because the 
#   
# Download the following files and place them into the downloads subfolder
#
# (1) ofm_integration_osa_12ofm_integration_osa_12.2.1.0.0_disk1.zip
#     Download the Oracle Stream Analytics Runtime from http://www.oracle.com/technetwork/middleware/complex-event-processing/downloads/index.html
#
# (2) server-jre-8u91-linux-x64.tar.gz
#     Download JDK from http://www.oracle.com/technetwork/java/javase/downloads/server-jre8-downloads-2133154.html
#
cd /osa-docker/oracle-stream-analytics/dockerfiles
echo --- STEP 1 DOWNLOAD FILES ---
[ -f "/12.2.1/downloads/ofm_integration_osa_12ofm_integration_osa_12.2.1.0.0_disk1.zip" ] || \
    # curl -O ...
    echo "go download the file"
[ -f "/12.2.1/downloads/server-jre-8u91-linux-x64.tar.gz" ] || \
    # curl -O ...
    echo "go download the other file"

echo --- STEP TWO BUILD IMAGE ---
#   HOW TO BUILD THIS IMAGE
#   -----------------------
# Put all downloaded files into the downloads sub-directory.
# To build the image, run: 
# cd osa-docker/oracle-stream-analytics/dockerfiles
# docker build -t gschmutz/oracle-osa:12.2.1 . 
docker-compose build
# --- STEP THREE RUN CONTAINER ---
docker-compose up

echo -- CONGRADULATIONS, PLAY WITH YOUR NEW CONTAINER --

```


### I want to explore too, what did you find? 

Head to [/docs](/docs)

## Acknowledgemens 
* @Oracle for providing [docker-images](https://github.com/oracle/docker-images) - why not OSA?
* @gschmultz for the [oracle stream analytics dockerfiles](https://github.com/gschmutz/dockerfiles)

