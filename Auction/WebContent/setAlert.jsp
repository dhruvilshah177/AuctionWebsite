<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Set an Alert</title>
</head>
<body>

	<div class="content">
		<form action="setAlertCreate.jsp" method="POST">
		
			<label for="itemType">Item Type: </label>
			<select name="itemType" id="itemType" required>
				<option value="" disabled selected hidden="true">Select Item Type</option>
				<option value="iPhone">iPhone</option>
				<option value="iPad">iPad</option>
				<option value="MacBook">MacBook</option>
				</select> <br> 
		<label for="color">Color: </label>
			<select name="color" id="color" required>
				<option value="" disabled selected hidden="true">Select Color</option>
				<option value="Silver">Silver</option>
				<option value="Gold">Gold</option>
				<option value="Space Grey">Space Grey</option>
				<option value="Rose Gold">Rose Gold</option>
				</select> <br> 
		<label for="storage">Storage: </label>
			<select name="storage" id="storage" required>
				<option value="" disabled selected hidden="true">Select Storage Amount</option>
				<option value=128>128 GB</option>
				<option value=256>256 GB</option>
				<option value=512>512 GB</option>
				<option value=1>1 TB</option>
				<option value=2>2 TB</option>
				<option value=2>4 TB</option>
				</select> <br> 
		
			
				

			<input type="submit" value="Submit">
		</form>
	</div>
	
<br>


<a href="index.jsp">Go Back to Main Page</a>


</body>
</html>