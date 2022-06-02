FROM jboss/infinispan-server:9.4.11.Final

USER root
COPY ./conf/standalone.xml $INFINISPAN_SERVER_HOME/standalone/configuration/
COPY ./docker-entrypoint.sh /usr/local/bin

COPY ./lib/* $HOME
RUN $INFINISPAN_SERVER_HOME/bin/ispn-cli.sh --command="module add \
    --name=org.postgresql \
    --resources=postgresql-42.2.19.jar \
    --dependencies=javax.api,javax.transaction.api"

USER 1000
ENTRYPOINT ["docker-entrypoint.sh", "standalone"]

# Expose Infinispan server  ports
EXPOSE 7600 8080 8181 8888 9990 11211 11222 57600
