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
recipe           "livy",    "Installs a Livy Spark REST Server"

attribute "zeppelin/user",
          :description => "User to install/run zeppelin as",
          :type => 'string'

attribute "zeppelin/dir",
          :description => "zeppelin base dir",
          :type => 'string'

attribute "livy.version",
          :dscription => "livy.version",
          :type => "string"

attribute "livy.url",
          :dscription => "livy.url",
          :type => "string"

attribute "livy.port",
          :dscription => "livy.port",
          :type => "string"

attribute "livy.home",
          :dscription => "livy.home",
          :type => "string"

attribute "ivy.keystore",
          :dscription => "ivy.keystore",
          :type => "string"

attribute "ivy.keystore.password",
          :dscription => "ivy.keystore.password",
          :type => "string"
