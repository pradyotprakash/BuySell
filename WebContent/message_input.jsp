<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
	<form method="post" action="process.jsp">
		<input name="type_of" type="hidden" value="add_message">
		<input type="text" name="message_text"><br>
		<input type="submit" value="Chat">
	</form>
</body>
</html>