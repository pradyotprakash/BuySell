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
<title>Insert title here</title>
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
	
	String s = ""; 
	if(session.getAttribute("refresh_message_frame") != null){
		s = session.getAttribute("refresh_message_frame").toString();
		if(s.equals("true")){
			session.setAttribute("refresh_message_frame", "false");
			out.println("<script>parent.document.getElementById('message_frame').location.reload()</script>");
			//out.println("<script>window.frames['message_frame'].location.assign('show_message.jsp')</script>");
		}
	}
%>
<body>
	<form method="post" class="col s12" action="process.jsp">
		<input name="type_of" type="hidden" value="add_message">
		<div class="row">
			<div class="input-field col s12">
				<i class="mdi-communication-chat prefix"></i>
				<textarea name="message_text" class="materialize-textarea" required></textarea>
				 <label for="textarea1">Message</label>
			</div>
		</div>
		<div class="row">
			<div class="input-field col s12">
				<button type="submit" value="Chat" class="btn waves-effect waves-light col s4 right">Chat<i class="mdi-communication-send right"></i></button>
			</div>
		</div>
	</form>
</body>
</html>