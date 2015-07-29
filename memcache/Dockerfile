FROM gauravgoyal/ubuntu:14.04

# Specifying the maintainer for this image.
MAINTAINER Gaurav Goyal "gkg.ras@gmail.com"

# All commands ran in this file must be non interactive.
ENV DEBIAN_FRONTEND noninteractive
ENV MEMORY_LIMIT 64
ENV ALLOWED_SERVERS 0.0.0.0

Run apt-get install -y memcached

EXPOSE 11211

CMD ["/usr/bin/memcached", "-u", "memcache", "-v"]
