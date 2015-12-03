<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	if (request.getProtocol().compareTo("HTTP/1.0") == 0)
		response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().compareTo("HTTP/1.1") == 0)
		response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);

	if (session.getValue("login") == null) {
		response.sendRedirect("index.htm");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Level Transaction - Register to Sell Item -
	Create Auction</title>
	<%@include file="include/head_include.html"%>
<script language="javascript" type="text/javascript">
	function Button1_onclick() {
		if (document.myForm.BidIncrement.value == "")
			alert("Your Bid Increment must not be empty!!!")
		else if (document.myForm.MinimuBid.value == "")
			alert("Your Minimum Bid must not be empty!!!")
		else if (document.myForm.Copies_Sold.value == "")
			alert("Your Copies_sold must not be empty!!!")
		else if (document.myForm.ItemID.value == "")
			alert("Your ItemID must not be empty!!!")
		else if (document.myForm.ExpireDate.value == "")
			alert("Your ExpireDate must not be empty!!!")
		else if (document.myForm.reserveprice.value == "")
			alert("Your reserveprice must not be empty and Have to be greater than minimum bid!!!")
		else
			document.myForm.submit()
		
	}
</script>
</head>
<body style="text-align: center" bgcolor="#ffffff">
<%@include file="include/nav_customer.html"%>
	<h1>Register to Sell Item - Create Auction</h1>
	<a href="CustomerInformation.jsp">Customer Home Page</a>
	<br>
	<br>
	<span style="font-size: 14pt; font-family: Arial"><strong>Hello,
			Customer. Your Email is <%=session.getValue("login")%>. Your ID is <%=session.getValue("customerID")%>
			.<br /> <br />
	</strong></span>

	<form name="myForm" action="create_auction_transaction.jsp" method="post">


		<span style="font-size: 10pt"><strong>Bid Increment:</strong></span><br />
		<input name="BidIncrement"
			style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />

		<span style="font-size: 10pt"><strong>Minimum Bid:</strong></span><br />
		<input name="MinimuBid"
			style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />

		<span style="font-size: 10pt"><strong>Copies_Sold:</strong></span><br />
		<input name="Copies_Sold"
			style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />

		<span style="font-size: 10pt"><strong>ItemID:</strong></span><br /> <input
			name="ItemID"
			style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />

		<span style="font-size: 10pt"><strong> <br />Expire
				Data (Expire in 3, 5, 7 day from the post date):<br /></strong></span> 
				<select name="ExpireDate">
			<option value="3">3</option>
			<option value="5">5</option>
			<option value="7">7</option>
		</select> <br />

		<span style="font-size: 10pt"><strong>Reserve Price:</strong></span><br />
		<input name="reserveprice"	style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />

		<input id="Button2" type="button" value="Go" onclick="return Button1_onclick()" />
	</form>
	<br>

	


	<br />
	<br />
	<br />
	<input id="Button1" type="button" value="Logout"
		onclick="window.open('index.htm','_self');" />
	<br />
	<span style="font-size: 8pt"> <br /> DSY
	</span>
	<%@include file="include/end_js_include.html"%>
</body>
</html>













