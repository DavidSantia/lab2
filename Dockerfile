FROM davidsantia/tomcat-mvn:latest

ENV NEW_RELIC_INSIGHTS_INSERT_KEY=""
ENV PLUGIN_VERSION=5.7.0

ENV JAVA_OPTS="-javaagent:/usr/local/tomcat/newrelic/newrelic-agent-${PLUGIN_VERSION}.jar"

# Configure logs-in-context
ENV LOG4J_MESSAGE_FACTORY=com.newrelic.logging.log4j2.NewRelicMessageFactory

# Configure Maven
ADD settings.xml /usr/share/maven/conf/settings.xml

# Install New Relic agent
ADD http://apt.newrelic.com/newrelic/java-agent/newrelic-agent/${PLUGIN_VERSION}/newrelic-agent-${PLUGIN_VERSION}.jar /usr/local/tomcat/newrelic/
ADD newrelic.yml /usr/local/tomcat/newrelic/
RUN sed -i -e "/^tomcat.util.scan.StandardJarScanFilter.jarsToSkip/a\lab2.war,\\" -e "/^tomcat.util.scan.StandardJarScanFilter.jarsToSkip/a\newrelic-agent-${PLUGIN_VERSION}.jar,\\" /usr/local/tomcat/conf/catalina.properties

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
