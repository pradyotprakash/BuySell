<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="database.AccessDatabase" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>See Listings</title>
</head>
<%	
	String id = "", name;
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
<%
	ResultSet rs = AccessDatabase.GetSellingListing(id);
	if(rs == null){
		out.println("No listings so far by you!<br>");
	}
	else{
		out.print("<table border='2'>\n\t<tr>\n\t\t");
		out.print("<td>Sl. No.</td>\n\t\t");
		out.print("<td>Item name</td>\n\t\t");
		out.print("<td>Item description</td>\n\t\t");
		out.print("<td>Category</td>\n\t\t");
		out.print("<td>Posted on</td>\n\t\t");
		out.print("<td>Quantity Remaining</td>\n\t\t");
		out.print("<td>Price</td>\n\t\t");
		out.print("<td>Interested Buyers</td>\n\t</tr>\n\t");
		int count = 1;
		while(rs.next()){
			out.print("<tr>\n\t\t");
			out.print("<td>" + Integer.toString(count) + "</td>\n\t\t");
			out.print("<td>" + rs.getString(2) + "</td>\n\t\t");
			out.print("<td>" + rs.getString(3) + "</td>\n\t\t");
			out.print("<td>" + rs.getString(4) + "</td>\n\t\t");
			out.print("<td>" + rs.getTimestamp(11) + "</td>\n\t\t");
			out.print("<td>" + rs.getInt(8) + "</td>\n\t\t");
			out.print("<td>" + rs.getInt(9) + "</td>\n\t\t");
			out.print("<td>");
			System.out.println("trtre");
			Array a = rs.getArray(10);
			String[] array;
			//System.out.println(a.toString());
			if(a != null){
				array = (String[])a.getArray();
				for(int j=0;j<array.length;++j){
					out.print(array[j] + ",");
				}
			}
			out.print("</td>\n\t</tr>\n\t");
			count++;
		}
		out.println("</table>");
	}
	
%>
</body>
</html>