<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.ucla.cs.cs144.ItemBean, java.lang.Object, java.text.SimpleDateFormat, java.util.Date" %>

<html>
<% ItemBean item = (ItemBean) request.getAttribute("item");
String itemID = item.id;
String name = item.name;
String buyPrice = item.buyPrice;
String ccn = (String) request.getAttribute("ccn");
String time = request.getAttribute("time").toString();
String oldformat = "EEE MMM dd HH:mm:ss z yyyy";
String newformat = "yyyy/MM/dd HH:mm:ss";
String newDate;
SimpleDateFormat sdf = new SimpleDateFormat(oldformat);
Date d = sdf.parse(time);
sdf.applyPattern(newformat);
newDate = sdf.format(d);
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
					<h2>Credit Card Confirmation</h2>
				</header>
				<p>
					Item ID: <%= itemID %><br />
					Item Name: <%= name %><br />
					Buy Price: <%= buyPrice %><br />
					Credit Card Number: <%= ccn %><br />
					Time: <%= newDate %>
				</p>
			</div>
		</div>
	</section>


</body>

</html>