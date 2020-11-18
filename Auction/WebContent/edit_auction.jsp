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
		String auctionID = request.getParameter("auctionID");
		String sLowLimit = request.getParameter("secretlowlimit");
		String endTime = request.getParameter("endtime");
		
		if (auctionID.equals("")) {
			con.close();
			session.invalidate();
			request.setAttribute("errorMessage", "You must enter an auctionID.");
			RequestDispatcher rd = request.getRequestDispatcher("/edit_auctionform.jsp");
			rd.forward(request, response);
		}
		
		PreparedStatement auctionInfo = con.prepareStatement("SELECT * FROM auction where auctionID=(?)");		
		auctionInfo.setString(1,auctionID);
		ResultSet resultAuctionInfo= auctionInfo.executeQuery();
		
		if (resultAuctionInfo.next()){
			if (sLowLimit.equals(""))
			{
				sLowLimit=resultAuctionInfo.getString("secret_lowerLimit");
			}	
			if (endTime.equals(""))
			{
				endTime=resultAuctionInfo.getString("endTime");
			}	
		}
		
		String Update="UPDATE auction SET secret_lowerLimit = ?, endTime = ? WHERE auctionID = ?";
		PreparedStatement UpdateBid = con.prepareStatement(Update);
		UpdateBid.setString(1,sLowLimit);
		UpdateBid.setString(2,endTime);
		UpdateBid.setString(3,auctionID);
		
		UpdateBid.executeUpdate(); 
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Auction Update Successful!");
		
		request.setAttribute("errorMessage", null);		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Update failed :()");
	}
%>

<br>

<a href="index.jsp">Go Back to Main Page</a>

</body>
</html>