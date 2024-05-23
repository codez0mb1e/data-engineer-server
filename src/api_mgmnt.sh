
docker network create frontend

export PRIMARY_DOMAIN=0xcode.in
export SSL_EMAIL=secure@0xcode.in

docker compose --remove-orphans

curl -s 127.0.0.1:8080/api/rawdata | jq .
curl http://172.19.0.2:80/

docker compose down --remove-orphans


# References

1. https://doc.traefik.io/traefik/user-guides/docker-compose/basic-example/
2. https://doc.traefik.io/traefik/user-guides/docker-compose/acme-tls/