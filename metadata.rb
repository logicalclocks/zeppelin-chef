name             "zeppelin"
maintainer       "Jim Dowling"
maintainer_email "jdowling@kth.se"
license          "Apache v2"
description      'Installs/Configures Zeppelin'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"


depends          "flink"
depends          "spark"
depends          "hops"
depends          "hadoop"
depends          "kagent"

recipe           "install", "Installs Zeppelin binaries"
recipe           "default", "Starts a Zeppelin master"

attribute "zeppelin/user",
          :description => "User to install/run zeppelin as",
          :type => 'string'

attribute "zeppelin/dir",
          :description => "zeppelin base dir",
          :type => 'string'

