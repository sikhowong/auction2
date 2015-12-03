
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Manager Level Transaction - List of sales by item name or
	customer Name</title>
	<%@include file="include/head_include.html"%>
<script language="javascript" type="text/javascript">
	// <!CDATA[
	function Button1_onclick() {
		if (document.myForm.itemName.value == "")
			alert("Your Item Name must not be empty!!!")
		else {
			document.myForm.submit()
		}
	}

	function Button2_onclick() {
		if (document.myForm2.itemType.value == "")
			alert("Your Item Type must not be empty!!!")
		else {
			document.myForm2.submit()
		}
	}
	function Button3_onclick() {
		if (document.myForm2.itemID.value == "")
			alert("Your Item ID must not be empty!!!")
		else {
			document.myForm2.submit()
		}
	}
</script>
</head>
<body style="text-align: center" bgcolor="#ffffff">
<%@include file="include/nav_customer.html"%>
	<h1>
		List of sales by
		<%=request.getParameter("by")%></h1>
	<a href="CustomerInformation.jsp">Customer Home Page</a>

	<br />
	<br />
	<span style="font-size: 14pt; font-family: Arial"><strong>Hello,
			Customer. Your Email is <%=session.getValue("login")%>. Your ID is <%=session.getValue("customerID")%>
			.<br /></span>
	<a href ="Buy_Item.jsp?by=Name"	>By Name </a><a href ="Buy_Item.jsp?by=Type">By Name </a><a href ="Buy_Item.jsp?by=Type">By Name </a>
	<br /><br />
	<%
		if (request.getParameter("by").trim().equals("Name")) {
	%>
	<form name="myForm" action="Buy_Item.jsp?by=Name" method="post">


		<span style="font-size: 10pt"><strong>Item Name:<br />
				<input name="itemName"
				style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />


				<input id="Button1" type="button" value="Go"
				onclick="return Button1_onclick()" />
	</form>
	<br />
	<%
		} else if (request.getParameter("by").trim().equals("Type")) {
	%>
	<form name="myForm2" action="Buy_Item.jsp?by=Type" method="post">


		<span style="font-size: 10pt"><strong>Item Type:<br />
				<input name="itemType"
				style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />

				<input id="Button2" type="button" value="Go"
				onclick="return Button2_onclick()" />
	</form>
	<br />

	<%
		} else if (request.getParameter("by").trim().equals("ItemID")) {
	%>
	<form name="myForm2" action="Buy_Item.jsp?by=ItemID" method="post">


		<span style="font-size: 10pt"><strong>Item ID:<br />
				<input name="itemID"
				style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />

				<input id="Button3" type="button" value="Go"
				onclick="return Button3_onclick()" />
	</form>
	<br />

	<%
		}//end of if
	%>
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
			if (request.getParameter("by").trim().equals("Name")) {
				if (request.getParameter("itemName") != null) {

					java.sql.ResultSet rs = stmt1
							.executeQuery("select a.AuctionID, a.BidIncrement, a.MinimuBid, a.Copies_Sold, a.monitor, a.ItemID, i.Name, i.Description, i.Type from auction a, item i where a.ItemID = (select ItemID from item where name like '%"
									+ request.getParameter("itemName")
									+ "%') and a.ItemID = i.ItemID");
	%>
	<table border="1">
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
			<td>Place Bid</td>

		</tr>
		<%
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
			<td><a
				href="Place_Bid.jsp?type=Bid&auctionid=<%=rs.getString("AuctionID")%>&itemid=<%=rs.getString("ItemID")%>">Place
					Bid</a></td>

		</tr>


		<%
			}// while
		%>
	</table>
	<%
		}
			}//if
			else if (request.getParameter("by").trim().equals("Type")) {
				if (request.getParameter("itemType") != null) {

					java.sql.ResultSet rs = stmt1
							.executeQuery("select a.AuctionID, a.BidIncrement, a.MinimuBid, a.Copies_Sold, a.monitor, a.ItemID, i.Name, i.Description, i.Type from auction a, item i where a.ItemID IN (select ItemID from item where Type = '"
									+ request.getParameter("itemType")
									+ "') and a.ItemID = i.ItemID");
	%>
	<table border="1">
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
			<td>Place Bid</td>

		</tr>
		<%
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
			<td><a
				href="Place_Bid.jsp?type=Bid&auctionid=<%=rs.getString("AuctionID")%>&itemid=<%=rs.getString("ItemID")%>">Place
					Bid</a></td>

		</tr>


		<%
			}// while
					}//end if form is null
				} else if (request.getParameter("by").trim().equals("ItemID")) {
					if (request.getParameter("itemID") != null) {

						java.sql.ResultSet rs = stmt1
								.executeQuery("select a.AuctionID, a.BidIncrement, a.MinimuBid, a.Copies_Sold, a.monitor, a.ItemID, i.Name, i.Description, i.Type from auction a, item i where a.ItemID = "
										+ request.getParameter("itemID")
										+ " AND i.ItemID = "
										+ request.getParameter("itemID") + "");
		%>
		<table border="1">
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
				<td>Place Bid</td>

			</tr>
			<%
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
				<td><a
					href="Place_Bid.jsp?type=Bid&auctionid=<%=rs.getString("AuctionID")%>&itemid=<%=rs.getString("ItemID")%>">Place
						Bid</a></td>

			</tr>


			<%
				}// while
						}//end if form is null
					}
			%>
		</table>
		<%
			
		%>




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
		</td>

		</tr>
	</table>
	</strong>
	<%@include file="include/end_js_include.html"%>
</body>
</html>