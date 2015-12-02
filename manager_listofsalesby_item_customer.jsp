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
    <title>Manager Level Transaction - List of sales by item name or customer Name </title>
    <%@include file="include/head_include.html"%>
    <script language="javascript" type="text/javascript">
        // <!CDATA[
        function Button1_onclick() {
          if(document.myForm.itemName.value == "")
          alert("Your item name must not be empty!!!")
          
          else{document.myForm.submit()}
        }

        function Button2_onclick() {
            if(document.myForm2.customerFirstName.value == "")
            alert("Your customer first name must not be empty!!!")
            else if(document.myForm2.customerLastName.value == "")
            alert("Your customer last name must not be empty!!!")
            else{document.myForm2.submit()}
          }
    </script>
</head>
<body style="text-align: center" bgcolor="#ffffff">
<%@include file="include/nav.html"%>
<h1>List of sales by <%=request.getParameter("by")%></h1>
<a href="EmployeeInformation.jsp">Employee Home Page</a> 

<br/>
<br/>
    <span style="font-size: 14pt; font-family: Arial"><strong>Hello, Manager. Your Email is
        <%=session.getValue("login")%>. Your ID is <%=session.getValue("employeeID")%> .<br />
        <br />
    </span>
        <% 
          if(request.getParameter("by").trim().equals("item")){
        %>
            <form name="myForm" action="manager_listofsalesby_item_customer.jsp?by=item" method="post">
              
         
              <span style="font-size: 10pt"><strong>Item Name:<br />
              <input name="itemName" style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />


              <input id="Button2" type="button" value="Go"  onclick="return Button1_onclick()" />
            </form><br/>
        <%
          }else if(request.getParameter("by").trim().equals("customer")){
        %>
            <form name="myForm2" action="manager_listofsalesby_item_customer.jsp?by=customer" method="post">
                
           
              <span style="font-size: 10pt"><strong>Customer first Name:<br />
              <input name="customerFirstName" style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />

              <span style="font-size: 10pt"><strong>Customer last Name:<br />
              <input name="customerLastName" style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />

              <input id="Button2" type="button" value="Go"  onclick="return Button2_onclick()" />
            </form><br/>

        <%
          }//end if 

        %>
   
       
         
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
            if(request.getParameter("by").trim().equals("item")){
              if(request.getParameter("itemName") != null ){

                java.sql.ResultSet rs = stmt1.executeQuery("SELECT p.FirstName as BuyerFirstName, p.LastName as BuyerLastName, p2.FirstName as SellerFirstName, p2.Lastname as SellerLastName , i.Name as ItemName, s.Price as Price FROM sales s, person p, person p2, item i        WHERE s.ItemID IN (SELECT ItemID FROM item WHERE Name LIKE '%"+request.getParameter("itemName")+"%') and s.BuyerID = p.SSN and s.ItemID = i.itemID  and s.SellerID = p2.SSN");
            %>
                <div class="table-responsive">
                  <table class="table table-striped">
                  <tr>
                    <td>Buyer First Name</td>
                    <td>Buyer Last Name</td>
                    <td>Seller First Name</td>
                    <td>Seller Last Name</td>
                    <td>Item Name</td>
                    <td>Price</td>
                    
                  </tr>
            <%
                while(rs.next()){
            %>
                  <tr>
                    <td><%=rs.getString("BuyerFirstName")%></td>
                    <td><%=rs.getString("BuyerLastName")%></td>
                    <td><%=rs.getString("SellerFirstName")%></td>
                    <td><%=rs.getString("SellerLastName")%></td>
                    <td><%=rs.getString("ItemName")%></td>
                    <td><%=rs.getString("Price")%></td>
                    
                  </tr>

             
            <%

                }// while
            %>
                </table>
            <%    
              }
            }//if
            else if(request.getParameter("by").trim().equals("customer")){
              if(request.getParameter("customerFirstName") != null && request.getParameter("customerLastName") != null){
                java.sql.ResultSet rs = stmt1.executeQuery("SELECT p.FirstName as BuyerFirstName, p.LastName as BuyerLastName, p2.FirstName as SellerFirstName, p2.Lastname as SellerLastName , i.Name as ItemName, s.Price as Price FROM`sales`s, `person` p, `person` p2 , `item` i WHERE s.SellerID IN (SELECT SSN FROM `person` where FirstName LIKE '%"+request.getParameter("customerFirstName")+"%' or LastName LIKE '%"+request.getParameter("customerLastName")+"%') AND s.BuyerID = p.SSN and s.ItemID = i.itemID and s.SellerID = p2.SSN");
            %>
                <div class="table-responsive">
                 <table class="table table-striped">
                  <tr>
                    <td>Buyer First Name</td>
                    <td>Buyer Last Name</td>
                    <td>Seller First Name</td>
                    <td>Seller Last Name</td>
                    <td>Item Name</td>
                    <td>Price</td>
                    
                  </tr>
            <%
                while(rs.next()){
            %>
                  <tr>
                    <td><%=rs.getString("BuyerFirstName")%></td>
                    <td><%=rs.getString("BuyerLastName")%></td>
                    <td><%=rs.getString("SellerFirstName")%></td>
                    <td><%=rs.getString("SellerLastName")%></td>
                    <td><%=rs.getString("ItemName")%></td>
                    <td><%=rs.getString("Price")%></td>
                    
                  </tr>

             
            <%

                }// while
            %>
                </table>
            <%    

              }//end if form is null
            }// end if url parameter

        %>


        

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