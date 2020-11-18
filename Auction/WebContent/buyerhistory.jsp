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
			String namebuyer = request.getParameter("buyer");
			
			PreparedStatement selection = con.prepareStatement("SELECT memberID FROM member WHERE name1 = ?");
			selection.setString(1,namebuyer);
			ResultSet result_seller = selection.executeQuery();
			
			if(result_seller.next()){
			
			PreparedStatement temp_buyer = con.prepareStatement("SELECT DISTINCT auctionID FROM bid WHERE memberID = ?");
			temp_buyer.setInt(1,result_seller.getInt("memberID"));
			ResultSet result_temp = temp_buyer.executeQuery();
			
			out.println("<h4>" +"Auctions "+ namebuyer + " has participated in are: " + "</h4>");
			
			while (result_temp.next()){
				
				PreparedStatement auction_buyer = con.prepareStatement("SELECT product.itemID, product.generation, product.storage, product.color, product.ram, bid.auctionID, auction.itemID, auction.auctionID FROM product, bid, auction WHERE bid.auctionID = (?) AND auction.auctionID = bid.auctionID AND auction.itemID = product.itemID ;" );
				auction_buyer.setInt(1, result_temp.getInt("auctionID"));
				ResultSet result_aucbuyer = auction_buyer.executeQuery();
						
				if(result_aucbuyer.next()){
					out.println("<table>");
					out.println("<tr>");
					out.println("<td>");
					out.println(result_aucbuyer.getString("color") + " " + result_aucbuyer.getString("generation") + " with " 
							+ result_aucbuyer.getString("storage") + " GB storage, " + result_aucbuyer.getString("ram") + " GB RAM");
					
					//out.println(result_item.getInt("itemID"));
					out.println("</td>");
					out.println("</tr>");
				}
					out.println("</table>");
				}
				
			}
	%>
	<br>
	<a href="browse.jsp">Back to Browse.</a>		
</body>
</html>
