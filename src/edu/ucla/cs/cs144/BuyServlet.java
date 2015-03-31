package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import java.util.Map;
import java.util.HashMap;
import javax.servlet.http.HttpSession;

public class BuyServlet extends HttpServlet implements Servlet {

	public BuyServlet() {}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String itemID;

		HttpSession session = request.getSession(false);

		itemID = request.getParameter("itemID");
		Map<String, ItemBean> itemMap = (HashMap<String, ItemBean>) session.getAttribute("map");
		if (session == null || itemMap == null) {
			response.sendRedirect("/eBay/keywordSearch.html");
			return;
		}

		if (itemMap.containsKey(itemID)) {
			ItemBean item = (ItemBean) itemMap.get(itemID);
			request.setAttribute("item", item);
			request.getRequestDispatcher("/buy.jsp").forward(request, response);
		} else {
			response.sendRedirect("/eBay/keywordSearch.html");
		}
	}
}