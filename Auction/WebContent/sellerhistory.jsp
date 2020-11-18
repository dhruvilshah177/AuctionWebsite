<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Sort By</title>
</head>
<body>
	<%
	//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get the selected radio button from the index.jsp
			String nameseller = request.getParameter("seller");
			PreparedStatement selection = con.prepareStatement("SELECT memberID FROM member WHERE name1 = ?");
			selection.setString(1,nameseller);
			ResultSet result_seller = selection.executeQuery();
			
			while(result_seller.next()){
				
				out.println("<h4>" +"Auctions "+ nameseller + " has participated in are: " + "</h4>");
			
				PreparedStatement auction_seller = con.prepareStatement("SELECT product.itemID, product.generation, product.storage, product.color, product.ram, auction.itemID, auction.sellerID, auction.auctionID FROM product, auction, member WHERE memberID = (?) AND auction.sellerID = member.memberID AND auction.itemID = product.itemID ;" );
				auction_seller.setInt(1, result_seller.getInt("memberID"));
				ResultSet result_aucseller = auction_seller.executeQuery();
				
				while(result_aucseller.next()){
					out.println("<table");
					out.println("<tr>");
					out.println("<td>");
					out.println(result_aucseller.getString("color") + " " + result_aucseller.getString("generation") + " with " 
							+ result_aucseller.getString("storage") + " GB storage, " + result_aucseller.getString("ram") + " GB RAM");
					session.setAttribute("Auction", result_aucseller.getInt("auctionID"));
					//out.print("<a href='auction.jsp'>Click Here for Bidding.</a>");
					//out.println(result_item.getInt("itemID"));
					out.println("</td>");
					out.println("</tr>");
				}
					out.println("</table>");
				}
				
			
	%>
	<br>
	<a href="browse.jsp">Back to Browse.</a>		
</body>
</html>