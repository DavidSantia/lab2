HOST=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
ROOT=$(cd ~/nrworkshop; pwd)

# NOTE: Must start this after Tomcat

# Node.js app, use newrelic.env for license key
docker run -d --rm --name gameday.fs-node --env-file $ROOT/lab2/newrelic.env -p $HOST:8081:8080 \
  --link gameday.tomcat:tomcat --log-driver=fluentd davidsantia/fs-node
