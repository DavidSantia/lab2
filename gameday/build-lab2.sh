ROOT=$(cd ~/nrworkshop; pwd)

# Build lab2.war file
docker run --rm --name mvn-build -v $ROOT/lab2:/lab2 --entrypoint sh davidsantia/tomcat-mvn \
  -c "cd /lab2; mvn clean; mkdir -p target/lab2/WEB-INF/lib; cp mssql/mssql-jdbc-7.4.1.jre8.jar target/lab2/WEB-INF/lib/; mvn package"
