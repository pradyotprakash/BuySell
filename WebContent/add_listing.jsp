<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- CORE CSS-->    
    <link href="materialize/css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection">
    <link href="materialize/css/style.css" type="text/css" rel="stylesheet" media="screen,projection">
    <!-- Custome CSS-->    
    <link href="materialize/css/custom-style.css" type="text/css" rel="stylesheet" media="screen,projection">
    <!-- Custome CSS-->    
    <link href="materialize/css/custom-style.css" type="text/css" rel="stylesheet" media="screen,projection">

    <!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
    <link href="materialize/css/perfect-scrollbar.css" type="text/css" rel="stylesheet" media="screen,projection">
    <link href="materialize/js/jquery-jvectormap.css" type="text/css" rel="stylesheet" media="screen,projection">
    <link href="materialize/js/chartist.min.css" type="text/css" rel="stylesheet" media="screen,projection">
    <!-- jQuery Library -->
    <script type="text/javascript" src="materialize/js/jquery-1.11.2.min.js"></script>    
    <!--materialize js-->
    <script type="text/javascript" src="materialize/js/materialize.js"></script>
    <!--scrollbar-->
    <script type="text/javascript" src="materialize/js/perfect-scrollbar/perfect-scrollbar.min.js"></script>
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
	<form method="post" class="login-form" action="process.jsp">
		<input name="type_of" class="input-field col s12" type="hidden" value="add_listing">
		<input type="text" class="input-field col s12" name="item_name" required placeholder="Name of item"><br>
		<textarea name="item_description" class="input-field col s12" required placeholder="Item description"></textarea><br>
		<input type="number" class="input-field col s12" name="item_quantity" required placeholder="Quantity to sell"><br>
		<input type="number" class="input-field col s12" name="item_price" required placeholder="Price"><br>
		<input type="text" class="input-field col s12" name="item_category" required placeholder="Category"><br>
		<button type="submit" class="btn waves-effect waves-light col s12">Submit</button>
		
	</form>
</body>
</html>