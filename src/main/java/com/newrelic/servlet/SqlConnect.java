package com.newrelic.servlet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author davidmorris
 */
public class SqlConnect {
	private Connection connection;

	public SqlConnect(String host) {
		String connectionUrl = "jdbc:sqlserver://" + host + ":1433;databaseName=words;user=demo;password=Welcome:123";
		try {
			// connect to SQL server
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			this.connection = DriverManager.getConnection(connectionUrl);
		} catch (SQLException | ClassNotFoundException e) {
			System.err.println(e.getClass().getName() + ": " + e.getMessage());
			System.exit(0);
		}
		System.out.println("Connected to SQL server");
	}

	public Connection conn() {
		return this.connection;
	}

	public void close() {
		try {
			this.connection.close();
		} catch (SQLException e) {
			System.err.println(e.getClass().getName() + ": " + e.getMessage());
			System.exit(0);
		}
	}
}
