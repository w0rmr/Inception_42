#!/bin/bash

sed -i \
-e 's/^bind .*/bind 0.0.0.0/' \
-e 's/^# maxmemory <bytes>/maxmemory 256mb/' \
-e 's/^# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/' \
/etc/redis/redis.conf

exec redis-server --protected-mode no