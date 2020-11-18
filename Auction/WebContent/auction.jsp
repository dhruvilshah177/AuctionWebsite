<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Auctions</title>
</head>
<body>
	<% 
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	
		//Create a SQL statement
		Statement stmt = con.createStatement();		
		
	

		int aucID = Integer.parseInt(request.getParameter("auctionID"));
		
		PreparedStatement select_auction = con.prepareStatement("SELECT sellerID, itemID, initialPrice, endTime, highestBid, highestBidderID FROM auction where auctionID = (?)");
		select_auction.setInt(1,aucID);		
		ResultSet resultAuction = select_auction.executeQuery();
		resultAuction.next();

		
		PreparedStatement select_product = con.prepareStatement("SELECT generation, storage, color, ram, itemType FROM product where itemID = (?)");		
		select_product.setInt(1,resultAuction.getInt("itemID"));
		ResultSet resultProduct = select_product.executeQuery();
		resultProduct.next();
			
		
		out.println("Model: "+resultProduct.getString("color")+" "+resultProduct.getString("generation"));
		out.println("<br/>");
		out.println("Storage: "+resultProduct.getString("storage")+" GB");
		out.println("<br/>");
		out.println("RAM: "+resultProduct.getString("ram")+" GB");
		out.println("<br/>");

		
		out.println("<br/>");
		out.println("<br/>");
		
		out.println("Current Highest Bid: "+resultAuction.getInt("highestBid"));
		
		out.println("<br/>");
		out.println("<br/>");
		out.println("Auction started at: $"+resultAuction.getInt("initialPrice"));
		out.println("<br/>");
		out.println("<br/>");
		%>
		<br><br>

		<form action= "bidCreate.jsp?auctionID=<%= aucID %>&highestBid=<%= resultAuction.getInt("highestBid")%>&itemID=<%=resultAuction.getInt("itemID") %>" method="POST">
			<label for="question">Enter a Bid if you wish! (Must be higher than current highest)</label>
			<input type="number" step="0.01" name="bidAmount" placeholder="0.00" min="0.00" required> <br>		
			<input type="submit" value="Submit">
		</form>
		<% 
		out.println("Bid history for this auction: <br/>");
		
		PreparedStatement history = con.prepareStatement("SELECT * FROM bid WHERE auctionID = ?");
		history.setInt(1,aucID);
		ResultSet bids = history.executeQuery();
		while (bids.next()){
			
			out.println(bids.getInt("bidAmount")+"<br/>");
			
		}
		
		//nidhi... send itemID to product Q&A page 
		session.setAttribute("ItemID", resultAuction.getInt("itemID"));
		out.println("<br/>");
		%>
		<a href="display_forum.jsp?itemID=<%= resultAuction.getInt("itemID") %>">Click Here for Product Questions and Answers.</a>						<%
		
		con.close();
		
		
	}catch (Exception ex) {
		out.print(ex);
		out.print("Login failed");
	}
	
	%>




<br>
<br><br><br><br><br>
<a href="index.jsp">Go Back to Main Page</a>


</body>
</html>