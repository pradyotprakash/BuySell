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
	<%@include file="header" %>
	<div class="container">
	<%
		out.println("<p class='caption'><b>Welcome " + name+"</b></p>");
		ResultSet rs = AccessDatabase.AllItemsFromItemBuy();
		int count = 1;
				
		if(!rs.isBeforeFirst()){
			out.println("No recent demands!");
		}
		else{
	%>
	
	<p class="caption">Recent demands:</p>
	<div class='col s12 m8 l9'>
	<table class='centered bordered'>
		<thead>
		<tr>
			<th>Sl. No.</th>
			<th>Posted by</th>
			<th>Item name</th>
			<th>Quantity demanded</th>
			<th>Price range</th>
			<th>Category</th>
			<th>Description</th>
			<th>Comments</th>
		</tr>
		</thead>
		<tbody>
	<%
			while(rs.next()){
				out.println("<tr>");
				out.println("<td>" + count + "</td>");
				count++;
				out.println("<td>" + rs.getString(1) + "</td>");
				out.println("<td>" + rs.getString(8) + "</td>");
				out.println("<td>" + rs.getString(3) + "</td>");
				out.println("<td>" + rs.getString(4) + "</td>");
				out.println("<td>" + rs.getString(10) + "</td>");
				out.println("<td>" + rs.getString(9) + "</td>");
				out.println("<td>" + rs.getString(6) + "</td>");
				out.println("</tr>");
				
			}
			out.println("</tbody></table></div>");
		}
	%>
	</div>
</body>

</html>