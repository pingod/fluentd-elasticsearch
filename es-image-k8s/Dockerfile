# DockerFile:https://github.com/elastic/elasticsearch-docker/tree/6.2
FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.4
#FROM docker.elastic.co/elasticsearch/elasticsearch:5.6.10

VOLUME ["/data"]
EXPOSE 9200 9300
env ES_TMPDIR=/tmp
env MINIMUM_MASTER_NODES=1
env HTTP_PORT=9200
env NODE_DATA=true
env NODE_MASTER=true
env NODE_NAME=elasticsearch-logging-0
env TRANSPORT_PORT=9300

COPY elasticsearch_logging_discovery run.sh bin/
COPY config/elasticsearch.yml config/log4j2.properties config/

RUN curl -s https://www.amazontrust.com/repository/SFSRootCAG2.pem | $JAVA_HOME/bin/keytool -cacerts -storepass changeit -importcert -noprompt

RUN mkdir -p /aws
COPY access_key /aws/access_key
COPY secret_key /aws/secret_key
RUN  bin/elasticsearch-keystore create
RUN \
  cat /aws/access_key | bin/elasticsearch-keystore add --stdin --force s3.client.default.access_key && \
#  echo "S3SignerType" | bin/elasticsearch-keystore add --stdin s3.client.default.signer && \
  cat /aws/secret_key | bin/elasticsearch-keystore add --stdin --force s3.client.default.secret_key
RUN rm -fR /aws
COPY repository-s3-6.2.4.zip /tmp/s3.zip
USER root
#RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch file:///tmp/s3.zip
RUN chown -R elasticsearch:elasticsearch ./
CMD ["bash","-x","bin/run.sh"]
