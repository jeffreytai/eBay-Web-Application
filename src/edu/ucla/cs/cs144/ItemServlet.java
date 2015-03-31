package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import java.io.StringReader;
import javax.xml.bind.*;
import java.util.HashMap;
import javax.servlet.http.HttpSession;

import java.io.ByteArrayInputStream;
import java.io.InputStream;


public class ItemServlet extends HttpServlet implements Servlet {
       
    public ItemServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	String itemID;

    	if (request.getParameter("itemID") == null)
    		response.sendRedirect("getItem.html");
    	else {
    		itemID = request.getParameter("itemID").trim();
    		if (itemID.length() == 0)
    			response.sendRedirect("getItem.html");
    		else {
    			String xmlInfo = AuctionSearchClient.getXMLDataForItemId(itemID);
                HttpSession session = request.getSession(true);
                HashMap<String, ItemBean> map = null;

                request.setAttribute("xmlInfo", xmlInfo);
    			
                ItemBean item = null;
                if (xmlInfo == "") {
                    request.setAttribute("item", item);
                    request.getRequestDispatcher("/item.jsp").forward(request, response);
                } else {
        			try {
    	    			JAXBContext jc = JAXBContext.newInstance(ItemBean.class);
    		    		Unmarshaller unmarshaller = jc.createUnmarshaller();
    		    		InputStream input = new ByteArrayInputStream(xmlInfo.getBytes("UTF-8"));
    		    		item = (ItemBean) unmarshaller.unmarshal(input);
    	    		} catch (Exception ex) {
    	    			ex.printStackTrace();
    	    		}

    	    		if (item == null) {
    	    			request.getRequestDispatcher("/item.jsp").forward(request, response);
    	    		} else {
                        if (session.isNew()) {
                            map = new HashMap<String, ItemBean>();
                        } else {
                            map = (HashMap<String, ItemBean>) session.getAttribute("map");
                        }

    	    			request.setAttribute("item", item);

                        map.put(itemID, item);
                        session.setAttribute("map", map);

    	    			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/item.jsp");
        				dispatcher.forward(request, response);
    	    		}
                }	
    		}
    	}
    }
}
