package com.newrelic.servlet;

import com.newrelic.servlet.RedisConnect;
import redis.clients.jedis.Jedis;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * @author davidmorris
 */
@WebServlet("/process")
public class ProcessServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger logger = LogManager
			.getLogger(ProcessServlet.class);

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		ServletContext ctx = request.getServletContext();

		// get form textarea
		request.setCharacterEncoding("UTF-8");
		String data = request.getParameter("data");

		// strip the punctuation
		String dataNoPunct = data.replaceAll("[’']", "").replaceAll(
				"[^A-Za-z0-9]", " ");

		// split into words
		String[] words = dataNoPunct.split(" +");

		PrintWriter writer = response.getWriter();
		RedisConnect redis = (RedisConnect) ctx.getAttribute("Redis");
		Jedis jedis;
		try {
			jedis = redis.getResource();
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			logger.error(e.getClass().getName() + ": " + e.getMessage());
			writer.println("<html>\n<h2>Processed 0 words</h2>\n</html>\n");
			return;
		}

		// store words in Redis
		for (int i = 0; i < words.length; i++) {
			// increments score by 1 for member in the sorted set stored at key
			// if key does not exist, score is set to 0 before performing
			// incrementing
			jedis.zincrby("words", 1, words[i].toLowerCase());
		}

		Double theDouble = jedis.zscore("words", "the");
		Integer theInt = 0;
		if (theDouble != null) {
			theInt = theDouble.intValue();
		}
		String the = theInt.toString();
		jedis.close();

		logger.info("firstWord: " + words[0]);
		logger.info("theWords: " + the);
		logger.info("processedWords: " + words.length);

		// return HTML response
		String htmlRespone = "<html>\n<h2>Processed " + words.length
				+ " words</h2>\n</html>\n";
		writer.println(htmlRespone);
	}
}
