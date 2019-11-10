# MSSQL for Java app
docker run -d --rm --name mssql -p 1443:1443 --log-driver=fluentd --log-opt tag="nrlogs" mssql
