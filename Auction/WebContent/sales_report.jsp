<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Sales Report</title>
</head>
<body>
	<%
	try {		

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();		
		

		PreparedStatement select_IDs = con.prepareStatement("SELECT memberID, name1 FROM member WHERE isAdmin = 0 AND isRep = 0");		
		//Run the query against the database.
		ResultSet result_IDs = select_IDs.executeQuery();
		
		int checker = 0;
		while(result_IDs.next()) {			
			String curr_ID = result_IDs.getString("memberID");
			out.print("<br>Name: " + result_IDs.getString("name1") + " memberID: " + curr_ID + "<br>");		
			
			String bestItem = "-1";
			int bestPrice = 0, currPrice = 0, totalEarned = 0;			
			
			PreparedStatement select_auction = con.prepareStatement("SELECT auctionID, itemID, highestBidderID, highestBid FROM auction WHERE sellerID = (?)");
			
			select_auction.setString(1, curr_ID);
			ResultSet result_auction = select_auction.executeQuery();
									
			
			if(result_auction.next() == false) {
				continue;
			} else {
			
			currPrice = result_auction.getInt("highestBid");
			bestPrice = currPrice;
			
			
			do {
				PreparedStatement select_item = con.prepareStatement("SELECT itemType, generation FROM product WHERE itemID = (?)");	
				select_item.setString(1, result_auction.getString("itemID"));
				ResultSet result_item = select_item.executeQuery();
				
				result_item.next();
				if(bestItem.equals("-1")) {					
					
					bestItem = result_item.getString("itemType") + result_item.getString("generation");
				}
				
				currPrice = result_auction.getInt("highestBid");
				totalEarned += currPrice;
				
				if(currPrice > bestPrice) {
					bestPrice = currPrice;
					bestItem = result_item.getString("itemType") + result_item.getString("generation");
				}
				
				out.print("     item: " + result_item.getString("itemType") + result_item.getString("generation") + ", buyer/current highest bidder ID: " + result_auction.getString("highestBidderID") + "<br>");
				
			} while(result_auction.next());
			out.print("Total Earned: " + totalEarned);
			out.print("<br>Best Seller: " + bestItem + " at: " + bestPrice + "<br><br>");						
			}
		}		
		
				
		con.close();
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Report failed");
	}
	%>
<br>
<a href="index.jsp">Go Back to Main Page</a>
<br>
<a href="admin.jsp">Go Back to Admin Page</a>

</body>
</html>