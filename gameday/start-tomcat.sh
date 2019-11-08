HOST=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
ROOT=$(cd ~/nrworkshop; pwd)

# NOTE: Must start this after
#  - Redis (wait at least 15 seconds after first launching redis)
#  - MSSQL (wait at least 30 seconds after first launching mssql)

# Tomcat Java app, use newrelic.env for license keys
docker run -d --rm --name gameday.tomcat --env-file $ROOT/lab2/newrelic.env -p $HOST:8080:8080 --link gameday.redis:redis \
  --link gameday.mssql:mssql -v $ROOT/lab2/target/lab2.war:/usr/local/tomcat/webapps/lab2.war --log-driver=fluentd tomcat-lab2
