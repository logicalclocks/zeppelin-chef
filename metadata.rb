name             "zeppelin"
maintainer       "Jim Dowling"
maintainer_email "jdowling@kth.se"
license          "Apache v2"
description      'Installs/Configures Zeppelin'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"
source_url       "https://github.com/hopshadoop/zeppelin-chef"



depends          "flink"
depends          "hadoop_spark"
depends          "ndb"
depends          "hops"
depends          "apache_hadoop"
depends          "kagent"

recipe           "install", "Installs Zeppelin binaries"
recipe           "default", "Starts a Zeppelin master"
recipe           "purge", "Removes and deletes Zeppelin"

attribute "zeppelin/user",
          :description => "User to install/run zeppelin as",
          :type => 'string'

attribute "zeppelin/dir",
          :description => "zeppelin base dir",
          :type => 'string'

