FROM fluent/fluentd

ENV FLUENTD_CONF=fluentd-nr.conf

#ENV http_proxy=http://proxy-host.net:8080

# Install New Relic plugin
RUN fluent-gem install fluent-plugin-newrelic

# Configure fluentd
ADD fluentd-nr.conf /fluentd/etc/
