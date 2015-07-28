#!/bin/bash

memcache -m "${MEMORY_ALLOWED}"
memcache -l "${ALLOWED_SERVERS}"

service memcached start
