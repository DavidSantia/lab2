HOST=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
ROOT=$(cd ~/nrworkshop; pwd)

# Fluentd for NR Logs, license key on image
docker run -d --rm --name fluentd -p 24224:24224 fluentd-lab2

# MSSQL for Java app
docker run -d --rm --name mssql --log-driver=fluentd --log-opt tag="nrlogs" mssql
echo "Pausing for MSSQL to boot up"
sleep 30

# Redis for Java app
docker run -d --rm --name redis --log-driver=fluentd --log-opt tag="nrlogs" redis
echo "Pausing for Redis to boot up"
sleep 30

# Tomcat Java app, use newrelic.env for license keys
docker run -d --rm --name tomcat --env-file $ROOT/lab2/newrelic.env -p $HOST:8080:8080 --link redis:redis \
  --link mssql:mssql -v $ROOT/lab2/target/lab2.war:/usr/local/tomcat/webapps/lab2.war --log-driver=fluentd --log-opt tag="nrlogs" tomcat-lab2

# Node.js app, use newrelic.env for license key
docker run -d --rm --name fs-node --env-file $ROOT/lab2/newrelic.env -p $HOST:8081:8080 \
  --link tomcat:tomcat --log-driver=fluentd --log-opt tag="nrlogs" davidsantia/fs-node
