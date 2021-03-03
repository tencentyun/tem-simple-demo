Demo for spring-cloud

## consul registry

Run consul locally
```
docker run --rm -p 8500:8500 -p 8600:8600/udp consul
```

```
# in consul-provider, default is heartbeat(TTL)
mvn spring-boot:run
# debug
mvn spring-boot:run -Dspring-boot.run.arguments=--logging.level.root=DEBUG
# disable heartbeat to use /actuator/health
# https://docs.spring.io/spring-cloud-consul/docs/2.2.4.RELEASE/reference/html/appendix.html
mvn spring-boot:run -Dspring-boot.run.arguments=--spring.cloud.consul.discovery.heartbeat.enabled=false

curl localhost:8002/ping
curl localhost:8002/actuator/health
```

## consul discovery

> RestTemplate & spring-cloud-loadbalancer(not ribbon) are used

Run consul locally

```
# in consul-provider (:8002)
mvn spring-boot:run

# in consul-consumer (:8001)
mvn spring-boot:run

curl localhost:8001/ping-provider
```

## Eureka registry

```
# in eureka-server
mvn spring-boot:run
# debug to see requests
mvn spring-boot:run -Dspring-boot.run.arguments=--logging.level.root=DEBUG
```

```
# in eureka-provider
mvn spring-boot:run
# use healthcheck
mvn spring-boot:run -Dspring-boot.run.arguments=--eureka.client.healthcheck.enabled=true
```

## Eureka discovery

> Feign & Ribbon are used

```
# in eureka-server
mvn spring-boot:run
```

```
# in eureka-provider (:8004)
mvn spring-boot:run
```

```
# in eureka-consumer (:8003)
mvn spring-boot:run
```

Call `localhost:8003/ping-provider`
# tem-simple-demo
