mkdir -pv ~/.docker
cp /etc/docker/certs.d/{ca,cert,key}.pem ~/.docker
export DOCKER_HOST=tcp://vw1amaline2-dev.prod.fdic.gov:2376 DOCKER_TLS_VERIFY=1
