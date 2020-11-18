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
<title></title>
</head>
<body>
	<%
	try {		

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String name = request.getParameter("name");
		String pass = request.getParameter("pass");

		PreparedStatement select_name = con.prepareStatement("SELECT name1 FROM member WHERE name1 = (?)");
		select_name.setString(1, name);
		//Run the query against the database.
		ResultSet result_name = select_name.executeQuery();
		
		int checker = 0;
		while(result_name.next()) {
			if(name.equals(result_name.getString("name1"))) {
				checker = 1;
				break;
			}			
		}
		
		if(checker == 0) {
			con.close();
			session.invalidate();
			request.setAttribute("errorMessage", "Invalid Username");
			RequestDispatcher rd = request.getRequestDispatcher("/log.jsp");
			rd.forward(request, response);

		}
		
		PreparedStatement select_pass = con.prepareStatement("SELECT pass FROM member WHERE name1 = (?) AND pass = (?)");
		select_pass.setString(1, name);
		select_pass.setString(2, pass);
		//Run the query against the database.
		ResultSet result_pass = select_pass.executeQuery();
		

		
		
		while(result_pass.next()) {
			if(pass.equals(result_pass.getString("pass"))) {
				checker = 2;
				break;
			}		
		}
		
		if(checker == 1) {
			con.close();
			session.invalidate();
			request.setAttribute("errorMessage", "Invalid Password");
			RequestDispatcher rd = request.getRequestDispatcher("/log.jsp");
			rd.forward(request, response);
		} else if(checker == 2) {
			out.print("Login Successful!");			
			session.setAttribute("loggedIn", "true"); 
			
			
			String id = "";
			PreparedStatement findID = con.prepareStatement("SELECT memberID FROM member WHERE name1 = (?) AND pass = (?)");
			
			findID.setString(1,name);
			findID.setString(2,pass);
			ResultSet idplz = findID.executeQuery();
			while (idplz.next()){
				if (idplz.getString("memberID")!=null) id = idplz.getString("memberID");
			}
			int memID = Integer.parseInt(id);
			session.setAttribute("id",memID);
			
			
			
			
			PreparedStatement select_IDs = con.prepareStatement("SELECT * FROM auction natural join product where sold=false order by itemType;");
			//Run the query against the database.
			ResultSet result_auction = select_IDs.executeQuery();
			
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


			
			request.setAttribute("errorMessage", null);
		}
		
		PreparedStatement check_admin = con.prepareStatement("SELECT isAdmin FROM member where name1 = (?)");
		check_admin.setString(1, name);
		result_name = check_admin.executeQuery();
		
		if(result_name.next()) {
			if("1".equals(result_name.getString("isAdmin"))) {
				session.setAttribute("isAdmin", "true");
				out.println("<br>Welcome Admin");				
			}			
		}
		
		PreparedStatement check_CR = con.prepareStatement("SELECT isRep FROM member where name1=(?)");	
		check_CR.setString(1, name);
		result_name = check_CR.executeQuery();
		
		while(result_name.next()) {
			if("1".equals(result_name.getString("isRep"))) {
				session.setAttribute("isRep", "true");
				out.println("Welcome Customer Rep");
				break;
			}			
		}
		}
		
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Login failed");
	}
	%>
	
<br>
<a href="iphoneAuction.jsp">Post an iPhone Auction</a> <br>
<a href="ipadAuction.jsp">Post an iPad Auction</a>   <br>
<a href="macbookAuction.jsp">Post a MacBook Auction</a>  <br>
<a href="browse.jsp">Browse current auctions!</a> <br>
<a href="index.jsp">Go Back to Main Page</a><br>


</body>
</html>