<%
if(session.getValue("login")==null ){
  response.sendRedirect("index.htm");
}

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
			System.out.println("Connected successfully to database using JConnect");
			java.sql.Statement stmt1 = conn.createStatement();
			java.sql.ResultSet rs = stmt1.executeQuery("select EmployeeID from employee");
			rs.next();
			String BidIncrement = request.getParameter("BidIncrement");
			String MinimuBid = request.getParameter("MinimuBid");
			String Copies_Sold = request.getParameter("Copies_Sold");
			String EmployeeID = rs.getString("EmployeeID");
			String ItemID = request.getParameter("ItemID");
			String reserveprice = request.getParameter("reserveprice");
			String ExpireDate = request.getParameter("ExpireDate");
		
			stmt1.executeUpdate("INSERT INTO auction (BidIncrement, MinimuBid,Copies_Sold,Monitor,ItemID) VALUES("
					+ BidIncrement
					+ ","
					+ MinimuBid
					+ ","
					+ Copies_Sold
					+ "," + EmployeeID + "," + ItemID + ")");

			rs = stmt1.executeQuery("SELECT LAST_INSERT_ID() as id; ");
			rs.next();
			stmt1.executeUpdate("INSERT INTO post(CustomerID,ExpireDate,PostDate,ReservedPrice, AuctionID) VALUES("
					+ session.getValue("customerID")
					+ ",NOW() + INTERVAL "
					+ ExpireDate + " DAY , NOW()," + reserveprice + ", " + rs.getInt("id") +" )");

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
Successful executed!
<a href="CustomerInformation.jsp"><font color="Blue">Home Page</font></a>