# lab2
Tomcat Java lab for New Relic instrumentation

Containerized with Docker, it can run on Mac, Windows or Linux

## Background

The lab serves a few purposes. First, it processes words posted on a form, which are tallied using Redis.
This provides a stand-alone application to generate some traffic to the Redis instance.
Next, it serves images to another lab. This illustrates how distributed tracing
can be used to track down an issue across multiple services.
Finally, it provides some error scenarios to exercise the monitoring system.

## Lab setup

* The New Relic Java APM agent is installed on the container to monitor the Tomcat server running our Java app
* The lab illustrates running micro-services with Docker, adding a Redis container to the system
* A variation is provided to use MSSQL instead of Redis, to illustrate using a database OHI
* The Java agent API is added to show how to record custom parameters
* The New Relic Telemetry SDK is added to show how to capture Redis health stats as Dimensional Metrics
* A Fluentd container forwards both the Redis and Tomcat logs to New Relic Logs
* The Java app uses log4j, which is configured for New Relic logs-in-context

## Error scenarios 

This lab provides various error scenarios, including:

* Distributed tracing across lab1 and this lab
* A slow page load due to a large image size served by this lab
* A JVM memory full error scenario
* A Tomcat server down scenario
* Inserting Javascript errors

