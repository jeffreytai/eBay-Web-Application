<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.ucla.cs.cs144.SearchResult" %>

<%
	int numReturn = 10;
%>

<html>

<head>
	<title>eBay Search</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<script src="js/jquery.min.js"></script>
	<script src="js/jquery.scrollex.min.js"></script>
	<script src="js/jquery.scrolly.min.js"></script>
	<script src="js/skel.min.js"></script>
	<script src="js/init.js"></script>

	<script type="text/javascript" src="suggestions.js"></script>
	<link rel="stylesheet" type="text/css" href="suggestions.css" />
    <script type="text/javascript">
        window.onload = function () {
            var oTextbox = new AutoSuggestControl(document.getElementById("querybox"), new SuggestionProvider());
        }
    </script>

	<noscript>
		<link rel="stylesheet" href="css/skel.css" />
		<link rel="stylesheet" href="css/style.css" />
		<link rel="stylesheet" href="css/style-xlarge.css" />
	</noscript>
</head>

<body>
	<section id="one" class="main special">
		<div class="container">
			<span class="image fit primary"><img src="images/pic01.jpg" alt="" /></span>
			<div class="content">
				<header class="major">
					<h2>Keyword Search</h2>
					<h5>Go to: <a href="/eBay/item">Item ID Search</a></h5>
				</header>
				<p>
					<form action="/eBay/search">
						Query: <input type="text" name="q" id="querybox" /><br />

						<input type="hidden" name="numResultsToSkip" value="0" /><br />

						<input type="hidden" name="numResultsToReturn" value="10" />

						<input type="submit" />
					</form>
				</p>
			</div>
			<a href="#two" class="goto-next scrolly">Next</a>
		</div>
	</section>

	<section id="two" class="main">
		<div class="container">
			<div class="content">
				<header class="major">
					<h2>
						<%
						SearchResult[] sr = (SearchResult[]) request.getAttribute("searchResults");
						if (sr.length == 0 | sr == null) {
							out.println("No results for <b>'" + request.getParameter("q") + "'</b>");
						} else {
							int numSkip = Integer.parseInt(request.getParameter("numResultsToSkip"));
							int totalNum = Integer.parseInt(request.getAttribute("totalNum").toString());

							out.println((numSkip+1) + "-" + Math.min((numSkip+10),totalNum) + " results for <b>'" + request.getParameter("q") + "'</b>");
						}
						%>
					</h2>
				</header>

				<section>
					<div class="table-wrapper">
						<table>
							<thead>
								<tr>
									<th>Item ID</th>
									<th>Name</th>
								</tr>
							</thead>
							<tbody>
								<%
								for (SearchResult res : sr) {
									out.println("<tr>");
									out.println("<td><a href=item?itemID=" + res.getItemId() + ">" + res.getItemId() + "</a></td>");
									out.println("<td>" + res.getName() + "</td>");
									out.println("</tr>");
								}
								%>
							</tbody>
							<tfoot>
								<tr>
									<td>
										<%
										int numSkip = Integer.parseInt(request.getParameter("numResultsToSkip"));
										int totalNum = Integer.parseInt(request.getAttribute("totalNum").toString());

										out.println("<a id='prev' href=search?q=" + request.getParameter("q") + "&numResultsToSkip=" + Math.max((numSkip-10),0) + "&numResultsToReturn=" + numReturn + ">Previous</a>");

										if (numSkip + 10 > totalNum) {
											out.println("<a href=search?q=" + request.getParameter("q") + "&numResultsToSkip=" + numSkip + "&numResultsToReturn=" + numReturn + ">Next</a>");
										} else {
											out.println("<a href=search?q=" + request.getParameter("q") + "&numResultsToSkip=" + Math.min((numSkip+10),totalNum) + "&numResultsToReturn=" + numReturn + ">Next</a>");
										}
										%>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</section>

			</div>
		</div>
	</section>

	<!-- from here -->
</body>

</html>