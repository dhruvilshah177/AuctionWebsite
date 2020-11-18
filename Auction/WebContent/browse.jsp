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
<h4> Sort By</h4>
<br>
<form method="post" action="sortby.jsp">

  <input type="radio" name="command" value="ItemType"/>Item Type
  <br>
   <input type="radio" name="command" value="Seller"/> Seller
  <br>
 	<input type="radio" name="command" value="Price"/> Bidding Price
  <br>
  <input type="submit" value="submit" />
</form>

<h4>
Click an auction for more detail about the product
</h4>
<br>
	
	<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();		
	

	PreparedStatement select_IDs = con.prepareStatement("SELECT * FROM auction natural join product where sold=false order by itemType;");
	//Run the query against the database.
	ResultSet result_auction = select_IDs.executeQuery();
	
	%>
	<table>
	<% 
	while(result_auction.next()) {
		
		
		Timestamp endTime = result_auction.getTimestamp("endTime");
		Timestamp current = new Timestamp(System.currentTimeMillis());

		if (endTime.before(current)){

			PreparedStatement ps = con.prepareStatement("UPDATE auction SET sold = 1 WHERE auctionID = ?");
			ps.setInt(1,result_auction.getInt("auctionID"));
			ps.executeUpdate();
			
			if (result_auction.getInt("highestBid") < result_auction.getInt("secret_lowerLimit")){
				
				//notify seller that the auction's over, nobody reached their minimum
				//seller id = result_auction.getInt("sellerID")
				String insert="INSERT INTO alert(alertID,memberID,itemID,content,time)" + "VALUES (0,?,?,?,?)";
				String content="Auction ended with no buyer.";
				PreparedStatement newAlert = con.prepareStatement(insert);
				newAlert.setInt(1, result_auction.getInt("sellerID"));
				newAlert.setInt(2, result_auction.getInt("itemID"));
				newAlert.setString(3, content);
				newAlert.setTimestamp(4,current);
				newAlert.executeUpdate();
				
			}
			else {
	
				//notify seller that they won
				String insert="INSERT INTO alert(alertID,memberID,itemID,content,time)" + "VALUES (0,?,?,?,?)";
				String content="Auction ended with a winner.";
				PreparedStatement newAlert = con.prepareStatement(insert);
				newAlert.setInt(1, result_auction.getInt("highestBidderID"));
				newAlert.setInt(2, result_auction.getInt("itemID"));
				newAlert.setString(3, content);
				newAlert.setTimestamp(4,current);
				newAlert.executeUpdate();
				//notify winner that they won the item
				insert="INSERT INTO alert(alertID,memberID,itemID,content,time)" + "VALUES (0,?,?,?,?)";
				content="You won the auction.";
				newAlert = con.prepareStatement(insert);
				newAlert.setInt(1, result_auction.getInt("highestBidderID"));
				newAlert.setInt(2, result_auction.getInt("itemID"));
				newAlert.setString(3, content);
				newAlert.setTimestamp(4,current);
				newAlert.executeUpdate();
			}

		}
		%>
		<tr>
		<td>
		<%
		PreparedStatement select_item = con.prepareStatement("SELECT generation, storage, color, ram, itemType FROM product where itemID = (?)");
		select_item.setInt(1, result_auction.getInt("itemID"));		
		ResultSet result_item = select_item.executeQuery();	
		if(result_item.next()){
			/* String name = result_item.getString("itemType").toLowerCase();
			name = Character.toUpperCase(name.charAt(0)) + name.substring(1); */
		
			out.println(result_item.getString("color") + " " + result_item.getString("generation") + " with " 
			+ result_item.getString("storage") + " GB storage, " + result_item.getString("ram") + " GB RAM");
		
			PreparedStatement select_member = con.prepareStatement("SELECT name1 FROM member where memberID = (?)");
			select_member.setInt(1, result_auction.getInt("sellerID"));		
			ResultSet result = select_member.executeQuery();	
		
			if(result.next()){
				out.println("Seller: " + result.getString("name1"));
		
			}
			session.setAttribute("Auction", result_auction.getInt("auctionID"));
			%>
			<a href="auction.jsp?auctionID=<%= result_auction.getInt("auctionID") %>">Click Here for Bidding.</a>

			<%
		// PASS AUCTION ID TO AUCTION PAGE ON CLICK		
		}	
		%>
		</td>
		</tr>
		<% 		
	}
	%>
	
	</table>	


	<h4> Find out history of auctions for a buyer: </h4>
	
	<br>
	<form method="post" action="buyerhistory.jsp">
	<table>
	<tr>    
	<td> Name of buyer </td><td><input type="text" name="buyer"></td>
	</tr>
	</table>
	<input type="submit" value="submit">
	</form>
	
	<h4> Find out history of auctions for a seller: </h4>
	
	<br>
	<form method="post" action="sellerhistory.jsp">
	<table>
	<tr>    
	<td> Name of seller </td><td><input type="text" name="seller"></td>
	</tr>
	</table>
	<input type="submit" value="submit">
	</form>
	

<a href="index.jsp">Go Back to Main Page</a>


</body>
</html>