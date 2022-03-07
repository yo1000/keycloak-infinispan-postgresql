FROM ubuntu:20.04

# Set the INFINISPAN_SERVER_HOME env variable
ENV INFINISPAN_SERVER_HOME /opt/jboss/infinispan-server

# Set the INFINISPAN_VERSION env variable
ENV INFINISPAN_VERSION 9.4.24.Final

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

# Server download location
ENV DISTRIBUTION_URL https://downloads.jboss.org/infinispan/$INFINISPAN_VERSION/infinispan-server-$INFINISPAN_VERSION.zip

# Labels
LABEL name="Infinispan Server" \
      version="$INFINISPAN_VERSION" \
      release="$INFINISPAN_VERSION" \
      architecture="x86_64" \
      io.k8s.description="Provides a scalable in-memory distributed database designed for fast access to large volumes of data." \
      io.k8s.display-name="Infinispan Server" \
      io.openshift.expose-services="8080:http,11222:hotrod" \
      io.openshift.tags="datagrid,java,jboss" \
      io.openshift.s2i.scripts-url="image:///usr/local/s2i/bin"

USER root

RUN apt-get -y update; \
    apt-get -y install \
        tzdata; \
    apt-get -y install \
        openjdk-11-jdk \
        bind9-utils \
        iproute2 \
        iputils-ping \
        lua5.3 luarocks \
        lsof \
        less \
        curl \
        zip \
        jq

ENV HOME /opt/jboss/
WORKDIR $HOME

COPY ./server/infinispan-server-9.4.24.Final.zip.* $HOME
RUN cat $HOME/infinispan-server-${INFINISPAN_VERSION}.zip.* > $HOME/infinispan-server-${INFINISPAN_VERSION}.zip
RUN unzip -q $HOME/infinispan-server-${INFINISPAN_VERSION}.zip
RUN mv $HOME/infinispan-server-${INFINISPAN_VERSION} $HOME/infinispan-server

RUN chown -R 1000.0 $HOME/infinispan-server/
RUN chmod -R g+rw $HOME/infinispan-server/
RUN find $HOME/infinispan-server/ -type d -exec chmod g+x {} +

COPY ./lib/* $HOME
RUN $HOME/infinispan-server/bin/ispn-cli.sh --command="module add \
    --name=org.postgresql \
    --resources=postgresql-42.2.19.jar \
    --dependencies=javax.api,javax.transaction.api"

COPY ./conf/standalone.xml $HOME/infinispan-server/standalone/configuration/

USER 1000

# S2I Scripts
COPY ./server/.s2i /usr/local/s2i
# Copy entrypoint script
COPY ./server/is_healthy.sh /usr/local/bin
COPY ./server/is_running.sh /usr/local/bin
COPY ./docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh", "standalone"]

# Expose Infinispan server  ports 
EXPOSE 7600 8080 8181 8888 9990 11211 11222 57600
