package com.newrelic.servlet;

import java.io.IOException;
import java.io.PrintWriter;

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

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Game day scenario - Java heap out of memory
		Runnable runnable = new Runnable() {
			public void run() {
				long memoryConsumed = 0;
				int dummyArraySize = 256;
				try {
					long[] memoryAllocated = null;
					for (int loop = 0; loop < 100; loop++) {
						memoryAllocated = new long[dummyArraySize];
						memoryAllocated[0] = 0;
						memoryConsumed += dummyArraySize * Long.SIZE;
						logger.info("Memory consumed: " + memoryConsumed / 1024 + "K");
						dummyArraySize *= 32;
						try {
							Thread.sleep(5000);
						} catch (InterruptedException ie) {
							logger.error("InterruptedException: " + ie.getMessage());
						}
					}
				} catch (OutOfMemoryError e) {
					System.out.println("Catching out of memory error");
					logger.error("OutOfMemoryError: " + e.getMessage());
					try {
						Thread.sleep(60000);
					} catch (InterruptedException ie) {
						logger.error("InterruptedException: " + ie.getMessage());
					}
				}
			}
		};

		// Start thread and use up memory
		Thread thread = new Thread(runnable);
		thread.start();
		
		PrintWriter writer = response.getWriter();
		String htmlRespone = "<html>\n<h1>Using up free memory on " + thread.getName() + "</h1>\n</html>\n";
		writer.println(htmlRespone);
	}
}
