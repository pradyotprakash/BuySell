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
	if(session.getAttribute("item_buy_insert") != null){
		if(session.getAttribute("item_buy_insert").equals("true")){
			out.println("Listing added successfully! Add more below<br>");
		}
		else out.println("Could not add listing! Try again!<br>");
	}
%>
	<form method="post" action="process.jsp">
		<input name="type_of" type="hidden" value="add_listing_buy">
		<input type="text" name="item_name" required placeholder="Name of item"><br>
		<textarea name="item_description" required placeholder="Item specifications"></textarea><br>
		<input type="number" name="item_quantity" required placeholder="Quantity to Buy"><br>
		<input type="number" name="item_price1" required placeholder="Price Range Start"><br>
		<input type="number" name="item_price2" required placeholder="Price Range End"><br>
		<input type="text" name="item_category" required placeholder="Category"><br>
		<input type="text" name="item_comments" required placeholder="Comments"><br>
		<input type="submit">
		
	</form>
</body>
</html>