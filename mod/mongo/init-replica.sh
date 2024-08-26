#!/bin/sh
set -e

host=${HOSTNAME:-$(hostname -f)}

# Shut down any running MongoDB instance
mongod --pidfilepath /tmp/docker-entrypoint-temp-mongod.pid --shutdown || true

# Restart MongoDB with replica set and appropriate bindings
mongod --oplogSize 8 --replSet rs0 --noauth \
  --bind_ip 0.0.0.0 --port 27017 \
  --tlsMode disabled \
  --logpath /proc/1/fd/1 --logappend \
  --pidfilepath /tmp/docker-entrypoint-temp-mongod.pid --fork

# Initialize replica set using the current hostname
mongo "${host}" --eval "rs.initiate({
  _id: 'rs0',
  members: [ { _id: 0, host: '${host}:27017' } ]
})"

echo "Waiting to become a master"
echo 'while (!db.isMaster().ismaster) { sleep(100); }' | mongo "${host}"

echo "I'm the master!"
