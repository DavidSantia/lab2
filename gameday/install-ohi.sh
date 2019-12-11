#
# Build MSSQL OHI
#

ROOT=$(cd ~/nrworkshop; pwd)

docker pull golang
docker run --rm -v $ROOT/lab2/nri-mssql:/go/src/github.com/newrelic/nri-mssql --entrypoint sh golang \
  -c "cd /go/src/github.com/newrelic/nri-mssql; make"
cd $ROOT/lab2/nri-mssql
sudo cp -r bin /var/db/newrelic-infra/newrelic-integrations/
sudo cp mssql-definition.yml /var/db/newrelic-infra/newrelic-integrations/
sudo cp mssql-config.yml.sample /etc/newrelic-infra/integrations.d/mssql-config.yml
sudo systemctl restart newrelic-infra
