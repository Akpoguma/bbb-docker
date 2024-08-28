#!/bin/bash
echo $ETHERPAD_API_KEY > /tmp/apikey
export NODE_ENV=production
export DOMAIN=${HOSTNAME}.srv02.bbb.t-assets.de

node /opt/etherpad-lite/node_modules/ep_etherpad-lite/node/server.js --apikey /tmp/apikey