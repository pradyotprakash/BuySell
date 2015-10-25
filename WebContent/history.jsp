<%@page import="database.AccessDatabase"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Inventory</title>
</head>

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

<body>
<%@ include file="header" %>
	Your transaction history as a seller:<br>
<%
	ResultSet rs = AccessDatabase.GetTransactionHistoryAsSeller(id);
	if(!rs.isBeforeFirst()){
		out.println("No records!<br>");
	}
	else{
%>
	<table border="2">
		<tr>
			<td>Sl. No.</td>
			<td>Item id </td>
			<td>Buyer</td>
			<td>Price</td>
			<td>Quantity</td>
			<td>Time</td>
			<td>Comments</td>
		</tr>
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
		}
%>
	</table>
<%
	}
%>
	<br><br>
	Your transaction history as a buyer:<br>
<%
	rs = AccessDatabase.GetTransactionHistoryAsBuyer(id);
	if(!rs.isBeforeFirst()){
		out.println("No records!<br>");
	}
	else{
%>
	<table border="2">
		<tr>
			<td>Sl. No.</td>
			<td>Item name</td>
			<td>Seller</td>
			<td>Price</td>
			<td>Quantity</td>
			<td>Time</td>
			<td>Comments</td>
		</tr>
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
		}
%>
	</table>
<%
	}
%>

</body>
</html>