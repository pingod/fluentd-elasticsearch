#!/bin/sh
set -ex

export NODE_NAME=${NODE_NAME:-${HOSTNAME}}
export NODE_MASTER=${NODE_MASTER:-true}
export NODE_DATA=${NODE_DATA:-true}
export HTTP_PORT=${HTTP_PORT:-9200}
export TRANSPORT_PORT=${TRANSPORT_PORT:-9300}
export MINIMUM_MASTER_NODES=${MINIMUM_MASTER_NODES:-2}
chown -R elasticsearch:elasticsearch /data
chmod +x ./bin/elasticsearch_logging_discovery 
./bin/elasticsearch_logging_discovery >> ./config/elasticsearch.yml
#ls -ld  /usr/share/elasticsearch/bin/elasticsearch-plugin
#chmod 777  /usr/share/elasticsearch/bin/elasticsearch-plugin
#exec su elasticsearch -c /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3 
mkdir /backup
chmod 777 /backup
exec su elasticsearch -c /usr/local/bin/docker-entrypoint.sh
