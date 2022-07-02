FROM quay.io/keycloak/keycloak:18.0.2

COPY ./conf/cache-ispn.xml /opt/keycloak/conf/cache-ispn.xml
COPY ./docker-entrypoint.sh /opt/keycloak/bin/docker-entrypoint.sh

WORKDIR /opt/keycloak
ENTRYPOINT ["/opt/keycloak/bin/docker-entrypoint.sh", "start", "--auto-build"]
