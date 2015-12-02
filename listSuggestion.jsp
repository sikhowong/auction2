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
    <title>Customer-Representative Level Transaction - Item suggestions for a customer</title>
    <%@include file="include/head_include.html"%>
    <script language="javascript" type="text/javascript">
        // <!CDATA[
        
        function Button_onclick() {
            if(document.myForm.customerID.value == "")
            alert("Your customer ID must not be empty!!!")
            
            else{document.myForm.submit()}
          }
    </script>
</head>
<body style="text-align: center" bgcolor="#ffffff">
<%@include file="include/nav_cr.html"%>
<a href="EmployeeInformation.jsp">Employee Home Page</a> 

<br/>
<br/>
    <span style="font-size: 14pt; font-family: Arial"><strong>Hello, Customer-Representative. Your Email is
        <%=session.getValue("login")%>. Your ID is <%=session.getValue("employeeID")%> .<br />
        <br />
    </span>
        
       
            <form name="myForm" action="listSuggestion.jsp" method="post">
                
           
              <span style="font-size: 10pt"><strong>CustomerID:<br />
              <input name="customerID" style="font-weight: bold; font-size: 10pt; width: 145px" type="text" /><br />

              <input id="Button2" type="button" value="Go"  onclick="return Button_onclick()" />
            </form><br/>

        
   
       
         
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
            //if
            
            if(request.getParameter("customerID") != null ){
                java.sql.ResultSet rs = stmt1.executeQuery("SELECT DISTINCT i.Name as ItemName, i.Type FROM sales s, item i,customer c  WHERE i.type IN (SELECT i.Type FROM item i,sales s  WHERE i.ItemID=s.ItemID and s.BuyerID=c.CustomerID  GROUP BY s.ItemID) and c.CustomerID="+request.getParameter("customerID"));

            %>
            <div class="table-responsive">
              <table class="table table-striped">
                  <tr>
                    <td>Item Name</td>
                    <td>Item Type</td>
                   
                  </tr>
            <%
                if(!rs.isBeforeFirst()){
                    %>
                    <font color="red" size="20">No suggestion available!</font>
            <%
                }
                else{
                    while(rs.next()){
            %>
                    <tr>
                        <td><%=rs.getString("ItemName")%></td>
                        <td><%=rs.getString("Type")%></td>
                    
                    </tr>

             
            <%

                    }// while
                }
            %>
                </table>
            <%    

              }//end if form is null
           

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