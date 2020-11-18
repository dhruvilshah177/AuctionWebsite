<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Remove Bid</title>
</head>
<body>

Enter the memberID and bid amount that you wish to delete:
<br>
	<form method="post" action="delete_Bid.jsp">
	<table>
	<tr>    
	<td>MemberID</td><td><input type="text" name="memberID"></td>
	</tr>
	<tr>    
	<td>BidAmount</td><td><input type="text" name="bidAmount"></td>
	</tr>
	<tr>    	
	</table>
	<input type="submit" value="Delete Bid">
	</form>
<br>

<h2> <%
		if(null != request.getAttribute("errorMessage")) {
			out.println(request.getAttribute("errorMessage"));
		}	
%></h2>

<br>

<a href="index.jsp">Go Back to Main Page</a>

</body>
</html>