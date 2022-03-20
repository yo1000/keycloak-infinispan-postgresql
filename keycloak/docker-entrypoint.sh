#!/bin/bash

# NOTES:
# Var prefix (from computed)  : KC_*, ISPN_*
# Var prefix (from manually)  : KEYCLOAK_*, INFINISPAN_*

# Add JBoss Admin user
add-user.sh \
    -u "${JBOSS_ADMIN_USERNAME:-'admin'}" \
    -p "${JBOSS_ADMIN_PASSWORD:-'admin'}"

# Add Keycloak Admin user
add-user-keycloak.sh -r master \
    -u "${KEYCLOAK_ADMIN_USERNAME:-'admin'}" \
    -p "${KEYCLOAK_ADMIN_PASSWORD:-'admin'}"

# Merge JAVA_OPTS
JAVA_OPTS="${JAVA_OPTS}"

# Required when use to JAX-WS
# -Djavax.xml.ws.spi.Provider=com.sun.xml.ws.spi.ProviderImpl \
standalone.sh \
    -c='standalone.xml' \
    -b='0.0.0.0' \
    -bmanagement='0.0.0.0' \
    -Dkeycloak.frontendUrl="${KEYCLOAK_FRONTEND_URL}" \
    -Dkeycloak.profile.feature.upload_scripts='enabled' \
    -Dinfinispan.remote.cache.host="${INFINISPAN_REMOTE_CACHE_HOST}" \
    -Dinfinispan.remote.cache.port=${INFINISPAN_REMOTE_CACHE_PORT:-11222} \
    -Dinfinispan.client.hotrod.auth_username="${INFINISPAN_CLIENT_HOTROD_AUTH_USERNAME}" \
    -Dinfinispan.client.hotrod.auth_password="${INFINISPAN_CLIENT_HOTROD_AUTH_PASSWORD}" \
    -Dinfinispan.client.hotrod.auth_server_name="${INFINISPAN_CLIENT_HOTROD_AUTH_SERVER_NAME:-${INFINISPAN_REMOTE_CACHE_HOST}}" \
    -Dinfinispan.client.hotrod.auth_realm="${INFINISPAN_CLIENT_HOTROD_AUTH_REALM:='ApplicationRealm'}" \
    -Dinfinispan.client.hotrod.sasl_mechanism="${INFINISPAN_CLIENT_HOTROD_SASL_MECHANISM:-'PLAIN'}"
