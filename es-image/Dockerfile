FROM docker.elastic.co/elasticsearch/elasticsearch-basic:6.2.0

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3

RUN mkdir -p /aws

COPY access_key /aws/access_key
COPY secret_key /aws/secret_key

RUN cat /aws/access_key

RUN \
  cat /aws/access_key | base64 --decode | bin/elasticsearch-keystore add --stdin --force s3.client.default.access_key && \
  cat /aws/secret_key | base64 --decode | bin/elasticsearch-keystore add --stdin --force s3.client.default.secret_key

RUN rm -fR /aws
