#!/bin/bash

## Replace from ${{property.name}} to Environment variable
CONFIG_PATH=/opt/keycloak/conf/cache-ispn.xml

sed -i -e "s/\\\${{infinispan\\.client\\.hotrod\\.host}}/$(echo "$INFINISPAN_CLIENT_HOTROD_HOST" | sed -e 's/\//\\\//g')/g" $CONFIG_PATH
sed -i -e "s/\\\${{infinispan\\.client\\.hotrod\\.port}}/$(echo "$INFINISPAN_CLIENT_HOTROD_PORT" | sed -e 's/\//\\\//g')/g" $CONFIG_PATH

sed -i -e "s/\\\${{infinispan\\.client\\.hotrod\\.auth_realm}}/$(echo "$INFINISPAN_CLIENT_HOTROD_AUTH_REALM" | sed -e 's/\//\\\//g')/g" $CONFIG_PATH
sed -i -e "s/\\\${{infinispan\\.client\\.hotrod\\.auth_username}}/$(echo "$INFINISPAN_CLIENT_HOTROD_AUTH_USERNAME" | sed -e 's/\//\\\//g')/g" $CONFIG_PATH
sed -i -e "s/\\\${{infinispan\\.client\\.hotrod\\.auth_password}}/$(echo "$INFINISPAN_CLIENT_HOTROD_AUTH_PASSWORD" | sed -e 's/\//\\\//g')/g" $CONFIG_PATH

/opt/keycloak/bin/kc.sh "$@"
