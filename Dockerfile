FROM ubuntu:14.04
MAINTAINER Jonathan Fok kan <jfokkan@gmail.com>

RUN apt-get update && apt-get install -y openssh-server supervisor curl vim wget unzip

## Supervisor configs
ADD confs/supervisor/supervisord.conf /etc/supervisor/supervisord.conf

## Install JAVA
RUN \
  apt-get update && \
  apt-get install -y openjdk-7-jdk
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

## Install titan
RUN wget http://s3.thinkaurelius.com/downloads/titan/titan-0.5.1-hadoop2.zip
RUN unzip titan-0.5.1-hadoop2.zip
RUN rm titan-0.5.1-hadoop2.zip
RUN mv titan-0.5.1-hadoop2/ /usr/local/titan

## Expose Ports
EXPOSE 22 8182:8182

# Run command
CMD ["/usr/bin/supervisord"]