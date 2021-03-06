ROOT=$(cd ~/nrworkshop; pwd)

docker pull redis

# Build lab2.war file
docker run --rm --name mvn-build -v $ROOT/lab2:/lab2 --entrypoint sh davidsantia/tomcat-mvn \
  -c "cd /lab2; mvn clean; mkdir -p target/lab2/WEB-INF/lib; cp mssql/mssql-jdbc-7.4.1.jre8.jar target/lab2/WEB-INF/lib/; mvn package"

# Build tomcat image with Java apm
cd ~/nrworkshop/lab2
if [ ! -z `docker images -q tomcat-lab2` ]; then
  docker rmi tomcat-lab2
fi
docker build -t tomcat-lab2 .

# Build Node.js app
cd fs-node
docker build -f Dockerfile_v0.5 -t fs-node:v0.5 .
docker build -f Dockerfile_v1.0 -t fs-node:v1.0 .

# Build fluentd image with NR Logs plugin
cd ../fluentd
if [ ! -z `docker images -q fluentd-lab2` ]; then
  docker rmi fluentd-lab2
fi
docker build -t fluentd-lab2 .

# Build MSSQL with T-SQL script to make schema
cd ../mssql
if [ ! -z `docker images -q mssql` ]; then
  docker rmi mssql
fi
docker build -t mssql .
