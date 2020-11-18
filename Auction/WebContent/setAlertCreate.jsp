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
		
		String itemType = request.getParameter("itemType");
		String color = request.getParameter("color");
		String storage = request.getParameter("storage");
		
		int MemberID=(Integer)session.getAttribute("id");


		
		
		
		//compare endtime with current

		
		if (itemType.equals("") || storage.equals("") || color.equals("") ) {
			con.close();
			session.invalidate();
			request.setAttribute("errorMessage", "You did not finish the form. Please finish it.");
			RequestDispatcher rd = request.getRequestDispatcher("/setAlert.jsp");
			rd.forward(request, response);
		}
		
		String insert = "";

		insert = "INSERT INTO desire(memberID, itemType, storage, color)"
				+ "VALUES (?, ?, ?, ?)";
	
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, MemberID);
		ps.setString(2, itemType);
		ps.setString(3, storage);
		ps.setString(4, color);
		ps.executeUpdate();
		
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Alert Entry Successful!");
		request.setAttribute("errorMessage", null);	
	} catch (Exception ex) {
		out.print(ex);
		out.print("Login failed");
	}
	%>
	
<br>
<a href="AuctionMaker.jsp">CREATE AUCTION</a>

<a href="index.jsp">Go Back to Main Page</a>

</body>
</html>