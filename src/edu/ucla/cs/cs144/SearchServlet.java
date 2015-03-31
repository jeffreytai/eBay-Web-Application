package edu.ucla.cs.cs144;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SearchServlet extends HttpServlet implements Servlet {
       
    public SearchServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	int numResultsToSkip = 0;
    	int numResultsToReturn = 10;
    	String query;
    	
    	if (request.getParameter("q") == null)
    		response.sendRedirect("keywordSearch.html");
    	else {
    		query = request.getParameter("q").trim();
    		if (query.length() == 0)
    			response.sendRedirect("keywordSearch.html");
    		else {
    			try {
        			numResultsToSkip = Integer.parseInt(request.getParameter("numResultsToSkip"));
        			if (numResultsToSkip < 0) numResultsToSkip = 0;
        		} catch (NumberFormatException e) {
        			numResultsToSkip = 0;
        		}
        		
        		try {	
        			numResultsToReturn = Integer.parseInt(request.getParameter("numResultsToReturn"));
        			if (numResultsToReturn < 0) numResultsToReturn = 0;
        		} catch (NumberFormatException e) {
        			numResultsToReturn = 0;
        		}
        		
        		SearchResult[] results = AuctionSearchClient.basicSearch( query, numResultsToSkip, numResultsToReturn );
        		SearchResult[] totalResults = AuctionSearchClient.basicSearch( query, 0, Integer.MAX_VALUE);
        		int totalNum = totalResults.length;
        		
        		request.setAttribute("searchResults", results);
        		request.setAttribute("totalNum", totalNum);
        		request.getRequestDispatcher("/showSearchResults.jsp").forward(request, response);
    		}
    	}
    }
}
