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

## How to testing

1. Run all containers

```
docker-compose up --build
```

2. Sign on to Security admin console

http://localhost/auth/admin/

* Username: `admin`
* Password: `admin`

3. Dispose Keycloak and Infinispan containers

```
docker container stop kc-node1 kc-node2 ispn-node1 ispn-node2
docker container rm kc-node1 kc-node2 ispn-node1 ispn-node2
```

4. Rerun Keycloak and Infinispan containers

```
docker-compose up ispn-node1 ispn-node2 kc-node1 kc-node2
```

5. Transition to any pages

If all goes well, you should be able to make page transitions 
without being asked to sign-on again and with the authentication session keeped.

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
