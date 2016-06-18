# sshd
#
# VERSION               0.0.2

FROM ubuntu:14.04
MAINTAINER Avishay Sebban  <avishaysaban@gmail.com>

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

#Set 'screencast' as the password  for root
RUN echo 'root:screencast' | chpasswd

#Permit root login
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

#Set the enviorment varaible Notvisble
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

#Expose port 22 within the ontainer
EXPOSE 22

#Automaticly ssh into the container oneit is build 	
CMD ["/usr/sbin/sshd", "-D"]





#run comand:  docker build -t thakker-sshd .

