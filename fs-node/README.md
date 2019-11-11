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

The `@list` command returns a list of available poems

 - GET http://localhost:8081/@list

```json
[
    {
        "filename": "AimWasSong-Frost-113.txt",
        "title": "AimWasSong",
        "poet": "Frost",
        "words": "113"
    },
    {
        "filename": "CagedBird-Angelou-193.txt",
        "title": "CagedBird",
        "poet": "Angelou",
        "words": "193"
    },
    {
        "filename": "Daffodils-Wordsworth-155.txt",
        "title": "Daffodils",
        "poet": "Wordsworth",
        "words": "155"
    },
    {
        "filename": "GreatWagon-Rumi-365.txt",
        "title": "GreatWagon",
        "poet": "Rumi",
        "words": "365"
    },
    {
        "filename": "Sonnet18-Shakespeare-114.txt",
        "title": "Sonnet18",
        "poet": "Shakespeare",
        "words": "114"
    },
    {
        "filename": "Tiger-Blake-143.txt",
        "title": "Tiger",
        "poet": "Blake",
        "words": "143"
    }
]
```
The **words**  field provided for each poem can be used to verify the number returned by the next endpoint.

The `@process` command is used to post a poem to the Lab2 Tomcat server

 - POST http://localhost:8081/AimWasSong-Frost-113.txt@process

```json
{
    "status": "Success",
    "words": "113"
}
```
