# changelog  
https://keepachangelog.com/en/1.0.0/ 

## 2018-05-14 

Changes need to be made to integrate with oracle/docker-image, see 
https://github.com/oracle/docker-images/blob/master/CONTRIBUTING.md#base-image-rules 

## 2018-05-10

adding to image v18.1 - manual build works
- docker-compose failed
- brought back container and bashed in 
- manually installed mysql on the OSA container
- fixed config files that `sed` was supposed to handle 
- started OSA
- YAY! for aprx 10 seconds 
- victory! time to :sleep:

## 2018-05-07

submodule https://github.com/sblack4/osa-dockerfiles added 
that contains osa dockerfiles from https://github.com/gschmutz/dockerfiles (fork)

TODO: create image of OSA 18.1   
http://www.oracle.com/technetwork/middleware/complex-event-processing/overview/index.html 

TODO: Still working on getting the docker images running with `docker-compose`    
https://guidoschmutz.wordpress.com/2015/03/29/installing-oracle-stream-explorer-in-a-docker-image/ 

