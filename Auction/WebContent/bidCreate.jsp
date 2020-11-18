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
		
		float bid = Float.parseFloat(request.getParameter("bidAmount"));
		float prevBid = Float.parseFloat(request.getParameter("highestBid"));
		int aucID = Integer.parseInt(request.getParameter("auctionID"));
		int aucIDDuplicate = aucID;
		int ItemID = Integer.parseInt(request.getParameter("itemID"));

		
		
		
		if (bid < prevBid) {
			con.close();
			session.invalidate();
			request.setAttribute("errorMessage", "Your bid is lower than the current value!");
			RequestDispatcher rd = request.getRequestDispatcher("/auction.jsp?auctionID="+aucID);
			rd.forward(request, response);
		}
		
		String insert = "";

		insert = "INSERT INTO bid(memberID,secretUpperLimit,bidAmount,auctionID)" + "VALUES (?,?,?,?)";
				
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, (Integer)session.getAttribute("id"));
		ps.setString(2, null);
		ps.setFloat(3, bid);
		ps.setInt(4, aucID);
		ps.executeUpdate();
		
		
		insert = "UPDATE auction SET highestBid = ? , highestBidderID = ? where auctionID = ?";
		


	
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		ps = con.prepareStatement(insert);

		
		ps.setFloat(1, bid);
		ps.setInt(2, (Integer)session.getAttribute("id"));
		ps.setInt(3,aucIDDuplicate);
		
		ps.executeUpdate();
	
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		
		
		out.println("successful bid creation!");
		
		//nidhi's add alert here
			Timestamp current = new Timestamp(System.currentTimeMillis());
			int MemberID=(Integer)session.getAttribute("id");
			//aucID
			
			//select distinct memberID from bid where auctionID=aucID and memberID<>session.memberID
			PreparedStatement select_IDs = con.prepareStatement("SELECT distinct memberID FROM bid  where auctionID=(?) and memberID<>(?);");		
			select_IDs.setInt(1,aucID);	
			select_IDs.setInt(2,MemberID);
			ResultSet result_bidIDs = select_IDs.executeQuery();
			 
			%>
						<table>
			<% 
			//loop through those memberIDs 
			//insert into alert values (null, member ID, itemID=send it from auction page, content=higher bid has been made, time)
			String Content="A higher bid has made.";
			while(result_bidIDs.next()) {
				%>
				<tr>
				<td>
				<%
				
				/* out.println("MemberID: "+result_bidIDs.getInt("memberID"));  
				out.println("<br/>");
				
				out.println("ItemID: "+ItemID);  
				out.println("<br/>");
				out.println("Content: "+Content);  
				out.println("<br/>");
				out.println("Time: "+current);  
				out.println("<br/>"); */
				
				insert="INSERT INTO alert(alertID,memberID,itemID,content,time)" + "VALUES (0,?,?,?,?)";
				
				PreparedStatement newAlert = con.prepareStatement(insert);
				newAlert.setInt(1, result_bidIDs.getInt("memberID"));
				newAlert.setInt(2, ItemID);
				newAlert.setString(3, Content);
				newAlert.setTimestamp(4,current);
				newAlert.executeUpdate();
				%>
				
				<% 		
			}
		
			
						
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Login failed");
	}
	%>
	
<br>

<a href="index.jsp">Go Back to Main Page</a>

</body>
</html>