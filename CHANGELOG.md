# changelog  
https://keepachangelog.com/en/1.0.0/ 

## 2018-05-22
IT WORKS! looks like the error was a number of things, 
notably you must wait until the last minute to update the new osaadmin password in the database... 

## 2018-05-15
fixes - the build gets *almost* there!

build fails at the last moment!
I'm not sure what it is: 
- I think that it may be related to the password change for mysql (see below log)
- behavior changes with changes to jetty config


```log
osa_1  | initialize metastore
osa_1  | JAVA_HOME: /usr/lib/jvm/java-8-openjdk-amd64
osa_1  | SPARK_HOME: /usr/local/spark
osa_1  | The RELEASE file exists: /usr/local/spark/RELEASE
osa_1  | SPARK_VERSION: Spark 2.2.1 built for Hadoop 2.7.3
osa_1  | dbRoot connectionString is: jdbc:mysql://localhost:3306/mysql?zeroDateTimeBehavior=convertToNull
osa_1  | OSA DB user exist: root
osa_1  | May 16, 2018 4:12:37 AM oracle.osa.installer.MySQLDbCreator createSchemaAndUser
osa_1  | SEVERE: null
osa_1  | java.sql.BatchUpdateException: Can't find any matching row in the user table
osa_1  |        at com.mysql.jdbc.StatementImpl.executeBatch(StatementImpl.java:1177)
osa_1  |        at oracle.osa.installer.MySQLDbCreator.createSchemaAndUser(MySQLDbCreator.java:98)
osa_1  |        at oracle.osa.installer.OSAInstaller.createNewUser(OSAInstaller.java:128)
osa_1  |        at oracle.osa.installer.OSAInstaller.main(OSAInstaller.java:154)
osa_1  |
osa_1  | The OSA schema configuration/install has failed.
osa_1  | Exception in thread "main" oracle.osa.installer.OSAInstallerException: Failed to create new user root; and/or database: OSADB
osa_1  |        at oracle.osa.installer.MySQLDbCreator.createSchemaAndUser(MySQLDbCreator.java:111)
osa_1  |        at oracle.osa.installer.OSAInstaller.createNewUser(OSAInstaller.java:128)
osa_1  |        at oracle.osa.installer.OSAInstaller.main(OSAInstaller.java:154)
osa_1  | Caused by: java.sql.BatchUpdateException: Can't find any matching row in the user table
osa_1  |        at com.mysql.jdbc.StatementImpl.executeBatch(StatementImpl.java:1177)
osa_1  |        at oracle.osa.installer.MySQLDbCreator.createSchemaAndUser(MySQLDbCreator.java:98)
osa_1  |        ... 2 more
osa_1  | change admin pswd
osa_1  | -- GET YOUR PASSWORD HERE ...
osa_1  | -- PWD IS THE VALUE FOLLOWING 'OBF:'... 1v2h1x1h1rwd1rwh1x151v1x
osa_1  | 2018-05-16 04:12:37.395:INFO::main: Logging initialized @133ms to org.eclipse.jetty.util.log.StdErrLog
osa_1  | oracle
osa_1  | OBF:1v2h1x1h1rwd1rwh1x151v1x
osa_1  | MD5:a189c633d9995e11bf8607170ec9a4b8
osa_1  | CRYPT:osIrDSntBazcU
osa_1  | 1v2h1x1h1rwd1rwh1x151v1x
osa_1  | seed database
osa_1  | mysql: [Warning] Using a password on the command line interface can be insecure.
osa_1  | ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)
osa_1  | --- START OSA ---
osa_1  | JAVA_HOME: /usr/lib/jvm/java-8-openjdk-amd64
osa_1  | SPARK_HOME: /usr/local/spark
osa_1  | The RELEASE file exists: /usr/local/spark/RELEASE
osa_1  | SPARK_VERSION: Spark 2.2.1 built for Hadoop 2.7.3
osa_1  | Seeding mysql schema
osa_1  | OSA schema version: 18.1.0.0.0
osa_1  | SPARK_HOME: /usr/local/spark; JAVA_HOME: /usr/lib/jvm/java-8-openjdk-amd64
osa_1  | --- OSA STARTED ---
osa_1  | --- TAILING LOGS ---
osa_1  | total 8.0K
osa_1  | drwxr-xr-x  2 root root 4.0K May 16 04:12 .
osa_1  | drwxr-xr-x 12 root root 4.0K May 16 04:12 ..
osa_1  | 2018-05-16 04:12:45 INFO  log:192 -- Logging initialized @698ms to org.eclipse.jetty.util.log.Slf4jLog
osa_1  | 2018-05-16 04:12:45 INFO  log:-2 -- Console stderr/stdout captured to /opt/OSA-18.1.0.0.0/osa-base/logs/2018_05_16.jetty.log
osa_1  | 2018-05-16 04:12:45 WARN  log:-2 -- Demo osa-realm is deployed. DO NOT USE IN PRODUCTION!
osa_1  | 2018-05-16 04:12:45 INFO  Server:373 -- jetty-9.4.7.v20170914
osa_1  | 2018-05-16 04:12:45 INFO  ScanningAppProvider:133 -- Deployment monitor [file:///opt/OSA-18.1.0.0.0/osa-base/webapps/] at interval 1
osa_1  | tail: cannot open 'jetty.log' for reading: No such file or directory
osa_1  | tail: no files remaining
osa_1  | tail: cannot open 'jetty.log' for reading: No such file or directory
osa_1  | tail: no files remaining
osa_1  | 2018-05-16 04:12:48 INFO  AnnotationConfiguration:480 -- Scanning elapsed time=77ms
osa_1  | 2018-05-16 04:12:48 INFO  StandardDescriptorProcessor:281 -- NO JSP Support for /osa/services, did not find org.eclipse.jetty.jsp.JettyJspServlet
osa_1  | 2018-05-16 04:12:48 INFO  session:364 -- DefaultSessionIdManager workerName=node0
osa_1  | 2018-05-16 04:12:48 INFO  session:369 -- No SessionScavenger set, using defaults
osa_1  | 2018-05-16 04:12:48 INFO  session:149 -- Scavenging every 600000ms
osa_1  | 2018-05-16 04:12:48 DEBUG SXApplicationLifecycleListener:54 -- ================== TEST SLF4J logging message
```


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

