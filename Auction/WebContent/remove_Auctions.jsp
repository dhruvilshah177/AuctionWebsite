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
<title>Remove Auctions</title>
</head>
<body>
Choose which auction you would like to delete.
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
			<a href="delete_Auction.jsp?auctionID=<%= result_auction.getInt("auctionID") %>">Click Here to Delete Auction.</a>

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



<a href="index.jsp">Go Back to Main Page</a>


</body>
</html>