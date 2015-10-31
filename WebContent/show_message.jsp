<%@page import="database.Session"%>
<%@page import="database.AccessDatabase"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="database.Pair"%>
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
    <!-- jQuery Library -->
    <script type="text/javascript" src="materialize/js/jquery-1.11.2.min.js"></script>    
    <!--materialize js-->
    <script type="text/javascript" src="materialize/js/materialize.js"></script>
    <!--scrollbar-->
    <script type="text/javascript" src="materialize/js/perfect-scrollbar.min.js"></script>
<title>Messages</title>
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
	
	if(session.getAttribute("receiver_id") != null){
		
		String active_user = session.getAttribute("receiver_id").toString();
		TreeMap<Timestamp, Pair<Boolean, String>> tm = AccessDatabase.GetAllMessagesBetweenAPair(id, active_user);	
		out.println("<br>");
		for(Pair<Boolean, String> p : tm.values()) {
			boolean b = p.first;
			String message = p.second;
			if(b){
				// should appear to the right, facebook style
				out.println("<div align='right'><span class='red-text'><code>" + message + "</code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></div>");
			}
			else{
				out.println("<div align='left'><span class='blue-text'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + message + "</span></div>");
			}
		}
		
	}
%>
</body>
<script type="text/javascript">
  setTimeout(function(){
    location = ''
  },10000)
</script>
</html>