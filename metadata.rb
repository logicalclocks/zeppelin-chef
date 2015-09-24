name             'zeppelin'
maintainer       "Jim Dowling"
maintainer_email "jdowling@kth.se"
license          "Apache v2"
description      'Installs/Configures Zeppelin'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0"


depends          "spark"
depends          "hops"
depends          "hadoop"
depends          "kagent"
depends          "hopsworks"

recipe           "install", "Installs Zeppelin binaries"
recipe           "default", "Starts a Zeppelin master"
