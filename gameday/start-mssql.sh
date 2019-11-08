# MSSQL for Java app
docker run -d --rm --name gameday.mssql --log-driver=fluentd --log-opt tag="docker.{{.Name}}" mssql
