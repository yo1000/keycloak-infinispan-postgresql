#!/bin/bash

## Replace from ${{property.name}} to Environment variable
sed -i -e "s/\\\${{infinispan\\.datasource\\.url}}/$(echo "$INFINISPAN_DATASOURCE_URL" | sed -e 's/\//\\\//g')/g" /opt/infinispan/server/conf/infinispan.xml
sed -i -e "s/\\\${{infinispan\\.datasource\\.username}}/$(echo "$INFINISPAN_DATASOURCE_USERNAME" | sed -e 's/\//\\\//g')/g" /opt/infinispan/server/conf/infinispan.xml
sed -i -e "s/\\\${{infinispan\\.datasource\\.password}}/$(echo "$INFINISPAN_DATASOURCE_PASSWORD" | sed -e 's/\//\\\//g')/g" /opt/infinispan/server/conf/infinispan.xml

/opt/infinispan/bin/launch.sh "$@"
