# Keycloak Infinispan Postgresql

Persisting cache via remote Infinispan,
Keycloak can be HA configured without using JGroup.

## Requirements

* Docker

```
docker --version
Docker version 20.10.12, build e91ed57
```

## How to run

```
docker compose up --build
```

## How to testing

1. Run all containers

```
docker compose up --build
```

2. Sign on to Security admin console

http://localhost/admin/

* Username: `admin`
* Password: `admin`

3. Dispose Keycloak and Infinispan containers

```
docker container stop kc-node1 kc-node2 ispn-node1 ispn-node2
docker container rm kc-node1 kc-node2 ispn-node1 ispn-node2
```

4. Rerun Keycloak and Infinispan containers

```
docker compose up ispn-node1 ispn-node2 kc-node1 kc-node2
```

5. Transition to any pages

If all goes well, you should be able to make page transitions 
without being asked to sign-on again and with the authentication session keeped.

## Configuration Overview

Components

- Load Balancer (Apache HTTP Server 2.4)
- Auth Server (Keycloak 18.0.2)
- Cache Server (Infinispan 13.0.10.Final-2)
- Database (Postgresql 12.4)
- DNS (Docker Network)

```
Client _____ LB _____ KC1 _____ DNS _____ ISPN1 _____ Postgres
                  \__ KC2 __/         \__ ISPN2 __/
```

For example, the following combination would be used if built on AWS.

```
Client _____ ALB _____ KC1 _____ NLB _____ ISPN1 _____ RDS Aurora PostgreSQL
                   \__ KC2 __/         \__ ISPN2 __/
```

## Configuration Hint

Realms cache is configured to remain only in the local cache of each node, as linking the Realms cache with the remote store would be very performance degrading. This means that if the realm settings are changed, a node restart is required for the settings to be reflected on each node. However, in the configuration of this code base, Keycloak does not depend on JGroup, and restarting a node at any time does not destroy the session or other caches, so it can be safely restarted.
