# use ubuntu 20.04 as base image
FROM ubuntu:20.04

# set user and directory
USER root
WORKDIR /tmp

# EDIT USERNAME AND PASSWORD
ARG username=serafim
ARG userpaswd=1234

# install main tools
RUN apt-get -y update && \
	apt-get -y install nano \
		net-tools \
		openssh-server \
		sudo \
		ufw \
		supervisor \
		curl

# nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

# open port 22 for docker
EXPOSE 22
RUN ufw allow ssh

# add user
RUN useradd -rm -u 1001 -G sudo -s /bin/bash $username
RUN echo "$username:$userpaswd" | chpasswd

#Set up SSH access
RUN mkdir /var/run/sshd
RUN sed -i.bak s/PermitRootLogin\ prohibit-password/PermitRootLogin\ yes/g  /etc/ssh/sshd_config

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# open ports 80 and 443 for http and https, 3306 for mysql
EXPOSE 80
EXPOSE 443
RUN ufw allow 80
RUN ufw allow 443

# start webserver and ssh

CMD ["/usr/bin/supervisord"]