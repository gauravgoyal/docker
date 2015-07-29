FROM ubuntu

# Specifying the maintainer for this image.
MAINTAINER Gaurav Goyal "gkg.ras@gmail.com"

# All commands ran in this file must be non interactive.
ENV DEBIAN_FRONTEND noninteractive

# Update the sources.list file to support multiverse packages, used for downlong libapache2-mod-fastcgi

COPY sources.list /etc/apt/sources.list

# Update the system.
RUN apt-get update --fix-missing && apt-get install -y openssh-server

# SSH Settings
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

# Expose port 22 for ssh inside the container.
EXPOSE 22
