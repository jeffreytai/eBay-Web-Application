package edu.ucla.cs.cs144;

import java.io.IOException;
import java.net.HttpURLConnection;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

public class ProxyServlet extends HttpServlet implements Servlet {
       
    public ProxyServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/xml");
        String searchQuery = request.getParameter("q");
        URL url = new URL("http://google.com/complete/search?output=toolbar&q=" + searchQuery);
        PrintWriter out = response.getWriter();
        HttpURLConnection huc = (HttpURLConnection) url.openConnection();

        BufferedReader br = new BufferedReader(new InputStreamReader(huc.getInputStream()));
        String line;
        while ( (line = br.readLine()) != null) {
        	out.println(line);
        }

        br.close();
        out.close();
    }
}
