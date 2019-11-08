HOST=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
ROOT=$(cd ~/nrworkshop; pwd)

# Fluentd for NR Logs, license key on image
docker run -d --rm --name gameday.fluentd -p 24224:24224 fluentd-lab2

# Redis for Java app
docker run -d --rm --name gameday.mssql --log-driver=fluentd mssql
echo "Pausing for MSSQL to boot up"
sleep 15

# MSSQL for Java app
docker run -d --rm --name redis --log-driver=fluentd redis
echo "Pausing for Redis to boot up"
sleep 15

# Tomcat Java app, use newrelic.env for license keys
docker run -d --rm --name gameday.tomcat --env-file $ROOT/lab2/newrelic.env --link redis --link mssql -p $HOST:8080:8080 \
  -v $ROOT/lab2/target/lab2.war:/usr/local/tomcat/webapps/lab2.war --log-driver=fluentd tomcat-lab2

# Node.js app, use newrelic.env for license key
docker run -d --rm --name gameday.fs-node --env-file $ROOT/lab2/newrelic.env --link tomcat -p $HOST:8081:8080 \
  --log-driver=fluentd davidsantia/fs-node
