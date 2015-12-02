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
<title>Customer Level Transaction - Bid History of each auction</title>
</head>
<body style="text-align: center" bgcolor="#ffffff">
	<h1>Bid History of Each Auction</h1>
	<a href="CustomerInformation.jsp">Customer Home Page</a>
	<br>
	<br>
	<span style="font-size: 14pt; font-family: Arial"><strong>Hello,
			Customer. Your Email is <%=session.getValue("login")%>. Your ID is <%=session.getValue("customerID")%>
			.<br /> <br />
	</strong></span>
	<table border="1">
		<tr>
			<td>Auction</td>
			<td>Bidding Time</td>
			<td>Bidding Amount</td>
		</tr>
		<%
			String mysJDBCDriver = "com.mysql.jdbc.Driver";
			String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu/sikwong";
			String mysUserID = "sikwong";
			String mysPassword = "108620515";
			java.sql.Connection conn = null;
			try {
				Class.forName(mysJDBCDriver).newInstance();
				java.util.Properties sysprops = System.getProperties();
				sysprops.put("user", mysUserID);
				sysprops.put("password", mysPassword);

				//connect to the database
				conn = java.sql.DriverManager.getConnection(mysURL, sysprops);
				System.out
						.println("Connected successfully to database using JConnect");

				java.sql.Statement stmt1 = conn.createStatement();

				java.sql.ResultSet rs = stmt1
						.executeQuery("SELECT b.AuctionID, b.BidTime, b.BidPrice FROM bid b, auction a WHERE b.AuctionID = a.AuctionID AND b.CustomerID='"
								+ session.getValue("customerID") + "'");

				while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString("AuctionID")%></td>
			<td><%=rs.getString("BidTime")%></td>
			<td><%=rs.getString("BidPrice")%></td>
		</tr>
		<%
			}// while
		%>
	</table>
	<%
		} catch (Exception e) {
			e.printStackTrace();
			out.print(e.toString());
		} finally {
			try {
				conn.close();
			} catch (Exception ee) {
			}
			;
		}
	%>


	<br />
	<br />
	<br />
	<input id="Button1" type="button" value="Logout"
		onclick="window.open('index.htm','_self');" />
	<br />
	<span style="font-size: 8pt"> <br /> DSY
	</span>
</body>
</html>













