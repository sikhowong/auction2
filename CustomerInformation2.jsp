  
<%

if(session.getValue("login")==null ){
  response.sendRedirect("index.htm");
}
//int empID = session.getValue("employeeID");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Customer Information -- Online System</title>

</head>
<body style="text-align: center" bgcolor="#ffffff">
    <span style="font-size: 14pt; font-family: Arial"><strong>Hello, Your Email is
        <%=session.getValue("login")%>. You ID is <%=session.getValue("customerID")%> Here is Your Customer Information.<br />
        <br />

        <%
      

        %>
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
            <tr>
                <td style="vertical-align: top; width: 11237px; text-align: left; height: 454px;">
                    <span style="font-size: 10pt">
                    This is the table for the courses in which you enrolled.<br />
                    You can delete the ones which do not have a grade.<br />
                        And you can search new courses by click the "Search" button below.<br />
                        You may engage in at most 10 courses.<br />
                    </span><br />
                    <table border="8" id="TABLE1" onclick="return TABLE1_onclick()">
                    <tr>
                      <td style="width: 84px">
                          <span style="font-size: 10pt">
                          Course Code</span></td>
                      <td style="width: 187px">
                          <span style="font-size: 10pt">Course Name</span></td>
                        <td style="width: 74px">
                            <span style="font-size: 10pt">Department</span></td>
                        <td>
                            <span style="font-size: 10pt">Professor</span></td>
                        <td style="width: 7px">
                            <span style="font-size: 10pt">Grade</span></td>
                        <td style="width: 7px">
                            <span style="font-size: 10pt">Oper</span></td>
                    </tr>   
<%
/*
		String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
		String mysURL = "jdbc:mysql://sbcstldb.cs.stonybrook.edu:3306/cse305ta"; 
		String mysUserID = "cse305ta"; 
		String mysPassword = "107724115";
        
        String stuId = ""+session.getValue("login");
  			java.sql.Connection conn=null;
			try 
			{
            	Class.forName(mysJDBCDriver).newInstance();
    			java.util.Properties sysprops=System.getProperties();
    			sysprops.put("user",mysUserID);
    			sysprops.put("password",mysPassword);
        
				//connect to the database
            			conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
            			System.out.println("Connected successfully to database using JConnect");
            
            			java.sql.Statement stmt1=conn.createStatement();
        
					java.sql.ResultSet rs = stmt1.executeQuery("select Course.CrsCode,Course.CrsName,Course.DeptID,Professor.Name,Transcript.Grade from Course, Professor,Transcript where Course.CrsCode=Transcript.CrsCode and Professor.Id=Course.InsNo and Transcript.StudId='"+stuId+"'");
      	  
      	  String strGrade;
      	       	  
      	  while(rs.next())
        	{
        		strGrade = rs.getString(5);
        		if(rs.getString(5).trim().equals("-1"))
      	  	{
      	  			strGrade = "N/A";
      	  	}
%>
                    <tr>
                      <td style="width: 84px">
                          <span style="font-size: 10pt"><%=rs.getString(1)%></span></td>
                      <td style="width: 187px">
                          <span style="font-size: 10pt"><%=rs.getString(2)%></span></td>
                        <td style="width: 74px">
                            <span style="font-size: 10pt"><%=rs.getString(3)%></span></td>
                        <td>
                            <span style="font-size: 10pt"><%=rs.getString(4)%></span></td>
                        <td style="width: 7px">
                            <span style="font-size: 10pt"><%=strGrade%></span></td>
                        <td>
                        	<% if (rs.getString(5).trim().equals("-1")) {%>
                        		<input type=button onclick="javascript:if (confirm('Are you sure that you want to delete the course?')==true){window.open('delcourse.jsp?userid=<%=stuId%>&crscode=<%=rs.getString(1)%>','_self');};return;" value="Delete">
                        	<%}%>
                        </td>
                        		
                    </tr>
<%      		
        	}
  			} catch(Exception e)
			{
				e.printStackTrace();
				out.print(e.toString());
			}
			finally{
			
				try{conn.close();}catch(Exception ee){};
			}
*/
  %>
  					</table>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <input id="Button1" type="button" value="Search Course" onclick="window.open('SearchCourse.htm','_self');" />
                    <input id="Button1" type="button" value="Logout" onclick="window.open('index.htm','_self');" /><br />
                    <span style="font-size: 8pt">
                        <br />
                 DSY</span></td>
              
            </tr>
        </table>
    </strong></span>

</body>
</html>
