FROM node:11-stretch

ENV PLUGIN_VERSION=6.0.0
ENV NEW_RELIC_LICENSE_KEY=""
ENV NEW_RELIC_LOG_LEVEL="info"
ENV FS_AGENT_NAME=""

RUN apt-get update \
    && apt-get install -y build-essential zip unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /src /log

ADD start-agent.sh /
ADD index.js /src
ADD newrelic.js /src
ADD package.json /src
ADD assets /src/assets
ADD views /src/views
ADD data /data

RUN cd /src && yarn install && yarn cache clean

EXPOSE 8080

WORKDIR /data
ENTRYPOINT ["/start-agent.sh"]
