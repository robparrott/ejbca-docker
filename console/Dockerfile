FROM tutum/ubuntu

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install telnet screen vim
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install postgresql-client 

ADD screenrc /root/.screenrc
ADD bash_profile /root/.bash_profile

EXPOSE 22
CMD [ "/run.sh" ]


