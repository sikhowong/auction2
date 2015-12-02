<%

  
          String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
          String mysURL = "jdbc:mysql://mysql9.000webhost.com/a2316709_chat"; 
          String mysUserID = "a2316709_admin"; 
          String mysPassword = "123456";
          java.sql.Connection conn=null;
          try{
            Class.forName(mysJDBCDriver).newInstance();
            java.util.Properties sysprops=System.getProperties();
            sysprops.put("user",mysUserID);
            sysprops.put("password",mysPassword);
        
            //connect to the database
            conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
            System.out.println("chat- Connected successfully to database using JConnect");
      
            java.sql.Statement stmt1=conn.createStatement();
        
            java.sql.ResultSet rs = stmt1.executeQuery("select * from Post");
            while(rs.next()){
              System.out.println(rs.getString("Content"));
            }

          }catch(Exception e){
            e.printStackTrace();
            out.print(e.toString());
          }
          finally{
            try{conn.close();}catch(Exception ee){};
          }



%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Manager Level Transaction - Customer Representative Generated Most Total Revenue</title>
    
</head>
<body style="text-align: center" bgcolor="#ffffff">
<h1>Customer Representative Generated Most Total Revenue</h1>
<a href="EmployeeInformation.jsp">Employee Home Page</a> 

<br/>
<br/>
    <span style="font-size: 14pt; font-family: Arial"><strong>Hello, Manager. Your Email is
        <%=session.getValue("login")%>. Your ID is <%=session.getValue("employeeID")%> .<br />
        <br />
    </span>

   
       
          <table border="1">
            <tr>
              <td>SSN</td>
              <td>First Name</td>
              <td>Last Name</td>
              <td>Total Revenue</td>
              
            </tr>

          
        
      
                   
                    <br />
                    <br />
                    <br />
                    <input id="Button1" type="button" value="Logout" onclick="window.open('index.htm','_self');" /><br />
                    <span style="font-size: 8pt">
                        <br />
                        DSY</span></td>
               
            </tr>
        </table>
    </strong>
</body>
</html>