FROM jboss/keycloak:9.0.3

USER root
COPY ./conf/standalone.xml ${JBOSS_HOME}/standalone/configuration/
COPY ./conf/standalone.conf ${JBOSS_HOME}/bin/
COPY ./docker-entrypoint.sh /opt/jboss/tools/docker-entrypoint.sh
RUN chmod +x /opt/jboss/tools/docker-entrypoint.sh

ENV PATH=${JBOSS_HOME}/bin:${PATH}
COPY ./lib/* $JBOSS_HOME
RUN jboss-cli.sh --command="module add \
    --name=org.postgresql \
    --resources=${JBOSS_HOME}/postgresql-42.2.19.jar \
    --dependencies=javax.api,javax.transaction.api"

USER 1000
ENTRYPOINT ["/opt/jboss/tools/docker-entrypoint.sh"]
