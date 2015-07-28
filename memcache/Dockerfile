FROM gauravgoyal/ubuntu:14.04

# Specifying the maintainer for this image.
MAINTAINER Gaurav Goyal "gkg.ras@gmail.com"

# All commands ran in this file must be non interactive.
ENV DEBIAN_FRONTEND noninteractive

Run apt-get install -y memcached

USER memcache

EXPOSE 11211

ADD run.sh /run.sh

CMD ["/run.sh"]
