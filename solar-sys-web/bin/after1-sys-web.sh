#!/bin/sh

## java env
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-3.b12.el7_3.x86_64
export JRE_HOME=$JAVA_HOME/jre

## restart tomcat
/home/www/solar/solar-sys-web/bin/shutdown.sh
sleep 5
rm -rf /home/www/solar/solar-sys-web/webapps/solar-sys-web
/usr/local/apache-tomcat-7.0.29/bin/startup.sh
