# Keycloak Infinispan Postgresql

By persisting cache via remote Infinispan,
Keycloak can be HA configured without using JGroup.

## Requirements

* Docker
* Docker Compose

```
docker --version
Docker version 20.10.12, build e91ed57

docker-compose --version
docker-compose version 1.29.2, build 5becea4c
```

## How to run

```
docker-compose up --build
```

## Configuration Overview

Components

- Load Balancer (Apache HTTP Server 2.4)
- Auth Server (Keycloak 9.0.3)
- Cache Server (Infinispan 9.2.24.Final)
- Database (Postgresql 12.4)
- DNS (Docker Network)

```
Client _____ LB _____ KC1 _____ DNS _____ ISPN1 _____ Postgres
                  \__ KC2 __/         \__ ISPN2 __/
```
