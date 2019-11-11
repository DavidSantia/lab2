HOST=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
ROOT=$(cd ~/nrworkshop; pwd)
IMAGE="davidsantia/fs-node"

# Allow docker image to be specified
if [ "$#" == "1" ]; then
  IMAGE=$1
fi

# NOTE: Must start this after Tomcat

# Node.js app, use newrelic.env for license key
docker run -d --rm --name fs-node --env-file $ROOT/lab2/newrelic.env -p $HOST:8081:8080 \
  --link tomcat --log-driver=fluentd --log-opt tag="nrlogs" $IMAGE
