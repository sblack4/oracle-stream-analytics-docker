## About 
*Justifying this repos existance*

Real-time data analytics is HOT 🔥 and good Data Engineers are hard to come by. 
You need to analyze streaming data now! What do you do? Deploy OSA! 


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

#### OSA v12
The v12 image is pretty much stolen from the interwebs and adapted. 
I got it to work by bashing into the container but I wouldn't recommend using it unless you are ready to troubleshoot...

#### OSA v18.1 
I did it! it should work just by running `docker-compose up` but if it doesn't let me know!
Right now everything is running in one container but I'll probably set it up for multiple containers 
before giving the oracle/docker-images repo a PR :smiley: 

