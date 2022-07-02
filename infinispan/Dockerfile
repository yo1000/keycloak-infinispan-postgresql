FROM infinispan/server:13.0.10.Final-2

USER root
COPY ./lib/* /opt/infinispan/server/lib/
COPY ./conf/infinispan.xml /opt/infinispan/server/conf/infinispan.xml
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

USER 1000
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
