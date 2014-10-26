titan-docker
============
Builds docker container for titan db (0.5.1-hadoop2)

To Build
--------
sudo docker build -t {{ username }}/titandb .

###To Run
sudo dockre run -P {{ username }}/titandb

###Ports:

22: sshd

8182: HTTP for rest API

8183: RexPro for native access

8184: JMX Port (unlikely to be used)

####Notes:
supervisor is use to run multiple processes and monitor them.
Refer to https://docs.docker.com/articles/using_supervisord/ for more information.
