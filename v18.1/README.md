# OSA v18.1

Much of this document is me thinking aloud

from https://docs.oracle.com/en/middleware/osa/18.1/install-stream-analytics/how-install-oracle-stream-analytics.html 

This install requires: 
- Oracle JDK 8 Update 131 and higher versions
- Repository Database
    - Oracle Database versions 12.2.0.1 or higher, 12.1.0.1 or higher, and 11.2.0.4 or higher
    - Else, you can use MySQL version 5.6 or higher
- A running Hadoop cluster with version 2.7 or higher
- Spark runtime environment
- A running Kafka cluster with version 0.10.2 or higher
- Locally installed Spark with version 2.2.1 or higher

Which is a lot for one container, so if we were to use a maximal number of containers

- jdk/osa/spark
- hadoop
- kafka
- mysql

I think more reasonably
- jdk/osa/spark
- mysql
- kafka
and forget about hadoop (we won't be using it)

So the steps can be: 
1. start mysql
2. start jdk/osa/spark
3. (optnl) start kafka

