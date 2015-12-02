<%

if(session.getValue("login")==null ){
  response.sendRedirect("index.htm");
}
		String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
		String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu/sikwong"; 
		String mysUserID = "sikwong"; 
		String mysPassword = "108620515";
/*    	
	if ((username!=null) &&(userpasswd!=null))
	{
		if (username.trim().equals("") || userpasswd.trim().equals(""))
		{
			response.sendRedirect("index.htm");
		}
		else
		{
*/
			// code start here
			java.sql.Connection conn=null;
			try 
			{
            	Class.forName(mysJDBCDriver).newInstance();
    			java.util.Properties sysprops=System.getProperties();
    			sysprops.put("user",mysUserID);
    			sysprops.put("password",mysPassword);
        
				//connect to the database
    			conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
    			System.out.println("Connected successfully to database using JConnect");
    
    			java.sql.Statement stmt1=conn.createStatement();
	            if (request.getParameter("target").trim().equals("update")){
	            	String Rating = request.getParameter("Rating");
					String creditcardnum = request.getParameter("creditcardnum");
					
					String firstName = request.getParameter("firstName");
					String lastName = request.getParameter("lastName");
					String address = request.getParameter("address");
					String zipCode = request.getParameter("zipCode");
					String phone = request.getParameter("telephone");
					String email = request.getParameter("email");
					String ssn = request.getParameter("ssn");

					stmt1.executeUpdate("UPDATE `customer` SET `Rating` = "+Rating+" , `creditcardnum` = "+creditcardnum+" WHERE  `CustomerID`="+ssn+";");

					stmt1.executeUpdate("UPDATE `person` SET `LastName` = '"+lastName+"' , `FirstName`= '"+firstName+"', `Address`='"+address+"' , `ZipCode` ="+zipCode+", `telephone`="+phone+", `email`='"+email+"'  WHERE  `SSN`="+ssn+";");
					
					
					stmt1.close();
				}else if(request.getParameter("target").trim().equals("delete")) {
					String ssn = request.getParameter("ssn");
					stmt1.executeUpdate("DELETE FROM `customer` WHERE  `CustomerID`="+ssn+";");
                                        stmt1.executeUpdate("DELETE FROM `person` WHERE  `SSN`="+ssn+";");
					/*stmt1.executeUpdate("INSERT INTO `person` (`SSN`, `LastName`, `FirstName`, `Address`, `ZipCode`, `telephone`, `email`, `password`) VALUES (					'"+ssn+"' ,					'"+lastName+"', 					'"+firstName+"', 					'"+address+"', 					"+zipCode+", 					"+phone+", 					'"+email+"',					'"+Password1+"'		);");

					stmt1.executeUpdate("INSERT INTO `customer` ( `CustomerID` , `creditcardnum`) VALUES ('"+ssn+"' , '"+creditCardNumber+"');");
					*/
					stmt1.close();
				}else if(request.getParameter("target").trim().equals("add")) {
					String Rating = request.getParameter("Rating");
					String creditcardnum = request.getParameter("creditcardnum");
			
					String Password1 = request.getParameter("Password1");
					String firstName = request.getParameter("firstName");
					String lastName = request.getParameter("lastName");
					String address = request.getParameter("address");
					String zipCode = request.getParameter("zipCode");
					String phone = request.getParameter("telephone");
					String email = request.getParameter("email");
					String ssn = request.getParameter("ssn");

					stmt1.executeUpdate("INSERT INTO `person` (`SSN`, `LastName`, `FirstName`, `Address`, `ZipCode`, `telephone`, `email`, `password`) VALUES (					'"+ssn+"' ,					'"+lastName+"', 					'"+firstName+"', 					'"+address+"', 					"+zipCode+", 					"+phone+", 					'"+email+"',					'"+Password1+"'					);");
					//DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					//Date date = new Date();
					//System.out.println(dateFormat.format(date)); //2014/08/06 15:59:48
					stmt1.executeUpdate("INSERT INTO `customer` ( `CustomerID`,`Rating`,`creditcardnum`) VALUES ("+ssn+", "+Rating+","+creditcardnum+");");
					/*stmt1.executeUpdate("INSERT INTO `person` (`SSN`, `LastName`, `FirstName`, `Address`, `ZipCode`, `telephone`, `email`, `password`) VALUES (					'"+ssn+"' ,					'"+lastName+"', 					'"+firstName+"', 					'"+address+"', 					"+zipCode+", 					"+phone+", 					'"+email+"',					'"+Password1+"'		);");

					stmt1.executeUpdate("INSERT INTO `customer` ( `CustomerID` , `creditcardnum`) VALUES ('"+ssn+"' , '"+creditCardNumber+"');");
					*/
					stmt1.close();
				} 
			}catch(Exception e){
				e.printStackTrace();
				out.print(e.toString());
			}finally{
			
				try{conn.close();
                                }catch(Exception ee){};
			}
/*
	}
*/
%>

Successful executed!
<a href="CustomerR_edit.jsp"><font color="Blue">Customer-Representative Page</font></a>
