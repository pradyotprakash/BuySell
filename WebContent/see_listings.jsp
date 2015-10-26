<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="database.AccessDatabase" %>
<%@ page import="java.sql.Array.*" %>

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
<title>See Listings</title>
</head>
<%	
	String id = "", name="";
	if(session.getAttribute("user_logged_in") == null){
		out.println("<script>window.location.assign('index.jsp')</script>");
	}
	else{
		if(session.getAttribute("id") != null)
			id = session.getAttribute("id").toString();
		if(session.getAttribute("username") != null)
			name = session.getAttribute("username").toString();
	}
%>

<body>
	<%@include file="header" %>
	<br>
<%
	ResultSet rs = AccessDatabase.GetSellingListing(id);
	if(rs == null){
		out.println("No listings so far by you!<br>");
	}
	else{
		out.print("<div class='col s12 m8 l9'>");
		out.print("<table class='centered bordered'>\n\t<thead>\n\t<tr>\n\t\t");
		out.print("<th>Sl. No.</th>\n\t\t");
		out.print("<th>Item name</th>\n\t\t");
		out.print("<th>Item id</th>\n\t\t");
		out.print("<th>Item description</th>\n\t\t");
		out.print("<th>Category</th>\n\t\t");
		out.print("<th>Posted on</th>\n\t\t");
		out.print("<th>Quantity Remaining</th>\n\t\t");
		out.print("<th>Price</th>\n\t\t");
		out.print("<th>User_id</th>\n\t\t");
		out.print("<th>User_name</th>\n\t\t");
		out.print("<th>Quantity demanded</th>\n\t\t");
		out.print("<th>Message</th>\n\t\t");
		out.print("<th>Action</th>\n\t</tr>\n\t</thead>\t");
		int count = 1;
		out.print("<tbody>");
		while(rs.next()){
			
			out.print("<tr>\n\t\t");
			out.print("<td id='count"+ count + "'>" + Integer.toString(count) + "</td>\n\t\t");
			out.print("<td id='item_id"+ count + "'>" + rs.getString(1) + "</td>\n\t\t");
			out.print("<td id='item_name"+ count + "'>" + rs.getString(3) + "</td>\n\t\t");
			out.print("<td id='item_desc"+ count + "'>" + rs.getString(4) + "</td>\n\t\t");
			out.print("<td id='cat"+ count + "'>" + rs.getString(5) + "</td>\n\t\t");
			out.print("<td id='time"+ count + "'>" + rs.getTimestamp(10) + "</td>\n\t\t");
			out.print("<td id='quantity"+ count + "'>" + rs.getInt(8) + "</td>\n\t\t");
			out.print("<td id='price"+ count + "'>" + rs.getInt(9) + "</td>\n\t\t");
			out.print("<td id='user_id"+ count + "'>" + rs.getString(11) + "</td>\n\t\t");
			out.print("<td id='user_name"+ count + "'>" + rs.getString(14) + "</td>\n\t\t");
			out.print("<td id='quanity_demand"+ count + "'>" + rs.getInt(13) + "</td>\n\t\t");
			out.print("<td id='mess"+ count + "'>" + rs.getString(12) + "</td>\n\t\t");
			out.print("<td>");
			out.print("<form action='process.jsp' method='post'> ");
			out.print("<input name=\"type_of\" type=\"hidden\" value=\"sell_item\">");
			out.println("<input type='hidden' name='owner' value='"+session.getAttribute("username").toString()+"'><br>");
			out.print("<button type='submit' class='btn waves-effect waves-light col s12'>Sell</button>");
			out.println("<input type='hidden' name='buyer' value='" + rs.getString(11) + "'><br>");
			out.println("<input type='hidden' name='id' value='" + rs.getString(1) + "'><br>");
			out.println("<input type='hidden' name='quantity' value='" + rs.getString(13) + "'><br>");
			out.println("</form>");
			out.print("</td>\n\t\t");
			out.print("</tr>\n\t");
			count++;
		}
		out.print("</tbody>");
		out.println("</table>");
		out.println("</div>");		
	}
	
%>
</body>
</html>