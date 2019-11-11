package com.newrelic.servlet;
 
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

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
@WebServlet("/image")
public class ImageServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LogManager.getLogger(ImageServlet.class);
 
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        File file = null;
        int filelength = 0;

        // Get filename
        String filename = request.getParameter("file");
        if (filename != null && filename.length() > 0) {
            file = new File("/usr/share/images/" + filename);
            filelength = (int)file.length();
        }

        if (filelength > 0) {
            // Respond with image
            response.setContentType("image/jpeg");
            response.setContentLength(filelength);
    		logger.info("Image: " + filename + " (" + filelength + " bytes)");
    
            // Copy the contents of the file to the output stream
            FileInputStream in = new FileInputStream(file);
            OutputStream out = response.getOutputStream();
            byte[] buf = new byte[1024];
            int count = 0;
            while ((count = in.read(buf)) >= 0) {
                out.write(buf, 0, count);
            }
            in.close();
            out.close();
        } else {
            // Respond with not found
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
