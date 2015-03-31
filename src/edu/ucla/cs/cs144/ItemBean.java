package edu.ucla.cs.cs144;

import javax.xml.bind.annotation.*;
import java.util.*;
import java.lang.Object;


@XmlRootElement(name = "Item")
public class ItemBean {
	@XmlAttribute(name = "ItemID")
	public String id;

	@XmlElement(name = "Name")
	public String name;

	@XmlElement(name = "Category")
	public List<String> categories = new ArrayList<String>();

	@XmlElement(name = "Currently")
	public String currently;

	@XmlElement(name = "First_Bid")
	public String firstBid;

	@XmlElement(name = "Buy_Price")
	public String buyPrice;

	@XmlElement(name = "Number_of_Bids")
	public String numberOfBids;

	@XmlElement(name = "Bids")
	public Bids bids;

	public static class Bids {
		@XmlElement(name = "Bid")
		public List<Bid> bid = new ArrayList<Bid>();
	}

	public static class Bid {
		@XmlElement(name = "Bidder")
		public Bidder bidder;

		@XmlElement(name = "Time")
		public String time;

		@XmlElement(name = "Amount")
		public String amount;
	}

	public static class Bidder {
		@XmlAttribute(name = "Rating")
		public String rating;

		@XmlAttribute(name = "UserID")
		public String userID;

		@XmlElement(name = "Location")
		public String bidder_location;

		@XmlElement(name = "Country")
		public String bidder_country;
	}

	@XmlElement(name = "Location")
	public Location loc;

	public static class Location {
		@XmlAttribute(name = "Latitude")
		public String latitude;

		@XmlAttribute(name = "Longitude")
		public String longitude;

		@XmlValue
		public String seller_location;
	}

	@XmlElement(name = "Country")
	public String seller_country;

	@XmlElement(name = "Started")
	public String started;

	@XmlElement(name = "Ends")
	public String ends;

	@XmlElement(name = "Seller")
	public Seller seller;

	public static class Seller {
		@XmlAttribute(name = "Rating")
		public String rating;

		@XmlAttribute(name = "UserID")
		public String sellerID;
	}

	@XmlElement(name = "Description")
	public String description;
}
