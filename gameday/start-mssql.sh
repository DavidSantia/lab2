# MSSQL for Java app
docker run -d --rm --name mssql -p 1433:1433 --log-driver=fluentd --log-opt tag="nrlogs" mssql
