# fs-node

A basic node.js file server, a copy of [github.com/ambrosechua/file-manager](https://github.com/ambrosechua/file-manager), with modifications to interact with lab2.

## Features

This code has been modified to add the following:

 - New Relic APM agent
   - See Dockerfile for agent installation
   - See `start-agent.sh` for configuring `newrelic.js` from ENV vars
   - See `views/layouts/main.handlebars` for inserting browser timing header
 - Extra commands `@list` and `@process`

## Build image
```sh
docker build -t fs-node .
```

## Usage

```sh
docker run --rm --name=fs-node -p 8081:8080 --link tomcat fs-node
```

## Special API commands
Two JSON endpoints have been a to interact with the Java app, creating both distributed traces, as
well as a test facility which can be leveraged in a Synthetic API monitor.

The `@list` command returns a list of available files

 - GET http://localhost:8081/@list

```json
[
    "AimWasSong-Frost.txt",
    "CagedBird-Angelou.txt",
    "Daffodils-Wordsworth.txt",
    "GreatWagon-Rumi.txt",
    "Sonnet18-Shakespeare.txt",
    "Tiger-Blake.txt"
]
```

The `@process` command is used to post a file to the Lab2 Tomcat server

 - POST http://localhost:8081/AimWasSong-Frost.txt@process

```json
{
    "status": "Success",
    "words": "113"
}
```
