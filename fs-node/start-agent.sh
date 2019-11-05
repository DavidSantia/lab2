#!/bin/sh

if ! [ -z $NEW_RELIC_LOG_LEVEL ]; then
   sed -i -e "/log_level:/s+info+$NEW_RELIC_LOG_LEVEL+" \
       /src/newrelic.js
fi

if ! [ -z $FS_APP_NAME ]; then
   sed -i -e "/app_name:/s+FS Application+$FS_APP_NAME+" \
       /src/newrelic.js
fi

if ! [ -z $NEW_RELIC_LICENSE_KEY ]; then
   sed -i -e "/license_key:/s+license key here+$NEW_RELIC_LICENSE_KEY+" \
       /src/newrelic.js

   echo "Enabling newrelic node.js agent $PLUGIN_VERSION"
fi

exec node /src/index.js
