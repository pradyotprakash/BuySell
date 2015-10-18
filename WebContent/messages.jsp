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
<title>Messages</title>
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
<div style="float:left; width:30%">
	List of all users:<br>
	<form method="post" action="messages.jsp">
	<%
		ArrayList<Pair<String, String>> al = AccessDatabase.ListOfAllUsers();
		for(int i=0;i<al.size();++i){
			out.print("<input type='radio' name='active_user' value='" + al.get(i).first + "'>");
			out.println("<span value='" + al.get(i).second + "'>" + al.get(i).second + "</span><br>");
		}
	%>
	<input type="submit" value='Chat'>
	</form>
</div>
<hr>
<%
	String active_user = null;
	if(request.getParameter("active_user") != null){
		// some user selected
		active_user = request.getParameter("active_user");
		session.setAttribute("receiver_id", active_user);
		session.setAttribute("receiver_name", AccessDatabase.GetName(active_user));
	}
	
	if(session.getAttribute("receiver_id") != null){
%>	<div style="float:left; width:90%">
	<iframe style="text-align:center;" src="show_message.jsp" align="center" width="50%" height="50%" id="message_frame">
	</iframe>
	<br>
	<hr>
	<iframe style="text-align:center;" src="message_input.jsp" align="center" width="50%" height="50%" id="input_frame">
	</iframe>
	</div>
<%	
	}
%>
</body>
</html>