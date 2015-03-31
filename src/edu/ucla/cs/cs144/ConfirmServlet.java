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
import java.util.Date;
import java.lang.StringBuilder;

public class ConfirmServlet extends HttpServlet implements Servlet {

	public ConfirmServlet() {}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (!request.isSecure()) {
			response.sendRedirect("eBay/keywordSearch.html");
		}

		HttpSession session = request.getSession(false);
		if (session == null) {
			response.sendRedirect("/eBay/keywordSearch.html");
		}

		String ccn = request.getParameter("ccn");
		String itemID = request.getParameter("id");

		Map<String, ItemBean> itemMap = (HashMap<String, ItemBean>) session.getAttribute("map");
		if (itemMap == null) {
			response.sendRedirect("/eBay/keywordSearch.html");
		}

		ItemBean item = null;
		if (!itemMap.containsKey(itemID)) {
			response.sendRedirect("/eBay/keywordSearch.html");
		} else {
			item = (ItemBean) itemMap.get(itemID);
			request.setAttribute("item", item);
			request.setAttribute("ccn", hideCCN(ccn));
			request.setAttribute("time", new Date());
			request.getRequestDispatcher("/confirm.jsp").forward(request, response);
		}
	}

	private String hideCCN(String ccn) {
		if (ccn.length() < 4) {
			return ccn;
		} else {
			StringBuilder hidden = new StringBuilder(ccn);
			for (int i=0; i<ccn.length()-4; i++) {
				hidden.setCharAt(i, 'x');
			}
			return hidden.toString();
		}
	}
}