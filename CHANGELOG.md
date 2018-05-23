# changelog  
https://keepachangelog.com/en/1.0.0/ 

## 2018-05-23
The celebration was premature as now the containers start and everything but I cannot submit jobs to spark. Well, the jobs are submitted but then are almost immediately killed. 

the spark and other OSA logs didn't reveal much. I changed the loglevel of spark but perhaps I needed to change the files from `*.template`. oh well, 
maybe this application is too big for containers 

**the view of our OSA app**
```
osa_1  | 2018-05-23 17:58:29 INFO  StreamingRuntimeSpark:202 -- ----------------------------------------------------------------
osa_1  | 2018-05-23 17:58:29 INFO  StreamingRuntimeSpark:203 --  DEPLOYING APPLICATION: sx_test_tweets_pipeline_ED201621_4832_4EAC_8B7E_6B54644B0E42_9YNptmEt_draft
osa_1  | 2018-05-23 17:58:29 INFO  StreamingRuntimeSpark:204 -- ----------------------------------------------------------------
osa_1  | 2018-05-23 17:58:29 INFO  StreamingRuntimeSpark:205 -- <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
osa_1  | <application zookeeperServer="osa:2181" batchIntervalMillis="1000">
osa_1  |     <components>
osa_1  |         <printTarget trim="false" maxCount="10" showPartition="false" name="printTarget_0" source-ref="sx_test_tweets_pipeline_ED201621_4832_4EAC_8B7E_6B54644B0E42_9YNptmEt_draft_st9AB14C3A_5238_47D0_BB27_6E4B0D3D5BAA">
osa_1  |             <outbound/>
osa_1  |         </printTarget>
osa_1  |         <liveOutput enabled="true" name="sx_test_tweets_pipeline_ED201621_4832_4EAC_8B7E_6B54644B0E42_9YNptmEt_draft_st9AB14C3A_5238_47D0_BB27_6E4B0D3D5BAA" source-ref="tweet"/>
osa_1  |         <adapterSource name="tweet">
osa_1  |             <connectorClassName>com.oracle.cep.adapters.file.FileSource</connectorClassName>
osa_1  |             <converterClassName>com.oracle.cep.converters.csv.CsvSourceConverter</converterClassName>
osa_1  |             <dataType>java.lang.String</dataType>
osa_1  |             <shape name="tweet">
osa_1  |                 <field name="id" type="string" path="id"/>
osa_1  |                 <field name="text" type="string" path="text"/>
osa_1  |                 <field name="favorite_count" type="string" path="favorite_count"/>
osa_1  |                 <field name="retweet_count" type="string" path="retweet_count"/>
osa_1  |                 <field name="quote_count" type="string" path="quote_count"/>
osa_1  |                 <field name="reply_count" type="string" path="reply_count"/>
osa_1  |                 <field name="lang" type="string" path="lang"/>
osa_1  |                 <field name="user_id" type="string" path="user_id"/>
osa_1  |                 <field name="datetime" type="string" path="datetime"/>
osa_1  |                 <field name="state" type="string" path="state"/>
osa_1  |                 <field name="provider" type="string" path="provider"/>
osa_1  |             </shape>
osa_1  |             <distributable>false</distributable>
osa_1  |             <parameters>
osa_1  |                 <entries key="com.oracle.cep.converters.csv.CsvSourceConverter#predefinedFormat" valueType="String">Default</entries>
osa_1  |                 <entries key="com.oracle.cep.converters.csv.CsvSourceConverter#hasHeader" valueType="Boolean">true</entries>
osa_1  |                 <entries key="com.oracle.cep.adapters.file.FileSource#loop" valueType="Boolean">true</entries>
osa_1  |                 <entries key="com.oracle.cep.adapters.file.FileSource#contentType" valueType="String">java.lang.String</entries>
osa_1  |                 <entries key="converterClassName" valueType="String">com.oracle.cep.converters.csv.CsvSourceConverter</entries>
osa_1  |                 <entries key="com.oracle.cep.adapters.file.FileSource#maxEvents" valueType="Integer">1</entries>
osa_1  |                 <entries key="com.oracle.cep.adapters.file.FileSource#fileUrl" valueType="String">res://tweets.csv_1DA29FA0-E0E5-461E-ACE8-B4760E3CC3E4</entries>
osa_1  |                 <entries key="connectorClassName" valueType="String">com.oracle.cep.adapters.file.FileSource</entries>
osa_1  |                 <entries key="com.oracle.cep.converters.csv.CsvSourceConverter#contentType" valueType="String">java.lang.String</entries>
osa_1  |                 <entries key="contentType" valueType="String">CSV</entries>
osa_1  |             </parameters>
osa_1  |         </adapterSource>
osa_1  |     </components>
osa_1  | </application>
osa_1  |
osa_1  | 2018-05-23 17:58:29 INFO  StreamingRuntimeSpark:206 -- ----------------------------------------------------------------
osa_1  | 2018-05-23 17:58:30 INFO  StreamingRuntimeSpark:225 -- Fresh deployment for sx_test_tweets_pipeline_ED201621_4832_4EAC_8B7E_6B54644B0E42_9YNptmEt_draft
osa_1  | 2018-05-23 17:58:40 INFO  ZooKeeper:441 -- Initiating client connection, connectString=osa:2181 sessionTimeout=10000 watcher=oracle.wlevs.strex.kafka.impl.KafkaClientImpl$$Lambda$99/697565813@1943cf36
osa_1  | 2018-05-23 17:58:40 INFO  ClientCnxn:1035 -- Opening socket connection to server eeb3fe0055b6/172.21.0.2:2181. Will not attempt to authenticate using SASL (unknown error)
osa_1  | 2018-05-23 17:58:40 INFO  ClientCnxn:877 -- Socket connection established to eeb3fe0055b6/172.21.0.2:2181, initiating session
osa_1  | 2018-05-23 17:58:40 INFO  ClientCnxn:1302 -- Session establishment complete on server eeb3fe0055b6/172.21.0.2:2181, sessionid = 0x1638dc39dd3000a, negotiated timeout = 10000
osa_1  | 2018-05-23 17:58:40 INFO  ClientCnxn:520 -- EventThread shut down for session: 0x1638dc39dd3000a
osa_1  | 2018-05-23 17:58:40 INFO  ZooKeeper:687 -- Session: 0x1638dc39dd3000a closed
osa_1  | 2018-05-23 17:58:40 INFO  KafkaNotificationService:98 -- Process cluster notification: {"details":null,"entityID":null,"eventKind":"ZK_CONNECTION_CHANGED","objectKind":"SYSTEM"}
osa_1  | 2018-05-23 17:58:40 INFO  SXResources:221 -- Process ZK connection change: null --> null
osa_1  | 2018-05-23 17:59:30 ERROR StreamingRuntimeSpark:271 -- Starting application failed: Spark application did not started successfully after 60000 ms.
osa_1  | oracle.wlevs.strex.spark.client.spi.SparkException: Spark application did not started successfully after 60000 ms.
osa_1  |        at oracle.wlevs.strex.spark.client.impl.SparkClientBase.waitForRunning(SparkClientBase.java:580) ~[?:?]
osa_1  |        at oracle.wlevs.strex.spark.client.spi.SparkBackend.submit(SparkBackend.java:156) ~[osa.spark-integration.client-spi.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.spark.client.spi.SparkBackend.submit(SparkBackend.java:135) ~[osa.spark-integration.client-spi.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.rts.spark.SXSparkAppRedeployer.deployApplication(SXSparkAppRedeployer.java:226) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.rts.spark.SXSparkAppRedeployer.deployApplication(SXSparkAppRedeployer.java:57) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.rts.spark.StreamingRuntimeSpark.deployApplication(StreamingRuntimeSpark.java:5) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.core.OsaApplicationManager.deployApplication(OsaApplicationManager.java:2281) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.core.OsaApplicationManager.access$1100(OsaApplicationManager.java:60) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.core.OsaApplicationManager$AsynchDeployment.fullDeploy(OsaApplicationManager.java:1227) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.core.OsaApplicationManager.fullDeploy(OsaApplicationManager.java:1012) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.core.OsaApplicationManager.access$400(OsaApplicationManager.java:60) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.core.OsaApplicationManager$DeploymentQueue.lambda$submitFullDeploy$2(OsaApplicationManager.java:985) ~[osa.web.common.jar:12.2.1]
osa_1  |        at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511) [?:1.8.0_151]
osa_1  |        at java.util.concurrent.FutureTask.run(FutureTask.java:266) [?:1.8.0_151]
osa_1  |        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149) [?:1.8.0_151]
osa_1  |        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624) [?:1.8.0_151]
osa_1  |        at java.lang.Thread.run(Thread.java:748) [?:1.8.0_151]
osa_1  | 2018-05-23 17:59:30 INFO  StreamingRuntimeSpark:548 -- Undeploy Spark application: 'PDeploymentInfo[id=null|appName=sx_test_tweets_pipeline_ED201621_4832_4EAC_8B7E_6B54644B0E42_9YNptmEt_draft|submissionId=null|stagingFolder=null|snapshotFolder=null|kafkaTopics=-|assignee=0]'
osa_1  | 2018-05-23 17:59:30 INFO  OsaApplicationManager:1229 -- Full deploy failed:
osa_1  | oracle.wlevs.strex.common.errors.OSAException: OSA-01265 Pipeline deployment has failed.
osa_1  |        at oracle.wlevs.strex.common.rts.spark.SXSparkAppRedeployer.deployApplication(SXSparkAppRedeployer.java:274) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.rts.spark.SXSparkAppRedeployer.deployApplication(SXSparkAppRedeployer.java:57) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.rts.spark.StreamingRuntimeSpark.deployApplication(StreamingRuntimeSpark.java:5) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.core.OsaApplicationManager.deployApplication(OsaApplicationManager.java:2281) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.core.OsaApplicationManager.access$1100(OsaApplicationManager.java:60) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.core.OsaApplicationManager$AsynchDeployment.fullDeploy(OsaApplicationManager.java:1227) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.core.OsaApplicationManager.fullDeploy(OsaApplicationManager.java:1012) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.core.OsaApplicationManager.access$400(OsaApplicationManager.java:60) ~[osa.web.common.jar:12.2.1]
osa_1  |        at oracle.wlevs.strex.common.core.OsaApplicationManager$DeploymentQueue.lambda$submitFullDeploy$2(OsaApplicationManager.java:985) ~[osa.web.common.jar:12.2.1]
osa_1  |        at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511) [?:1.8.0_151]
osa_1  |        at java.util.concurrent.FutureTask.run(FutureTask.java:266) [?:1.8.0_151]
osa_1  |        at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149) [?:1.8.0_151]
osa_1  |        at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624) [?:1.8.0_151]
osa_1  |        at java.lang.Thread.run(Thread.java:748) [?:1.8.0_151]
osa_1  | 2018-05-23 17:59:41 INFO  ZooKeeper:441 -- Initiating client connection, connectString=osa:2181 sessionTimeout=10000 watcher=oracle.wlevs.strex.kafka.impl.KafkaClientImpl$$Lambda$99/697565813@3f8d59d3
osa_1  | 2018-05-23 17:59:41 INFO  ClientCnxn:1035 -- Opening socket connection to server eeb3fe0055b6/172.21.0.2:2181. Will not attempt to authenticate using SASL (unknown error)
osa_1  | 2018-05-23 17:59:41 INFO  ClientCnxn:877 -- Socket connection established to eeb3fe0055b6/172.21.0.2:2181, initiating session
osa_1  | 2018-05-23 17:59:41 INFO  ClientCnxn:1302 -- Session establishment complete on server eeb3fe0055b6/172.21.0.2:2181, sessionid = 0x1638dc39dd3000b, negotiated timeout = 10000
osa_1  | 2018-05-23 17:59:41 INFO  ClientCnxn:520 -- EventThread shut down for session: 0x1638dc39dd3000b
osa_1  | 2018-05-23 17:59:41 INFO  ZooKeeper:687 -- Session: 0x1638dc39dd3000b closed
osa_1  | 2018-05-23 17:59:41 INFO  KafkaNotificationService:98 -- Process cluster notification: {"details":null,"entityID":null,"eventKind":"ZK_CONNECTION_CHANGED","objectKind":"SYSTEM"}
osa_1  | 2018-05-23 17:59:41 INFO  SXResources:221 -- Process ZK connection change: null --> null
```

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

