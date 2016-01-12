include_attribute "kagent"
include_attribute "hops"
include_attribute "hadoop"
include_attribute "spark"
include_attribute "flink"

default[:zeppelin][:version]             = "0.5.0-incubating"
default[:zeppelin][:spark_version]       = "1.3.1"
default[:zeppelin][:hadoop_version]      = "2.3"
default[:zeppelin][:name]                = "zeppelin-#{node[:zeppelin][:version]}-bin-spark-#{node[:zeppelin][:spark_version]}_hadoop-#{node[:zeppelin][:hadoop_version]}"
default[:zeppelin][:user]                = node[:hadoop][:yarn][:user]
default[:zeppelin][:group]               = node[:hadoop][:group]
default[:zeppelin][:port]                = 58206
default[:zeppelin][:dir]                 = "/srv"
default[:zeppelin][:base_dir]            = node[:zeppelin][:dir] + "/zeppelin" 
default[:zeppelin][:home]                = node[:zeppelin][:dir] + "/zeppelin-" + node[:zeppelin][:version]

default[:zeppelin][:url]                 = "#{node[:download_url]}/#{node[:zeppelin][:name]}.tgz"

default[:zeppelin][:executor_memory]     = "512m"
default[:zeppelin][:driver_memory]       = "1g"
default[:zeppelin][:eventlog_enabled]    = "true"
