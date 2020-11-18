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
		
		String generation = request.getParameter("model")+" "+request.getParameter("year")+" "+request.getParameter("size")+" inches";
		String storage = request.getParameter("storage");
		String color = request.getParameter("color");
		String ram = request.getParameter("ram");
		float secret_lowerLimit = Float.parseFloat(request.getParameter("min_price"));
		float initialPrice = Float.parseFloat(request.getParameter("starting_price"));
		String end = request.getParameter("endDateTime");
		
		Timestamp endTime = Timestamp.valueOf(end);
		
		Timestamp current = new Timestamp(System.currentTimeMillis());

		
		//compare endtime with current

		
		if (generation.equals("") || storage.equals("") || color.equals("") || ram.equals("") ||  endTime.before(current)) {
			con.close();
			session.invalidate();
			request.setAttribute("errorMessage", "You did not finish the form. Please finish it.");
			RequestDispatcher rd = request.getRequestDispatcher("/macbookAuction.jsp");
			rd.forward(request, response);
		}
		
		String insert = "";

		insert = "INSERT INTO product(itemID, generation, storage, color, ram, itemType)"
				+ "VALUES (0, ?, ?, ?, ?, ?)";
	
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, generation);
		ps.setString(2, storage);
		ps.setString(3, color);
		ps.setInt(4, Integer.parseInt(ram));
		ps.setString(5,"MacBook");
		ps.executeUpdate();
		
		insert = "";
		
		int sellerID = Integer.parseInt(session.getAttribute("id").toString());
		
		String id = "";
		PreparedStatement findID = con.prepareStatement("SELECT itemID FROM product WHERE generation = (?) AND storage = (?) AND color = (?)");
		
		findID.setString(1,generation);
		findID.setString(2,storage);
		findID.setString(3,color);
		ResultSet idplz = findID.executeQuery();
		while (idplz.next()){
			if (idplz.getString("itemID")!=null) id = idplz.getString("itemID");
		}
	
		int itemID = Integer.parseInt(id);
		
		insert = "INSERT INTO auction(auctionID, sellerID, itemID, initialPrice, secret_lowerLimit,endTime,highestBid,highestBidderID, sold)"
				+ "VALUES (0, ?, ?, ?, ? , ? , 0 , null,0)";
		

		
	
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		ps = con.prepareStatement(insert);

		
		ps.setInt(1, sellerID);
		ps.setInt(2, itemID);
		ps.setFloat(3, initialPrice);
		ps.setFloat(4, secret_lowerLimit);
		ps.setTimestamp(5,endTime);
		ps.executeUpdate();
		
		//nidhi check if someone desires this poduct and send them alert
				//select distinct memberID from desire where item not available is desired
					PreparedStatement select_IDs = con.prepareStatement("SELECT distinct memberID FROM desire where itemType=(?) and storage=(?) and color=(?) and memberID<>(?);");		
					select_IDs.setString(1,"MacBook");	
					select_IDs.setString(2,storage);
					select_IDs.setString(3,color);
					select_IDs.setInt(4,(Integer)session.getAttribute("id"));
					ResultSet result_desireIDs = select_IDs.executeQuery();
						
				%>
							<table>
				<% 
				//loop through those memberIDs 
				//insert into alert values (null, member ID, itemID=send it from auction page, content=higher bid has been made, time)
				//delete from desire
				String Content="A desired item is now avialable.";
				while(result_desireIDs.next()) {
					%>
					<tr>
					<td>
					<%
					
					/* out.println("MemberID: "+result_desireIDs.getInt("memberID"));  
					out.println("<br/>");
					
					out.println("ItemType: "+"MacBook");  
					out.println("<br/>");
					out.println("Storage: "+storage);  
					out.println("<br/>");
					out.println("Color: "+color);  
					out.println("<br/>");
					out.println("ItemID: "+itemID);  
					out.println("<br/>"); */
					
					insert="INSERT INTO alert(alertID,memberID,itemID,content,time)" + "VALUES (0,?,?,?,?)";
					PreparedStatement newAlert = con.prepareStatement(insert);
					newAlert.setInt(1, result_desireIDs.getInt("memberID"));
					newAlert.setInt(2, itemID);
					newAlert.setString(3, Content);
					newAlert.setTimestamp(4,current);
					newAlert.executeUpdate();
					
					String delete="DELETE FROM desire where memberID=? and itemType=? and storage=? and color=?";
					PreparedStatement deleteDesire = con.prepareStatement(delete);
					deleteDesire.setInt(1, result_desireIDs.getInt("memberID"));
					deleteDesire.setString(2, "MacBook");
					deleteDesire.setString(3, storage);
					deleteDesire.setString(4,color);
					deleteDesire.executeUpdate(); 
				}


		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Auction Creation Successful!");
		request.setAttribute("errorMessage", null);	
	} catch (Exception ex) {
		out.print(ex);
		out.print("Login failed");
	}
	%>
	
<br>

<a href="index.jsp">Go Back to Main Page</a>

</body>
</html>








