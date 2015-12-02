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
              if(rs.getInt("Level") != 1){
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
    <title>Manager Level Transaction - Best Sellers List of Items</title>
    <%@include file="include/head_include.html"%>
</head>
<body style="text-align: center" bgcolor="#ffffff">
<%@include file="include/nav.html"%>
<h1>Best Sellers List of Items</h1>
<a href="EmployeeInformation.jsp">Employee Home Page</a> 

<br/>
<br/>
    <span style="font-size: 14pt; font-family: Arial"><strong>Hello, Manager. Your Email is
        <%=session.getValue("login")%>. Your ID is <%=session.getValue("employeeID")%> .<br />
        <br />
    </span>

   
       <div class="table-responsive">
          <table class="table table-striped">
          
            <tr>
              <td>SSN</td>
              <td>First Name</td>
              <td>Last Name</td>
              <td>Item Name</td>
              <td>Description</td>
              <td>Type</td>
            </tr>

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
        
            java.sql.ResultSet rs = stmt1.executeQuery("SELECT DISTINCT pe.FirstName, pe.LastName, pe.SSN, i.Name, i.Description, i.Type from item i , customer c, post p, auction a , person pe WHERE p.CustomerID in (SELECT c.CustomerID from customer c where c.Rating >= (SELECT Rating  FROM customer GROUP BY customer.CustomerID ORDER BY Rating DESC LIMIT 1)) AND p.AuctionID = a.AuctionID AND a.ItemID = i.ItemID and pe.SSN = p.CustomerID");
        

            while(rs.next()){
        %>
              <tr>
                <td><%=rs.getString("SSN")%></td>
                <td><%=rs.getString("FirstName")%></td>
                <td><%=rs.getString("LastName")%></td>
                <td><%=rs.getString("Name")%></td>
                <td><%=rs.getString("Description")%></td>
                <td><%=rs.getString("Type")%></td>
                
                
              </tr>

         
        <%

            }// while

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
    <%@include file="include/end_js_include.html"%>
</body>
</html>