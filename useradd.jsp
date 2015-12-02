<%
		//String userName = request.getParameter("userName");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String Password1 = request.getParameter("Password1");
		String address = request.getParameter("address");
		
		String zipCode = request.getParameter("zipCode");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String ssn = request.getParameter("ssn");

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
	            if (request.getParameter("target").trim().equals("employee")){
	            	// insert also the id and password received from the user
	            	//System.out.println(email);
					stmt1.executeUpdate("INSERT INTO `person` (`SSN`, `LastName`, `FirstName`, `Address`, `ZipCode`, `telephone`, `email`, `password`) VALUES (					'"+ssn+"' ,					'"+lastName+"', 					'"+firstName+"', 					'"+address+"', 					"+zipCode+", 					"+phone+", 					'"+email+"',					'"+Password1+"'					);");
					//DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					//Date date = new Date();
					//System.out.println(dateFormat.format(date)); //2014/08/06 15:59:48
					stmt1.executeUpdate("INSERT INTO `employee` ( `EmployeeID`,`level`,	`StartDate`) VALUES ('"+ssn+"', 0,NOW());");
					//stmt1.executeUpdate("insert into person values('"+Id+"','"+Password1+"','"+Name+"','"+request.getParameter("status")+"')");
	//							out.print("insert into Student values('"+Id+"','"+Password1+"','"+Name+"','"+request.getParameter("status")+"')");
					stmt1.close();
				}else{
					String creditCardNumber = request.getParameter("creditCardNumber");
					// insert also the id and password received from the user
					//stmt1.executeUpdate("insert into Professor values('"+Id+"','"+Password1+"','"+Name+"','"+request.getParameter("DepID")+"')");
	//							out.print("insert into Professor values('"+Id+"','"+Password1+"','"+Name+"','"+request.getParameter("DepID")+"')");;


					stmt1.executeUpdate("INSERT INTO `person` (`SSN`, `LastName`, `FirstName`, `Address`, `ZipCode`, `telephone`, `email`, `password`) VALUES (					'"+ssn+"' ,					'"+lastName+"', 					'"+firstName+"', 					'"+address+"', 					"+zipCode+", 					"+phone+", 					'"+email+"',					'"+Password1+"'		);");

					stmt1.executeUpdate("INSERT INTO `customer` ( `CustomerID` , `creditcardnum`) VALUES ('"+ssn+"' , '"+creditCardNumber+"');");
					//stmt1.executeUpdate("INSERT INTO `person` (`SSN`, `LastName`, `FirstName`, `Address`, `ZipCode`, `telephone`, `email`) VALUES ('123' , 'sik wong', 'wong', 'sds', 24324314, 123242323, 'sdsafasdfsdfdf@gmail.com');");
					stmt1.close();
				}
			}catch(Exception e){
				e.printStackTrace();
				out.print(e.toString());
			}finally{
			
				try{conn.close();}catch(Exception ee){};
			}
/*
	}
*/
%>

User Added!
<a href="index.htm"><font color="Blue">Home</font></a>