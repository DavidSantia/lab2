package com.newrelic.servlet;

import com.newrelic.servlet.RedisConnect;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * @author davidmorris
 */
public class StartStop implements ServletContextListener {

	public void contextInitialized(ServletContextEvent servletContextEvent) {
		ServletContext ctx = servletContextEvent.getServletContext();

		// Open connection to Redis
		RedisConnect redis = new RedisConnect("redis");
		ctx.setAttribute("Redis", redis);
	}

	public void contextDestroyed(ServletContextEvent servletContextEvent) {
		System.out.println("Lab1 Server exiting, closing Redis");
		ServletContext ctx = servletContextEvent.getServletContext();

		// Close connection to Redis
		RedisConnect redis = (RedisConnect) ctx.getAttribute("Redis");
		redis.close();
	}
}
