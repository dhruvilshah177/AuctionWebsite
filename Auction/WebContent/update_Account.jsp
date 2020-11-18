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

		//Get parameters from the HTML form at the HelloWorld.jsp
		String memberID = request.getParameter("memberID");
		String name = request.getParameter("name");
		String pass = request.getParameter("pass");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String bAN = request.getParameter("BAN");
		String bRN = request.getParameter("BRN");
		String phone = request.getParameter("phone");
		
		if (memberID.equals("")) {
			con.close();
			session.invalidate();
			request.setAttribute("errorMessage", "You must enter a memberID.");
			RequestDispatcher rd = request.getRequestDispatcher("/edit_AccountInfo.jsp");
			rd.forward(request, response);
		}
		
		PreparedStatement memberInfo = con.prepareStatement("SELECT * FROM member where memberID=(?)");		
		memberInfo.setString(1,memberID);
		ResultSet resultMemberInfo= memberInfo.executeQuery();
		//out.println("MemberID: "+memberID);
		if (resultMemberInfo.next()){
			if (name.equals(""))
			{
				name=resultMemberInfo.getString("name1");
			}	
			//out.println("Name: "+name);
			if (pass.equals(""))
			{
				pass=resultMemberInfo.getString("pass");
			}
			if (email.equals(""))
			{
				email=resultMemberInfo.getString("email");
			}
			else if (!email.contains("@")) 
			{
				con.close();
				session.invalidate();
				request.setAttribute("errorMessage", "Email invalid. Please enter email.");
				RequestDispatcher rd = request.getRequestDispatcher("/edit_AccountInfo.jsp");
				rd.forward(request, response);
			} 
			//out.println("email: "+email);
			if (address.equals(""))
			{
				address=resultMemberInfo.getString("homeAddress");
			}
			//out.println("address: "+address);
			if (bAN.equals(""))
			{
				bAN=resultMemberInfo.getString("bankAccountNum");
			}
			//out.println("bAN: "+bAN);
			if (bRN.equals(""))
			{
				bRN=resultMemberInfo.getString("bankRoutingNum");
			}
			//out.println("bRN: "+bRN);
			if (phone.equals(""))
			{
				phone=resultMemberInfo.getString("phone");
			}
			else if (phone.length() != 10) 
			{
				con.close();
				session.invalidate();
				request.setAttribute("errorMessage", "Phone Number invalid. Please enter correct number.");
				RequestDispatcher rd = request.getRequestDispatcher("/edit_AccountInfo.jsp");
				rd.forward(request, response);
			}
			//out.println("phone: "+phone);
		}
		
	
	
	
		
		

		
		
		
		String update = "UPDATE member SET  name1= ?, phone=?, email=?, pass=?, homeAddress=?, bankAccountNum=?, bankRoutingNum=? where memberID= ?";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(update);
		ps.setString(1, name);
		ps.setString(2, phone);
		ps.setString(3, email);
		ps.setString(4, pass);
		ps.setString(5, address);
		ps.setString(6, bAN);
		ps.setString(7, bRN);
		ps.setString(8, memberID);
		ps.executeUpdate();
		
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Account Update Successful!");
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