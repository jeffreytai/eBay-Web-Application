<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.ucla.cs.cs144.ItemBean, java.lang.Object" %>

<html>
<% ItemBean item = (ItemBean) request.getAttribute("item");
String itemID = item.id;
String name = item.name;
String buyPrice = item.buyPrice;
String url = "https://" + request.getServerName() + ":8443" + request.getContextPath() + "/confirm";
%>
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
					<h2>Credit Card Information</h2>
				</header>
				<p>
					Item ID: <%= itemID %><br />
					Item Name: <%= name %><br />
					Buy Price: <%= buyPrice %><br />
					<form method="POST" action="<%= url %>">
						<input type="hidden" value="<%= itemID %>" name="id" /><br /> 
						Credit Card Number:<input type="text" name="ccn" placeholder="XXXX-XXXX-XXXX-XXXX" /><br>
						<input type="submit" value="Confirm">
					</form>
				</p>
			</div>
		</div>
	</section>

</body>

</html>