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
    <title>Manager Level Transaction - Obtain A Sales Report For a particular Month</title>
    <%@include file="include/head_include.html"%>
    <script language="javascript" type="text/javascript">
        // <!CDATA[
        function Button1_onclick() {
          if(document.myForm.year.value == "")
          alert("Your year must not be empty!!!")
          else if(document.myForm.month.value == "")
          alert("Your month must not be empty!!!")
          
          else{document.myForm.submit()}
        }
    </script>
</head>
<body style="text-align: center" bgcolor="#ffffff">
<%@include file="include/nav.html"%>
<h1>Obtain A Sales Report For a particular Month</h1>
<a href="EmployeeInformation.jsp">Employee Home Page</a> 

<br/>
<br/>
    <span style="font-size: 14pt; font-family: Arial"><strong>Hello, Manager. Your Email is
        <%=session.getValue("login")%>. Your ID is <%=session.getValue("employeeID")%> .<br />
        <br />
    </span>

    <form name="myForm" action="manager_sales_report.jsp" method="post">
      <input type="hidden" name="target" value="update">
 
      <span style="font-size: 10pt"><strong> <br />Year:<br /></strong></span>
      <select name="year">
        <option value="2015">2015</option>
        <option value="2014">2014</option>
        <option value="2013">2013</option>
        <option value="2012">2012</option>
      </select><br/>


      <span style="font-size: 10pt"><strong> <br />Month:<br /></strong></span>
      <select name="month">
        <option value="01">01</option>
        <option value="02">02</option>
        <option value="03">03</option>
        <option value="04">04</option>
        <option value="05">05</option>
        <option value="06">06</option>
        <option value="07">07</option>
        <option value="08">08</option>
        <option value="09">09</option>
        <option value="10">10</option>
        <option value="11">11</option>
        <option value="12">12</option>
        
      </select><br/>


      <input id="Button2" type="button" value="Go"  onclick="return Button1_onclick()" />
    </form><br/>
        <%
          if(request.getParameter("year") != null && request.getParameter("month") != null){
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
        
            java.sql.ResultSet rs = stmt1.executeQuery("SELECT p.FirstName as BuyerFirstName, p.LastName as BuyerLastName, p2.FirstName as SellerFirstName, p2.Lastname as SellerLastName , i.Name as ItemName, s.Price as Price, s.Date as Date FROM  sales s, person p, person p2 , item i WHERE Month(Date) = '"+request.getParameter("month")+"' and Year(Date)= '"+request.getParameter("year")+"' and s.BuyerID = p.SSN and s.ItemID = i.itemID and s.SellerID = p2.SSN");
        

            while(rs.next()){
        %>
              <tr>
                <td><%=rs.getString("BuyerFirstName")%></td>
                <td><%=rs.getString("BuyerLastName")%></td>
                <td><%=rs.getString("SellerFirstName")%></td>
                <td><%=rs.getString("SellerLastName")%></td>
                <td><%=rs.getString("ItemName")%></td>
                <td><%=rs.getString("Price")%></td>
                <td><%=rs.getString("DATE")%></td>
              
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