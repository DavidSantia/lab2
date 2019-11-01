package com.newrelic.servlet;

import com.lambdaworks.redis.*;

/**
 * @author davidmorris
 */
public class RedisConnect {
    private RedisConnection<String, String> connection;
    private RedisClient client;

    public RedisConnect (String host) {
        // create connection
        try {
            this.client = new RedisClient(RedisURI.create("redis://" + host + ":6379"));
            this.connection = client.connect();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        System.out.println("Connected to Redis");
    }

    public RedisConnection<String, String> conn() {
        return this.connection;
    }

    public void close() {
        try {
            this.connection.close();
            this.client.shutdown();
        } catch (RedisException e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
    }
}
