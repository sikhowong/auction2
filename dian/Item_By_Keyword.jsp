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
<title>Customer Level Transaction - Items Available By Keyword</title>
<script language="javascript" type="text/javascript">
	function Button1_onclick() {
		if (document.myForm.Keyword.value == "")
			alert("Your Keyword must not be empty!!!")

		else {
			document.myForm.submit()
		}
	}
</script>
</head>
<body style="text-align: center" bgcolor="#ffffff">
	<h1>Items Available By Keyword</h1>
	<a href="CustomerInformation.jsp">Customer Home Page</a>
	<br>
	<br>
	<span style="font-size: 14pt; font-family: Arial"><strong>Hello,
			Customer. Your Email is <%=session.getValue("login")%>. Your ID is <%=session.getValue("customerID")%>
			.<br /> <br />
	</strong></span>

	<form name="myForm" action="Item_By_Keyword.jsp" method="post">


		<span style="font-size: 10pt"><strong>Item Keyword:</strong></span><br />
		<input name="Keyword"
			style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />

		<input id="Button2" type="button" value="Go"
			onclick="return Button1_onclick()" />
	</form>
	<br> >
	<%
		if (request.getParameter("Keyword") != null) {
	%>
	<table border="1">
		<tr>
			<td>Item ID</td>
			<td>Name</td>
			<td>NumCopies</td>
			<td>Auction ID</td>
			<td>Bid Increment</td>
			<td>Minimum Bid</td>
			<td>Copies Sold</td>
			<td>Monitor</td>
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
					conn = java.sql.DriverManager.getConnection(mysURL,
							sysprops);
					System.out
							.println("Connected successfully to database using JConnect");

					java.sql.Statement stmt1 = conn.createStatement();

					java.sql.ResultSet rs = stmt1
							.executeQuery("SELECT i.ItemID, i.Name, i.NumCopies, a.AuctionID, a.BidIncrement, a.Minimubid, a.Copies_Sold, a.Monitor FROM item i, auction a WHERE i.Name LIKE '%"
									+ request.getParameter("Keyword")
									+ "%' AND i.ItemID = a.ItemID");

					while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString("ItemID")%></td>
			<td><%=rs.getString("Name")%></td>
			<td><%=rs.getString("NumCopies")%></td>
			<td><%=rs.getString("AuctionID")%></td>
			<td><%=rs.getString("BidIncrement")%></td>
			<td><%=rs.getString("Minimubid")%></td>
			<td><%=rs.getString("Copies_Sold")%></td>
			<td><%=rs.getString("Monitor")%></td>
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













