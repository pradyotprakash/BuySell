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
<script>
	var myIframe = document.getElementById('message_frame');
	myIframe.onload = function(){
	    myIframe.contentWindow.scrollTo(0,50000);
	};
</script>
<%
	if(id.equals("admin")){
%>
	<%@include file="admin_header"%>
<%
	}
	else{
%>
	<%@include file="header"%>
<%		
	}
%>
<div class="wrapper">
	<aside id="left-sidebar-nav">
        <ul id="slide-out" class="side-nav fixed leftside-navigation">
        	<p class="caption">List of all users:</p>
			<form method="post" action="messages.jsp">
	<%
		ArrayList<Pair<String, String>> al = AccessDatabase.ListOfAllUsers();
		for(int i=0;i<al.size();++i){
			if(!id.equals(al.get(i).first)){ // && !al.get(i).first.equals("admin")){
				out.print("<li><p><input type='radio' name='active_user' value='" + al.get(i).first + "' id='" + al.get(i).first + "'/>");
				out.println("<label for='" + al.get(i).second + "'>" + al.get(i).second + "</label></p></li>");
			}
		}
	%>		<div class="row col s12">
            	<div class="input-field col s12">
					<button type="submit" value='Chat' class="btn waves-effect waves-light col s6 right">Chat</button>
				</div>
			</div>
			</form>
		</ul>
	</aside>
</div>
<%
	String active_user = null;
	if(request.getParameter("active_user") != null){
		// some user selected
		active_user = request.getParameter("active_user");
		session.setAttribute("receiver_id", active_user);
		session.setAttribute("receiver_name", AccessDatabase.GetName(active_user));
	}
	
	if(session.getAttribute("receiver_id") != null){
%>	
	<section id="content">
		<div class="container right" style="padding-left:450px">
			<div class="section" style="padding-top:10px;width:90%">
			<%
				String chattingWith = session.getAttribute("receiver_id").toString();
				out.println("<div class='row'><div class='col s6' style='position:relative;left:30px'><p class='caption blue-text'>" + chattingWith+"</p></div>");
				out.println("<div class='col s6' style='position:relative;left:90px'><p class='caption red-text'>" + name+"</p></div></div>");
			%>
				<iframe width="800" height="400" src="show_message.jsp" id="message_frame">
				</iframe>
				<br>
				<iframe width="800" height="300" src="message_input.jsp" frameborder="0" id="input_frame">
				</iframe>
			</div>
		</div>
	</section>
<%	
	}
%>
</body>
</html>