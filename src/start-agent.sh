#!/bin/sh


if ! [ -z $NEW_RELIC_LOG_LEVEL ]; then
   sed -i -e "/log_level:/s+info+$NEW_RELIC_LOG_LEVEL+" /usr/local/tomcat/newrelic/newrelic.yml
fi

if ! [ -z $TC_APP_NAME ]; then
   sed -i -e "/app_name:/s+My Application+$TC_APP_NAME+" /usr/local/tomcat/newrelic/newrelic.yml
fi

if ! [ -z $NEW_RELIC_LICENSE_KEY ]; then
   sed -i -e "/license_key:/s+YOUR_LICENSE_KEY_HERE+$NEW_RELIC_LICENSE_KEY+" /usr/local/tomcat/newrelic/newrelic.yml
   echo "Enabling newrelic node.js agent $PLUGIN_VERSION"
fi

exec /usr/local/tomcat/bin/catalina.sh run
