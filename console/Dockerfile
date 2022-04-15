FROM tutum/ubuntu:latest@sha256:b9a594f451f9f32f8541745c79c546f00148eb0a934c53ae3a6a84f684f95005

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install telnet screen vim
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install postgresql-client 

ADD screenrc /root/.screenrc
ADD bash_profile /root/.bash_profile

EXPOSE 22
CMD [ "/run.sh" ]


