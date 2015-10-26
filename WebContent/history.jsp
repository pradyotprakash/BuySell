<%@page import="database.AccessDatabase"%>
<%@page import="java.sql.*"%>
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
<title>Inventory</title>
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
<%@ include file="header" %>
	<p class="caption">Your transaction history as a seller:</p>
<%
	ResultSet rs = AccessDatabase.GetTransactionHistoryAsSeller(id);
	if(!rs.isBeforeFirst()){
		out.println("No records!<br>");
	}
	else{
%>
	<div class='col s12 m8 l9'>
	<table class='centered bordered'>
		<thead>
		<tr>
			<th>Sl. No.</th>
			<th>Item id </th>
			<th>Buyer</th>
			<th>Price</th>
			<th>Quantity</th>
			<th>Time</th>
			<th>Comments</th>
		</tr>
		</thead>
		<tbody>
<%
		int count = 1;
		
		while(rs.next()){
			out.println("<tr>");
			out.println("<td>" + count + "</td>");
			out.println("<td>" + rs.getString(3) + "</td>");
			out.println("<td>" + rs.getString(1) + "</td>");
			out.println("<td>" + rs.getDouble(4) + "</td>");
			out.println("<td>" + rs.getInt(5) + "</td>");
			out.println("<td>" + rs.getTimestamp(7) + "</td>");
			out.println("<td>" + rs.getString(6) + "</td>");
			out.println("</tr>");
			count++;
		}
%>
		</tbody>
	</table>
	</div>
<%
	}
%>
	<br><br>
	<p class="caption">Your transaction history as a buyer:</p>
<%
	rs = AccessDatabase.GetTransactionHistoryAsBuyer(id);
	if(!rs.isBeforeFirst()){
		out.println("No records!<br>");
	}
	else{
%>
	<div class='col s12 m8 l9'>
	<table class='centered bordered'>
		<thead>
		<tr>
			<th>Sl. No.</th>
			<th>Item id </th>
			<th>Buyer</th>
			<th>Price</th>
			<th>Quantity</th>
			<th>Time</th>
			<th>Comments</th>
		</tr>
		</thead>
		<tbody>
<%
		int count = 1;
		
		while(rs.next()){
			out.println("<tr>");
			out.println("<td>" + count + "</td>");
			out.println("<td>" + rs.getString(3) + "</td>");
			out.println("<td>" + rs.getString(2) + "</td>");
			out.println("<td>" + rs.getDouble(4) + "</td>");
			out.println("<td>" + rs.getInt(5) + "</td>");
			out.println("<td>" + rs.getTimestamp(7) + "</td>");
			out.println("<td>" + rs.getString(6) + "</td>");
			out.println("</tr>");
			count++;
		}
%>
		</tbody>
	</table>
	</div>
<%
	}
%>

</body>
</html>