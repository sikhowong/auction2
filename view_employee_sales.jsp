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
    <title>Customer-Representative Level Transaction - View all sales</title>
    <%@include file="include/head_include.html"%>

</head>
<body style="text-align: center" bgcolor="#ffffff">
<%@include file="include/nav_cr.html"%>

<h1>Employee Information</h1>
<a href="EmployeeInformation.jsp">Employee Home Page</a> 

<br/>
<br/>
    <span style="font-size: 14pt; font-family: Arial"><strong>Hello, Customer-Representative. Your Email is
        <%=session.getValue("login")%>. Your ID is <%=session.getValue("employeeID")%> .Here is all the sales that you monitored.<br />
        <br />
    </span>

   
        
  <div class="table-responsive">
          <table class="table table-striped">
            <tr>
                
              <td>Buyer First Name</td>
              <td>Buyer Last Name</td>
              <td>Seller First Name</td>
              <td>Seller Last Name</td>
              <td>Item Name</td>
              <td>Item ID</td>
              <td>Price</td>
              <td>Date</td>

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
        
            java.sql.ResultSet rs = stmt1.executeQuery("SELECT  p.LastName as BuyerFirstName, p.FirstName as BuyerLastName,p2.FirstName as SellerFirstName, p2.Lastname as SellerLastName , i.Name as ItemName, i.ItemID as ItemID, s.Price as Price, s.Date as Date FROM person p,person p2,item i,auction a,sales s WHERE s.BuyerID = p.SSN and s.ItemID = i.itemID and s.SellerID = p2.SSN and a.auctionID=s.auctionID and a.Monitor="+session.getValue("employeeID"));
             
            if(!rs.isBeforeFirst()){
        %>
              <font color="red" size="20">No sales available!</font>
        <%
            }
            else{
                while(rs.next()){
        %>
                <tr>
                
                    <td><%=rs.getString("BuyerFirstName")%></td>
                    <td><%=rs.getString("BuyerLastName")%></td>
                    <td><%=rs.getString("SellerFirstName")%></td>
                    <td><%=rs.getString("SellerLastName")%></td>
                    <td><%=rs.getString("ItemName")%></td>
                    <td><%=rs.getString("ItemID")%></td>
                    <td><%=rs.getString("Price")%></td>
                    <td><%=rs.getString("Date")%></td>
               
              </tr>

         
        <%

                }// while
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
    <%@include file="include/end_js_include.html"%>

</body>
</html>