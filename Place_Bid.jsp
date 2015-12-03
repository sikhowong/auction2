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
<title>Customer Level Transaction - Place Bid</title>
<%@include file="include/head_include.html"%>
<script language="javascript" type="text/javascript">
	function Button1_onclick() {
		if (document.myForm.BidPrice.value == "")
			alert("Your Bid Price must not be empty!!!")
		else if (document.myForm.MaximumBid.value == "")
			alert("Your Maximum Bid must not be empty!!!")
		else {
			document.myForm.submit()
		}
	}
</script>
</head>
<body style="text-align: center" bgcolor="#ffffff">
<%@include file="include/nav_customer.html"%>
	<h1>Place Bid for the Following Item</h1>
	<a href="CustomerInformation.jsp">Customer Home Page</a>
	<br>
	<br>
	<span style="font-size: 14pt; font-family: Arial"><strong>Hello,
			Customer. Your Email is <%=session.getValue("login")%>. Your ID is <%=session.getValue("customerID")%>
			.<br /> <br />
	</strong></span>

	<%
		if (request.getParameter("auctionid") != null
				&& request.getParameter("itemid") != null) {
	%>
	<div class="table-responsive">
          <table class="table table-striped">

		<tr>
			<td>AuctionID</td>
			<td>Bid Increment</td>
			<td>Minimum Bid</td>
			<td>Copies_Sold</td>
			<td>Monitor</td>
			<td>ItemID</td>
			<td>Item Name</td>
			<td>Item Description</td>
			<td>Item Type</td>
			<td>Reserved Price</td>

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
							.executeQuery("select a.AuctionID, a.BidIncrement, a.MinimuBid, a.Copies_Sold, a.monitor, a.ItemID, i.Name, i.Description, i.Type, p.ReservedPrice from auction a, item i, post p where a.AuctionID="
									+ request.getParameter("auctionid")
									+ " AND i.ItemID="
									+ request.getParameter("itemid")
									+ " AND p.AuctionID="
									+ request.getParameter("auctionid") + "");

					while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString("AuctionID")%></td>
			<td><%=rs.getString("BidIncrement")%></td>
			<td><%=rs.getString("MinimuBid")%></td>
			<td><%=rs.getString("Copies_Sold")%></td>
			<td><%=rs.getString("monitor")%></td>
			<td><%=rs.getString("ItemID")%></td>
			<td><%=rs.getString("Name")%></td>
			<td><%=rs.getString("Description")%></td>
			<td><%=rs.getString("Type")%></td>
			<td><%=rs.getString("ReservedPrice")%></td>
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
	<form name="myForm" action="Place_Bid_Transaction.jsp" method="post">


		<span style="font-size: 10pt"><strong>Bid Price:</strong></span><br />
		<input name="BidPrice"
			style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />
		<span style="font-size: 10pt"><strong>Maximum Bid:</strong></span><br />
		<input name="MaximumBid"
			style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />
		<input type="hidden" name="auctionid" value="<%=request.getParameter("auctionid")%>">
		<input type="hidden" name="itemid" value="<%=request.getParameter("itemid")%>">	
		<input id="Button2" type="button" value="Go"
			onclick="return Button1_onclick()" />
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













