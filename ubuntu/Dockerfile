FROM ubuntu

# Specifying the maintainer for this image.
MAINTAINER Gaurav Goyal "gkg.ras@gmail.com"

# All commands ran in this file must be non interactive.
ENV DEBIAN_FRONTEND noninteractive

# Update the sources.list file to support multiverse packages, used for downlong libapache2-mod-fastcgi

COPY sources.list /etc/apt/sources.list

# Update the system.
RUN apt-get update --fix-missing
