<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.ucla.cs.cs144.ItemBean, java.lang.Object" %>

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

	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" /> 
	<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false">
	</script>


	<noscript>
		<link rel="stylesheet" href="css/skel.css" />
		<link rel="stylesheet" href="css/style.css" />
		<link rel="stylesheet" href="css/style-xlarge.css" />
	</noscript>
</head>

<%
ItemBean item = (ItemBean) request.getAttribute("item");
if (item != null) {%>
<body onload="initialize()">
	<%} else { %>
	<body> <% } %>
	<section id="one" class="main special">
		<div class="container">
			<span class="image fit primary"><img src="images/pic01.jpg" alt="" /></span>
			<div class="content">
				<header class="major">
					<h2>Item ID Search</h2>
					<h5>Go to: <a href="/eBay/search">Keyword Search</a></h5>
				</header>
				<p>
					<form action="/eBay/item">
						Item ID: <input type="text" name="itemID" /><br />
						<input type="submit" />
					</form>
				</p>
			</div>
			<a href="#two" class="goto-next scrolly">Next</a>
		</div>
	</section>

<!-- Two -->
	<section id="two" class="main special">
		<div class="container">
			<span class="image fit primary"><img src="images/pic02.jpg" alt="" /></span>
			<div class="content">
				<header class="major">
					<h2>
						<%
						out.println("Item Information");
						%>
					</h2>
				</header>
				<p>
					<%
					if (item == null) {
						out.println("There is no information about this item");
					} else {
						out.println("<b>ID</b>: " + item.id + "<br />");
						out.println("<b>Name</b>: " + item.name + "<br />");

						// Categories
						out.println("<b>Categories</b>:");
						for (String s : item.categories) {
							out.println(s + ", ");
						}
						out.println("<br />");

						out.println("<b>Listing Started</b>: " + item.started + "<br />");
						out.println("<b>Listing Ends</b>: " + item.ends + "<br />");

						out.println("<b>Current Price</b>: " + item.currently + "<br />");

						if (item.buyPrice != null) {
							out.println("<b>Buy-it-now Price</b>: " + item.buyPrice);
							out.println("<button><a href=\"/eBay/buy?itemID=" + item.id + "\">Pay Now!</a></button>");
						}
						out.println("<br />");

						out.println("<b>First Bid Price</b>: " + item.firstBid + "<br />");

						out.println("<b>Number of bids</b>: " + item.numberOfBids + "<br />");

						// Bids section
						if (Integer.parseInt(item.numberOfBids) != 0) {
							out.println("<b>Bids</b>:");
							out.println("<div class='table-wrapper'><table><thead><tr><th>Username</th><th>Rating</th><th>Time</th><th>Amount</th></tr></thead><tbody>");
									for (ItemBean.Bid b : item.bids.bid) {
										out.println("<tr><td>" + b.bidder.userID + "</td><td>" + b.bidder.rating + "</td><td>" + b.time + "</td><td>" + b.amount + "</td></tr>");
									}
									out.println("</tbody>");
						}
						out.println("</table></div>");

						out.println("<h4>Seller Information</h4>");
						// Location
						out.println("<b>Seller's Location</b>: " + item.loc.seller_location + ", " + item.seller_country + "<br />");

						out.println("<b>Seller ID</b>: " + item.seller.sellerID + "<br />");
						out.println("<b>Seller Rating</b>: " + item.seller.rating + "<br />");

						out.println("<b>Item Description</b>: " + item.description + "<br />");
					
					%>

					<script type="text/javascript">
						var geocoder; 
					  function initialize() { 
					  	geocoder = new google.maps.Geocoder();
					    var latlng = new google.maps.LatLng(0.0,0.0); 
					    var myOptions = { 
					      zoom: 14, // default is 8  
					      center: latlng, 
					      mapTypeId: google.maps.MapTypeId.ROADMAP 
					    }; 
					    var map = new google.maps.Map(document.getElementById("map_canvas"), 
					        myOptions);
				    	var address = "<%= item.loc.seller_location %>" + ", " + "<%= item.seller_country %>";
					    geocoder.geocode(
					    	{'address': address },
					    	function(results, status) {
					    		if (status == google.maps.GeocoderStatus.OK) {
					    			map.setCenter(results[0].geometry.location);
					    			map.fitBounds(results[0].geometry.viewport);
					    			var marker = new google.maps.Marker({
					    				map: map,
					    				position: results[0].geometry.location
					    			});
					    		} else {
					    			// shows the whole world if location doesn't exist
					    			var allowedBounds = new google.maps.LatLngBounds( new google.maps.LatLng(85, -180), new google.maps.LatLng(-85, 180) );
					    			var swt = allowedBounds.getSouthWest().lng();
									var nor = allowedBounds.getNorthEast().lat();
									var k = 5.0; 
									var n = allowedBounds.getNorthEast().lat() - k; 
									var e = allowedBounds.getNorthEast().lng() - k; 
									var s = allowedBounds.getSouthWest().lat() + k; 
									var w = allowedBounds.getSouthWest().lng() + k; 
									var neNew = new google.maps.LatLng( n, e ); 
									var swNew = new google.maps.LatLng( s, w ); 
									boundsNew = new google.maps.LatLngBounds( swNew, neNew); 
									map.fitBounds(boundsNew);
									map.setZoom(2);
					    		}
					    	});
					  } 

					</script>
					<% } %>
				</p>
			</div>
			<a href="#three" class="goto-next scrolly">Next</a>
		</div>
	</section>

<!-- Three -->
	<section id="three" class="main special">
		<div class="container">
			<span class="image fit primary"><img src="images/pic03.jpg" alt="" /></span>
			<div class="content">
				<header class="major">
					<h2>Location</h2>
				</header>
				<p>
					<div id="map_canvas" style="width:100%; height:90%"></div>
				</p>
			</div>
		</div>
	</section>

</body>

</html>