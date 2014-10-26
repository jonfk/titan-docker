FROM ubuntu:14.04
MAINTAINER Jonathan Fok kan <jfokkan@gmail.com>

RUN apt-get update && apt-get install -y -qq openssh-server supervisor curl vim wget unzip
RUN mkdir -p /var/run/sshd /var/log/supervisor /var/run/titan

## setup user
RUN useradd docker
RUN echo docker:docker | chpasswd
RUN echo 'docker ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

## Supervisor configs
COPY confs/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

## Install JAVA
RUN \
  apt-get update && \
  apt-get install -y -qq openjdk-7-jdk
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

## Install titan
RUN wget -q http://s3.thinkaurelius.com/downloads/titan/titan-0.5.1-hadoop2.zip
RUN unzip titan-0.5.1-hadoop2.zip
RUN rm titan-0.5.1-hadoop2.zip
RUN mv titan-0.5.1-hadoop2/ /usr/local/titan

## Expose Ports
EXPOSE 22
EXPOSE 8182 8183 8184

# Run command
CMD ["/usr/bin/supervisord"]