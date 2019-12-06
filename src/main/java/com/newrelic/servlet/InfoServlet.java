package com.newrelic.servlet;

import com.lambdaworks.redis.RedisConnection;
import com.newrelic.servlet.RedisConnect;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.HashMap;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * @author davidmorris
 */
@WebServlet("/info")
public class InfoServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger logger = LogManager.getLogger(InfoServlet.class);

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ServletContext ctx = request.getServletContext();

		PrintWriter writer = response.getWriter();

		RedisConnect redis = (RedisConnect) ctx.getAttribute("Redis");
		RedisConnection<String, String> conn = null;
		try {
			conn = redis.conn();
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
			logger.error(e.getClass().getName() + ": " + e.getMessage());
			writer.println("<html>\n<h2>" + e.getMessage() + "</h2>\n</html>\n");
			return;
		}

		// get Redis stats
		String info = conn.info();

		// return HTML response
		String htmlRespone = "<html>\n";
		htmlRespone += "<p>" + info.replaceAll("\n", "<br />") + "</p>\n";
		htmlRespone += "</html>\n";
		writer.println(htmlRespone);

		// spit into key value pairs
		String[] KeyValues = info.replaceAll("\r", "").split("\n");
		Map<String, String> stats = new HashMap<String, String>();
		for (int i = 0; i < KeyValues.length; i++) {
			String[] keyVal = KeyValues[i].split(":");
			if (keyVal.length == 1 || keyVal[0].length() == 0 || keyVal[0].charAt(0) == '#') {
				continue;
			}
			stats.put(keyVal[0], keyVal[1]);
		}
		logger.info("Found " + stats.size() + " keys");
	}
}
