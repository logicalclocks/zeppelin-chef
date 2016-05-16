include_attribute "kagent"
include_attribute "hops"
include_attribute "apache_hadoop"
include_attribute "hadoop_spark"
include_attribute "flink"

default.zeppelin.version             = "0.6.0-incubating-SNAPSHOT"
default.zeppelin.spark_version       = "1.5.2"
default.zeppelin.hadoop_version      = "2.4"
default.zeppelin.name                = "zeppelin-#{node.zeppelin.version}-bin-spark-#{node.zeppelin.spark_version}_hadoop-#{node.zeppelin.hadoop_version}"
default.zeppelin.user                = node.apache_hadoop.yarn.user
default.zeppelin.group               = node.apache_hadoop.group
default.zeppelin.port                = 58206
default.zeppelin.dir                 = "/srv"
default.zeppelin.base_dir            = node.zeppelin.dir + "/zeppelin" 
default.zeppelin.home                = node.zeppelin.dir + "/zeppelin-" + node.zeppelin.version

default.zeppelin.url                 = "#{node.download_url}/#{node.zeppelin.name}.tar.gz"

default.zeppelin.executor_memory     = "512m"
default.zeppelin.driver_memory       = "1g"
default.zeppelin.eventlog_enabled    = "true"

default.livy.version                 = "0.2.0"
default.livy.url                     = "#{node.download_url}/livy-#{node.livy.version}.tgz"
default.livy.port                    = "8998"
default.livy.dir                     = "/srv"
default.livy.home                    =  node.livy.dir + "/livy" 
default.ivy.keystore                 = "#{node.kagent.base_dir}/keystore.jks"
default.ivy.keystore_password        = ""
