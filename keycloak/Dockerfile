FROM ubuntu:20.04
USER root

RUN apt-get -y update; \
    apt-get -y install \
        tzdata; \
    apt-get -y install \
        openjdk-17-jdk \
        bind9-utils \
        iproute2 \
        iputils-ping \
        lua5.3 luarocks \
        lsof \
        less \
        curl \
        zip \
        jq

WORKDIR /opt

ENV KC_FILENAME keycloak-9.0.3

COPY ./server/${KC_FILENAME}.zip.* /opt/
RUN cat /opt/${KC_FILENAME}.zip.* > /opt/${KC_FILENAME}.zip; \
    unzip -q /opt/${KC_FILENAME}.zip; \
    mv ${KC_FILENAME} keycloak

ENV KC_HOME=/opt/keycloak
ENV PATH=${KC_HOME}/bin:${PATH}

WORKDIR $KC_HOME

COPY ./lib/* $KC_HOME
RUN jboss-cli.sh --command="module add \
    --name=org.postgresql \
    --resources=postgresql-42.2.19.jar \
    --dependencies=javax.api,javax.transaction.api"

COPY ./conf/standalone.xml ${KC_HOME}/standalone/configuration/
COPY ./conf/standalone.conf ${KC_HOME}/bin/
COPY ./docker-entrypoint.sh /opt/
RUN chmod +x /opt/docker-entrypoint.sh

ENTRYPOINT ["/opt/docker-entrypoint.sh"]
