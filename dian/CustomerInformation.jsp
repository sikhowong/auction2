  
<%
if (request.getProtocol().compareTo("HTTP/1.0")==0)
    response.setHeader("Pragma","no-cache");
if (request.getProtocol().compareTo("HTTP/1.1")==0)
    response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);

if(session.getValue("login")==null ){
  response.sendRedirect("index.htm");
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Customer Information -- Online Auction System</title>

</head>
<body style="text-align: center" bgcolor="#ffffff">
    <span style="font-size: 14pt; font-family: Arial"><strong>Hello, Your Email is
        <%=session.getValue("login")%>. You ID is <%=session.getValue("customerID")%> Here is Your Customer Information.<br />
        <br />

<a href="Bid_History.jsp" target="_blank">Bid History for Each Auction</a><br />
<a href="History_All_Auction.jsp" target="_blank">History of All Current and Past Auction</a><br />
<a href="Item_sold_By_Seller.jsp" target="_blank">Items Sold By Given Seller</a><br />
<a href="Item_Available_Type.jsp" target="_blank">Items Available of A Particular Type</a><br />
<a href="Item_By_Keyword.jsp" target="_blank">Items Available with Particular Keyword</a><br />
<a href="Best_Seller_list.jsp" target="_blank">Best-Seller List</a><br />
<a href="Item_Suggestion_List.jsp" target="_blank">Item Suggestion List</a><br />

</body>
</html>
