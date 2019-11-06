package com.newrelic.servlet;

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
@WebServlet("/memory_error")
public class ErrorServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger logger = LogManager.getLogger(ErrorServlet.class);

	// Game day scenario - Java heap out of memory
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int iteratorValue = 20;
		for (int outerIterator = 1; outerIterator < 20; outerIterator++) {
			logger.info("FillMemory iteration #" + outerIterator + ", " + Runtime.getRuntime().freeMemory()
					+ " bytes free");
			int loop1 = 2;
			int[] memoryFillIntVar = new int[iteratorValue];
			do {
				memoryFillIntVar[loop1] = 0;
				loop1--;
			} while (loop1 > 0);
			iteratorValue = iteratorValue * 5;
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				logger.warn("Thread is interrupted - " + e);
			}
		}

		// return HTML response
		PrintWriter writer = response.getWriter();
		writer.println("<html>\n<h1>Using up lots of memory</h1>\n</html>");

	}

}
