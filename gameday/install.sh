#
# Use this to install on Amazon Linux2 instance
# Select t2.small as MSSQL requires system with minimum 2GB memory
#

ROOT=$(cd ~/nrworkshop; pwd)
NEW_RELIC_LICENSE_KEY=`grep NEW_RELIC_LICENSE_KEY $ROOT/lab2/newrelic.env | sed 's+.*=++'`

sudo hostnamectl set-hostname gameday
sudo sed -i '/^127.0.0.1/s/$/ gameday/' /etc/hosts
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Install Infra agent
echo '## Installing Infra agent'
echo "license_key: $NEW_RELIC_LICENSE_KEY" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install -y newrelic-infra

# sudo systemctl stop newrelic-infra
# sudo systemctl start newrelic-infra
