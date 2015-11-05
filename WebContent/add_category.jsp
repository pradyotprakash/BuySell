<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="database.Session" %>
<%@ page import="database.AccessDatabase"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">

<head>
    <title>Home</title>
    <!-- CORE CSS-->    
    <link href="materialize/css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection">
    <link href="materialize/css/style.css" type="text/css" rel="stylesheet" media="screen,projection">
    <!-- Custome CSS-->    
    <link href="materialize/css/custom-style.css" type="text/css" rel="stylesheet" media="screen,projection">
    <!-- Custome CSS-->    
    <link href="materialize/css/custom-style.css" type="text/css" rel="stylesheet" media="screen,projection">

	<script>
		var i = 2; 
		function create_new_row(){
			l = document.createElement('input');
		}	
	</script>
</head>
<%
	String id = "", name="";
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
<body>
<%
	if(id.equals("admin")){
%>
	<%@include file="admin_header"%>
<%
		out.println("Already existing categories:<br>");
		ArrayList<String> al = AccessDatabase.GetExistingCategories();
	
		for(String s : al){
			out.println(s + "<br>");
		}
		
%>
	<form action="process.jsp" method="post">
		<input name="type_of" type="hidden" value="add_category">
		<button onclick="create_new_row()"><br></button>
		<input type="submit"><br>
	</form>
<%
	}
	else{
		out.println("Not authorized to access this page!! Go away.");	
	}
%>

</body>
</html>