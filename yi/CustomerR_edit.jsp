<%
if (request.getProtocol().compareTo("HTTP/1.0")==0)
      response.setHeader("Pragma","no-cache");
if (request.getProtocol().compareTo("HTTP/1.1")==0)
      response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);

if(session.getValue("login")==null ){
  response.sendRedirect("index.htm");
}
  
          String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
          String mysURL = "jdbc:mysql://mysql2.cs.stonybrook.edu/sikwong"; 
          String mysUserID = "sikwong"; 
          String mysPassword = "108620515";
          java.sql.Connection conn=null;
          try{
            Class.forName(mysJDBCDriver).newInstance();
            java.util.Properties sysprops=System.getProperties();
            sysprops.put("user",mysUserID);
            sysprops.put("password",mysPassword);
        
            //connect to the database
            conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
            System.out.println("Connected successfully to database using JConnect");
      
            java.sql.Statement stmt1=conn.createStatement();
        
            java.sql.ResultSet rs = stmt1.executeQuery("select * from employee where EmployeeID='"+session.getValue("employeeID")+"'");
            while(rs.next()){
              if(rs.getInt("Level") != 0){
                //System.out.println("Manager");
                response.sendRedirect("index.htm");
              }
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
    <title>Customer-Representative Level Transaction</title>

</head>
<body style="text-align: center" bgcolor="#ffffff">
    <h1>Add, Edit, Delete Customer Information</h1>
    <a href="EmployeeInformation.jsp">Employee Home Page</a> 

    <br />
    <br />
    <span style="font-size: 14pt; font-family: Arial"><strong>Hello, Customer-representative. Your Email is
        <%=session.getValue("login")%>. Your ID is <%=session.getValue("employeeID")%>. Here is Customer Information.<br />
        <br />
    </span>
        <%
  
          
          
          try{
            Class.forName(mysJDBCDriver).newInstance();
            java.util.Properties sysprops=System.getProperties();
            sysprops.put("user",mysUserID);
            sysprops.put("password",mysPassword);
        
            //connect to the database
            conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
            System.out.println("Connected successfully to database using JConnect");
      
            java.sql.Statement stmt1=conn.createStatement();
        
            java.sql.ResultSet rs = stmt1.executeQuery("select p.SSN, p.firstName, p.lastName, c.Rating, c.creditcardnum  from customer c , person p where p.SSN = c.CustomerID ");
        %>
            <a href="CustomerInfo_edit.jsp?type=add">Add a Customer</a>

            <table border="1">
            <tr>
              <td>SSN</td>
              <td>First Name</td>
              <td>Last Name</td>
              <td>Rating</td>
              <td>creditcardnum</td>
              <td>Edit</td>
              <td>Delete</td>
            </tr>


        <%

            while(rs.next()){
        %>
              <tr>
                <td><%=rs.getInt("SSN")%></td>
                <td><%=rs.getString("firstName")%></td>
                <td><%=rs.getString("lastName")%></td>
                <td><%=rs.getInt("Rating")%></td>
                <td><%=rs.getBigDecimal("creditcardnum")%></td>
                <td><a href="CustomerInfo_edit.jsp?type=edit&id=<%=rs.getInt("SSN")%>">edit</a></td>
                <td><a href="CustomerInfo_edit.jsp?type=delete&id=<%=rs.getInt("SSN")%>">delete</a></td>
              </tr>

         
        <%

       

            }
        %>


        </table>

        <%
          }catch(Exception e){
            e.printStackTrace();
            out.print(e.toString());
          }
          finally{
            try{conn.close();}catch(Exception ee){};
          }



        %>
      

  					
                    
                   
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
