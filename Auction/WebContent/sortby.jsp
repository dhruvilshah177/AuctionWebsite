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
	//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			PreparedStatement selection = null;
			if(entity.equals("ItemType")){
				
				selection = con.prepareStatement("SELECT DISTINCT itemType FROM product;");
				ResultSet result_auction = selection.executeQuery();
				
			while(result_auction.next()){
					
				out.println("<h4>" +result_auction.getString("itemType") + "</h4>");
				
				PreparedStatement item = con.prepareStatement("SELECT product.itemID, product.generation, product.storage, product.color, product.ram, auction.itemID, auction.sellerID, auction.auctionID, member.memberID, member.name1 FROM product, auction, member WHERE auction.itemID = product.itemID AND auction.sellerID = member.memberID AND itemType = (?);");
				
				item.setString(1, result_auction.getString("itemType"));
				ResultSet result_item = item.executeQuery();	
				
				//Run the query against the database.
				while(result_item.next()){
					out.println("<table");
					out.println("<tr>");
					out.println("<td>");
					out.println(result_item.getString("color") + " " + result_item.getString("generation") + " with " 
							+ result_item.getString("storage") + " GB storage, " + result_item.getString("ram") + " GB RAM" + " Seller: " + result_item.getString("name1") );
					session.setAttribute("Auction", result_item.getInt("auctionID"));
					%>
					<a href="auction.jsp?auctionID=<%= result_item.getInt("auctionID") %>">Click Here for Bidding.</a>

					<%
					//out.println(result_item.getInt("itemID"));
					out.println("</td>");
					out.println("</tr>");
				}
					out.println("</table>");
				}
			}
			
		else if(entity.equals("Seller")){
				
				selection = con.prepareStatement("SELECT DISTINCT member.name1 FROM member, auction WHERE member.memberID = auction.sellerID ;");
				ResultSet result_auction = selection.executeQuery();
				
			while(result_auction.next()){
				
				out.println("<h4>" +result_auction.getString("name1") + "</h4>");
				
				PreparedStatement item = con.prepareStatement("SELECT product.itemID, product.generation, product.storage, product.color, product.ram, auction.itemID, auction.sellerID, auction.auctionID, member.memberID, member.name1 FROM product, auction, member WHERE auction.itemID = product.itemID AND auction.sellerID = member.memberID AND member.name1 = (?);");
				
				item.setString(1, result_auction.getString("name1"));
				ResultSet result_item = item.executeQuery();	
				
				//Run the query against the database.
				while(result_item.next()){
					out.println("<table");
					out.println("<tr>");
					out.println("<td>");
					out.println(result_item.getString("color") + " " + result_item.getString("generation") + " with " 
							+ result_item.getString("storage") + " GB storage, " + result_item.getString("ram") + " GB RAM" );
					session.setAttribute("Auction", result_item.getInt("auctionID"));
					%>
					<a href="auction.jsp?auctionID=<%= result_item.getInt("auctionID") %>">Click Here for Bidding.</a>

					<%
					//out.println(result_item.getInt("itemID"));
					out.println("</td>");
					out.println("</tr>");
				}
					out.println("</table>");
				}
			}
			
		else if(entity.equals("Price")){
			
			selection = con.prepareStatement("SELECT DISTINCT auction.highestBid FROM auction ORDER BY auction.highestBid;");
			ResultSet result_auction = selection.executeQuery();
			
		while(result_auction.next()){
			
			if(result_auction.getInt("highestBid")!= 0){
				
			out.println("<h4>" +result_auction.getInt("highestBid")+ " $" + "</h4>");
			
			PreparedStatement item = con.prepareStatement("SELECT product.itemID, product.generation, product.storage, product.color, product.ram, auction.itemID, auction.sellerID, auction.auctionID, member.memberID, member.name1 FROM product, auction, member WHERE auction.itemID = product.itemID AND auction.sellerID = member.memberID AND auction.highestBid = (?);");
			
			item.setString(1, result_auction.getString("highestBid"));
			ResultSet result_item = item.executeQuery();	
			
			//Run the query against the database.
			while(result_item.next()){
				out.println("<table");
				out.println("<tr>");
				out.println("<td>");
				out.println(result_item.getString("color") + " " + result_item.getString("generation") + " with " 
						+ result_item.getString("storage") + " GB storage, " + result_item.getString("ram") + " GB RAM" + " Seller: " + result_item.getString("name1") );
				session.setAttribute("Auction", result_item.getInt("auctionID"));
				%>
				<a href="auction.jsp?auctionID=<%= result_item.getInt("auctionID") %>">Click Here for Bidding.</a>

				<%
				//out.println(result_item.getInt("itemID"));
				out.println("</td>");
				out.println("</tr>");
			}
				out.println("</table>");
			}
		}
		}
			%>
	<br>
	<a href="browse.jsp">Back to Browse.</a>		
</body>
</html>