set -e
CADDY_VERSION=$(wget -q https://registry.hub.docker.com/v1/repositories/caddy/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}' | sed -n -e 's/^\([0-9]\+\.[0-9]\+\.[0-9]\+\)-alpine$/\1/p' | sort -g | tail -n 1)

echo "Using caddy version tag $CADDY_VERSION"

docker build --build-arg CADDY_VERSION=$CADDY_VERSION -t birkenstab/custom-caddy:$CADDY_VERSION-alpine .

docker tag birkenstab/custom-caddy:$CADDY_VERSION-alpine birkenstab/custom-caddy:latest

docker push birkenstab/custom-caddy:$CADDY_VERSION-alpine
docker push birkenstab/custom-caddy:latest
