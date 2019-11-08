# Redis for Java app
docker run -d --rm --name gameday.redis --log-driver=fluentd --log-opt tag="docker.{{.Name}}" redis
