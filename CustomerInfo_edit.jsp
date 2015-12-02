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
    <title>Customer-Representative Level Transaction - <%=request.getParameter("type")%></title>
    <%@include file="include/head_include.html"%>
    <script language="javascript" type="text/javascript">
        // <!CDATA[
        function Button1_onclick() {
          if(document.myForm.Rating.value== "")
          alert("Rating must not be empty!!!")
          else if(document.myForm.creditcardnum.value == "")
          alert("Credit Card Number must not be empty!!!")

          else{document.myForm.submit()}
        }
        
        function Button2_onclick() {
          document.myForm.submit()
        }
        // ]]>

        function Button3_onclick() {
        //if(document.myForm.username.value == "")
        //    alert("UserName Can Not Be Null!")
            if(document.myForm.email.value == "")
            alert("Your Email must not be null!!!")
            else if(document.myForm.firstName.value == "")
            alert("Your Name must not be null!!!")
            else if(document.myForm.Password1.value == "")
            alert("Your Password must not be null!!!")
            else if(document.myForm.Password1.value != document.myForm.Password2.value)
            alert("The Two Passwords Should Be the SAME!!!")
            else if(document.myForm.lastName.value == "")
            alert("Last Name can't be null")
            else if(document.myForm.address.value == "")
            alert("address can't be null")
            else if(document.myForm.zipCode.value == "")
            alert("zipCode can't be null")
            else if(document.myForm.telephone.value == "")
            alert("phone can't be null")
            else if(document.myForm.ssn.value == "")
            alert("ssn can't be null")
            else if(document.myForm.Rating.value == "")
            alert("Rating can't be null")
            else if(document.myForm.creditcardnum.value == "")
            alert("Credit Card Number can't be null")
  
            else{document.myForm.submit()}        
        }
        
       
        </script>
</head>
<body style="text-align: center" bgcolor="#ffffff">
<%@include file="include/nav_cr.html"%>
    <span style="font-size: 14pt; font-family: Arial"><strong>Hello, Customer-Representative. Your Email is
        <%=session.getValue("login")%>. Your ID is <%=session.getValue("employeeID")%>.  Here is the Customer Information You want to update.<br />
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
        
            java.sql.ResultSet rs = stmt1.executeQuery("select * from customer , person where CustomerID ="+request.getParameter("id")+" and CustomerID = SSN");
        
            while(rs.next()){
              if(request.getParameter("type").equals("edit")){        
    %>
                <h1><%=request.getParameter("type")%> - SSN: <%=request.getParameter("id")%></h1>
                <form name="myForm" action="customer_edit_transaction.jsp" method="post">
                                <input type="hidden" name="target" value="update">
                           
                               

                                <span style="font-size: 10pt"><strong> <br />Rating:<br /></strong></span>
                                <input name="Rating" style="width: 145px" type="text" value="<%=rs.getInt("Rating")%>"/><br />

                                
                                <span style="font-size: 10pt"><strong>Credit Card Number:<br />
                                <input name="creditcardnum" style="width: 145px" type="text" value="<%=rs.getBigDecimal("creditcardnum")%>" /><br />
                                
      
                                
                                <span style="font-size: 10pt"><strong>SSN:<br />
                                <input name="ssn" style="width: 145px" type="text" value="<%=rs.getString("SSN")%>" /><br />
                                
                                <span style="font-size: 10pt"><strong>First name:<br />
                                <input name="firstName" style="width: 145px" type="text" value="<%=rs.getString("FirstName")%>" /><br />

                                <span style="font-size: 10pt"><strong>Last name:<br />
                                <input name="lastName" style="width: 145px" type="text" value="<%=rs.getString("LastName")%>" /><br />

                                <span style="font-size: 10pt"><strong>Address:<br />
                                <input name="address" style="width: 145px" type="text" value="<%=rs.getString("Address")%>" /><br />

                                <span style="font-size: 10pt"><strong>Zip Code:<br />
                                <input name="zipCode" style="width: 145px" type="text" value="<%=rs.getString("ZipCode")%>" /><br />

                                <span style="font-size: 10pt"><strong>Telephone:<br />
                                <input name="telephone" style="width: 145px" type="text" value="<%=rs.getString("telephone")%>" /><br />

                                <span style="font-size: 10pt"><strong>Email:<br />
                                <input name="email" style="width: 145px" type="text" value="<%=rs.getString("email")%>" /><br />

                                <input id="Button2" type="button" value="Update"  onclick="return Button1_onclick()" />
                     
                </form>
    <%      
              }else if(request.getParameter("type").equals("delete")){
    %>            <h1><%=request.getParameter("type")%> - SSN: <%=request.getParameter("id")%></h1>
                  <h2>Are you sure you want to delete SSN: <%=request.getParameter("id")%>?</h2>
                  <form name="myForm" action="customer_edit_transaction.jsp" method="post">
                    <input type="hidden" name="target" value="delete">
                    <input type="hidden" name="ssn" value="<%=rs.getString("SSN")%>">
                    <input id="Button2" type="button" value="Delete"  onclick="return Button2_onclick()" />
                    <input id="Button4" type="button" value="Cancel"  onclick="window.open('CustomerR_edit.jsp','_self');" />
                  </form>

    <%              

              }

            }
            if(request.getParameter("type").trim().equals("add")){
            %>
              <h1><%=request.getParameter("type")%></h1>
                <form name="myForm" action="customer_edit_transaction.jsp" method="post">
                                <input type="hidden" name="target" value="add">
                           
                               

                                <span style="font-size: 10pt"><strong> <br />Rating:<br /></strong></span>
                                <input name="Rating" style="width: 145px" type="text" /><br />

                                
                                <span style="font-size: 10pt"><strong>Credit Card Number:<br />
                                <input name="creditcardnum" style="width: 145px" type="text"  /><br />
                                
                               
                                
                                <span style="font-size: 10pt"><strong>SSN:<br />
                                <input name="ssn" style="width: 145px" type="text"  /><br />
                                
                                <span style="font-size: 10pt"><strong>First name:<br />
                                <input name="firstName" style="width: 145px" type="text"  /><br />

                                <span style="font-size: 10pt"><strong>Last name:<br />
                                <input name="lastName" style="width: 145px" type="text"  /><br />

                                <span style="font-size: 10pt"><strong>Address:<br />
                                <input name="address" style="width: 145px" type="text"  /><br />

                                <span style="font-size: 10pt"><strong>Zip Code:<br />
                                <input name="zipCode" style="width: 145px" type="text"  /><br />

                                <span style="font-size: 10pt"><strong>Telephone:<br />
                                <input name="telephone" style="width: 145px" type="text"  /><br />

                                <span style="font-size: 10pt"><strong>Email:<br />
                                <input name="email" style="width: 145px" type="text"  /><br />

                                <span style="font-size: 10pt"><strong> <br />PassWord:&nbsp;<br /></strong></span>
                                <input name="Password1" style="font-weight: bold; font-size: 10pt; width: 145px; left: 0px; position: relative; top: 0px;" type="password" /><br />

                                <span style="font-size: 10pt"><strong>ReEnterPassWord:<br /></strong></span>
                                <input id="Password2" style="font-weight: bold; font-size: 10pt; width: 145px" type="password" /><br />
                        
                                <input id="Button2" type="button" value="Add"  onclick="return Button3_onclick()" />
                     
                </form>      

            <%

            }
        
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
