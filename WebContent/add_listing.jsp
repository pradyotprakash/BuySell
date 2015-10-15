<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add listing</title>
</head>
<body>
<%
String id = "", name;
if(session.getAttribute("user_logged_in") == null){
	out.println("<script>window.location.assign('index.jsp')</script>");
}
else{
	if(!session.getAttribute("user_logged_in").equals("true")){
		out.println("<script>window.location.assign('index.jsp')</script>");
	}
	else{
		if(session.getAttribute("id") != null)
			id = session.getAttribute("id").toString();
		if(session.getAttribute("username") != null)
			name = session.getAttribute("username").toString();
	}
}

%>
	<%@include file="header" %>
<%
	if(session.getAttribute("item_sell_insert") != null){
		if(session.getAttribute("item_sell_insert").equals("true")){
			out.println("Listing added successfully! Add more below<br>");
		}
		else out.println("Could not add listing! Try again!<br>");
	}
%>
	<form method="post" action="process.jsp">
		<input name="type_of" type="hidden" value="add_listing">
		<input type="text" name="item_name" required placeholder="Name of item"><br>
		<textarea name="item_description" required placeholder="Item description"></textarea><br>
		<input type="number" name="item_quantity" required placeholder="Quantity to sell"><br>
		<input type="number" name="item_price" required placeholder="Price"><br>
		<input type="text" name="item_category" required placeholder="Category"><br>
		Is item biddable: 
		<input type="radio" name="item_biddable" value="yes">Yes
		<input type="radio" name="item_biddable" value="no" checked="checked">No<br>
		If yes, then enter the base price. If not, ignore this
		<input type="number" name="item_bidding_price"><br>
		<input type="submit">
		
	</form>
	
	
	
</body>
</html>