include_attribute "kagent"
include_attribute "hops"
include_attribute "apache_hadoop"
include_attribute "hadoop_spark"
include_attribute "flink"
include_attribute "hopsworks"

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

#SSL 
default.zeppelin.ssl.enabled 				= "true"
default.zeppelin.ssl.client.auth.enabled 	= "false"
default.zeppelin.ssl.keystore.type			= "JKS"
default.zeppelin.ssl.keystore.path  		= "#{node.kagent.keystore_dir}/node_server_keystore.jks"
default.zeppelin.ssl.keystore.password 		= "#{node.hopsworks.master.password}"
default.zeppelin.ssl.truststore.type		= "JKS"
default.zeppelin.ssl.truststore.path		= "#{node.kagent.keystore_dir}/node_server_truststore.jks"
default.zeppelin.ssl.truststore.password 	= "#{node.hopsworks.master.password}"