FROM ubuntu:14.04
MAINTAINER Simon Schröer

#
# install default dependencies
#
RUN apt-get update && apt-get install -y nano wget openjdk-7-jdk && \
    mkdir /usr/java && ln -s /usr/lib/jvm/java-7-openjdk-amd64 /usr/java/default

#
# download solr
#
RUN cd /opt && wget http://archive.apache.org/dist/lucene/solr/4.9.1/solr-4.9.1.tgz && \
    tar xfz solr-4.9.1.tgz && cp -R solr-4.9.1/example solr && cd solr && rm -R solr

#
# set the working dir
#
WORKDIR /opt/solr

#
# copy the server configuration
#
COPY cores /opt/solr/solr

#
# use the given config file
#
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

#
# port-configuration
#
EXPOSE 8983

#
# default entrypoint
#
CMD ["/entrypoint.sh"]
