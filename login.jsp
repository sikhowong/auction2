<%
	if((request.getParameter("action")!=null)&&	(request.getParameter("action").trim().equals("logout")))
	{
		session.putValue("login","");
		response.sendRedirect("/");
		return;
	}
		String username = request.getParameter("email");

		String userpasswd = request.getParameter("userpasswd");
     	String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
     	String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu/sikwong"; 
		String mysUserID = "sikwong"; 
		String mysPassword = "108620515";
    	
	session.putValue("login","");

	//username = email address
	if ((username!=null) &&(userpasswd!=null))
	{
		if (username.trim().equals("") || userpasswd.trim().equals(""))
		{
			response.sendRedirect("index.htm");
		}
		else
		{
			// code start here
			java.sql.Connection conn=null;
			try {
	            	Class.forName(mysJDBCDriver).newInstance();
        			java.util.Properties sysprops=System.getProperties();
        			sysprops.put("user",mysUserID);
        			sysprops.put("password",mysPassword);
    
			//connect to the database
        			conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
        			System.out.println("-login.jsp Connected successfully to database using JConnect");
        
        			conn.setAutoCommit(false);
        			java.sql.Statement stmt1=conn.createStatement();
					java.sql.ResultSet rs = stmt1.executeQuery(" select * from person where email='"+username+"' and password='"+userpasswd+"'");
					
					if(rs.next()) {
						int tempSSN = rs.getInt("SSN");
						System.out.println(rs.getInt("SSN"));
						java.sql.ResultSet rs1 = stmt1.executeQuery(" select * from customer where CustomerID ="+rs.getInt("SSN"));
						
					
					
						if (rs1.next())
						{
							// login success
							session.putValue("login",username);
							session.putValue("customerID",rs1.getInt("CustomerID"));
							response.sendRedirect("CustomerInformation.jsp");
						}
						else
						{
							rs = stmt1.executeQuery(" select * from Employee where EmployeeID ="+tempSSN);
							if(rs.next())
							{
								session.putValue("login", username);
								session.putValue("employeeID",rs.getInt("EmployeeID"));
								response.sendRedirect("EmployeeInformation.jsp");
							}
								
							else
							{
								// username or password mistake
								response.sendRedirect("passMistake.jsp");
							}
						}
					}else{
						response.sendRedirect("passMistake.jsp");
					}
			} catch(Exception e)
			{
				e.printStackTrace();
			}
			finally{
				try{conn.close();}catch(Exception ee){};
			}
		}
	}
%>