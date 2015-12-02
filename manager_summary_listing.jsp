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
    <title>Manager Level Transaction - Summary Listing of Revenue Generated </title>
    <%@include file="include/head_include.html"%>
    <script language="javascript" type="text/javascript">
   

        function Button1_onclick() {
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
<h1>Summary Listing of Revenue Generated by Particular <%=request.getParameter("by")%></h1>
<a href="EmployeeInformation.jsp">Employee Home Page</a> 

<br/>
<br/>
    <span style="font-size: 14pt; font-family: Arial"><strong>Hello, Manager. Your Email is
        <%=session.getValue("login")%>. Your ID is <%=session.getValue("employeeID")%> .<br />
        <br />
    </span>
        <%
          if(request.getParameter("by").trim().equals("customer")){
        %>
            <form name="myForm2" action="manager_summary_listing.jsp?by=customer" method="post">
                
           
              <span style="font-size: 10pt"><strong>Customer first Name:<br />
              <input name="customerFirstName" style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />

              <span style="font-size: 10pt"><strong>Customer last Name:<br />
              <input name="customerLastName" style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />

              <input id="Button2" type="button" value="Go"  onclick="return Button1_onclick()" />
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
              

                java.sql.ResultSet rs = stmt1.executeQuery("SELECT i.Name as ItemName, sum(s.Price) as Price FROM `sales` s, `item` i WHERE i.ItemID = s.ItemID GROUP BY s.ItemID");
            %>
                <div class="table-responsive">
                  <table class="table table-striped">
                  <tr>
                    <td>Item Name</td>
                    <td>Price</td>
                    
                  </tr>
            <%
                while(rs.next()){
            %>
                  <tr>
                    <td><%=rs.getString("ItemName")%></td>
                    <td><%=rs.getString("Price")%></td>
                    
                  </tr>

             
            <%

                }// while
            %>
                </table>
            <%    
              
            }//if
            else if(request.getParameter("by").trim().equals("type")){
             
                java.sql.ResultSet rs = stmt1.executeQuery("SELECT i.Type as Type, sum(s.Price) as Price FROM `item` i , `sales` s WHERE s.ItemID =i.ItemID GROUP BY i.Type");
            %>
                <div class="table-responsive">
                  <table class="table table-striped">
                  <tr>
                    <td>Type</td>
                    <td>Price</td>
                    
                  </tr>
            <%
                while(rs.next()){
            %>
                  <tr>
                    <td><%=rs.getString("Type")%></td>
                    <td><%=rs.getString("Price")%></td>
                    
                  </tr>

             
            <%

                }// while
            %>
                </table>
            <%    

              
            }// end if url parameter
            else if(request.getParameter("by").trim().equals("customer")){

              if(request.getParameter("customerFirstName") != null && request.getParameter("customerLastName") != null){
                java.sql.ResultSet rs = stmt1.executeQuery("SELECT p.SSN as SellerID, p.FirstName as SellerFirstName , p.LastName as SellerLastName, sum(s.Price) as Price FROM `sales` s , `person` p where s.SellerID = p.SSN AND p.FirstName LIKE '%"+request.getParameter("customerFirstName")+"%' and p.LastName LIKE '%"+request.getParameter("customerLastName")+"%'");
            %>
                <div class="table-responsive">
                  <table class="table table-striped">
                  <tr>
                    <td>Seller ID</td>
                    <td>Seller First Name</td>
                    <td>Seller Last Name</td>
                    <td>Price</td>
                    
                  </tr>
            <%
                while(rs.next()){
            %>
                  <tr>
                    <td><%=rs.getString("SellerID")%></td>
                    <td><%=rs.getString("SellerFirstName")%></td>
                    <td><%=rs.getString("SellerLastName")%></td>
                    <td><%=rs.getString("Price")%></td>
                    
                  </tr>

             
            <%

                }// while
            %>
                </table>
            <%    

              }//end if form is null
            }// en
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