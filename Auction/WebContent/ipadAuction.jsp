<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Create Ipad Auction</title>
</head>
<body>
	<div class="content">
		<form action="AuctionCreate.jsp" method="POST">
		<label for="generation">Generation: </label>
			<select name="generation" id="Generation" required>
				<option value="" disabled selected hidden="true">Select Generation</option>
				<option value="iPad 1">iPad 1st gen</option>
				<option value="iPad 2">iPad 2nd gen</option>
				<option value="iPad 3">iPad 3rd gen</option>
				<option value="iPad 4">iPad 4th gen</option>
				<option value="iPad 5">iPad 5th gen</option>
				<option value="iPad Mini 1">iPad Mini 1st gen</option>
				<option value="iPad Mini 2">iPad Mini 2nd gen</option>
				<option value="iPad Mini 3">iPad Mini 3rd gen</option>
				<option value="iPad Mini 4">iPad Mini 4th gen</option>
				<option value="iPad Air 1">iPad Air 1</option>
				<option value="iPad Air 2">iPad Air 2</option>
				<option value="iPad Pro 1st gen 9.7in">iPad Pro 1st gen 9.7in</option>
				<option value="iPad Pro 1st gen 12.9in">iPad Pro 1st gen 12.9in</option>
				<option value="iPad Pro 2nd gen 10.5in">iPad Pro 2nd gen 10.5in</option>
				<option value="iPad Pro 2nd gen 12.9in">iPad Pro 2nd gen 12.9in</option>
				<option value="iPad Pro 3rd gen 11in">iPad Pro 3rd gen 11in</option>
				<option value="iPad Pro 3rd gen 12.9in">iPad Pro 3rd gen 12.9in</option>
				</select> <br> 
		
		<label for="color">Color: </label>
			<select name="color" id="color" required>
				<option value="" disabled selected hidden="true">Select Color</option>
				<option value="Black">Black</option>
				<option value="White">White</option>
				<option value="Silver">Silver</option>
				<option value="Gold">Gold</option>
				<option value="Space Grey">Space Grey</option>
				<option value="Rose Gold">Rose Gold</option>
				</select> <br> 
		<label for="storage">Storage: </label>
			<select name="storage" id="storage" required>
				<option value="" disabled selected hidden="true">Select Storage Amount</option>
				<option value=8>8 GB</option>
				<option value=16>16 GB</option>
				<option value=32>32 GB</option>
				<option value=64>64 GB</option>
				<option value=128>128 GB</option>
				<option value=256>256 GB</option>
				<option value=512>512 GB</option>
				</select> <br> 




			
			<!-- RESTRICT HOURS TO WHOLE HOURS --> 
			<label for="endDateTime">Auction Closing: Date & Time (MUST be >1 day from now)</label>
			<input type="datetime-local" name="endDateTime" id="endDateTime" placeholder="yyyy-mm-dd --:--"> <br>

			<label for="min_price">Minimum Bid Price (hidden from bidders)</label>
			<input type="number" step="0.01" name="min_price" placeholder="0.00" min="0.00" required> <br>	
			<label for="starting_price">Starting Bid Price</label>
			<input type="number" step="0.01" name="starting_price" placeholder="0.00" min="0.00" required> <br>	
			<input type="submit" value="Submit">
		</form>
	</div>



</body>
</html>