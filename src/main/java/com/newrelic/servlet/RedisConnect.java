package com.newrelic.servlet;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

/**
 * @author davidmorris
 */
public class RedisConnect {
	private JedisPool pool;

	public RedisConnect(String host) {
		// create connection
		try {
			this.pool = new JedisPool(new JedisPoolConfig(), host);
		} catch (Exception e) {
			System.err.println(e.getClass().getName() + ": " + e.getMessage());
			System.exit(0);
		}
		System.out.println("Connected to Redis");
	}

	public Jedis getResource() {
		return this.pool.getResource();
	}

	public void close() {
		try {
			this.pool.close();
		} catch (Exception e) {
			System.err.println(e.getClass().getName() + ": " + e.getMessage());
			System.exit(0);
		}
	}
}
