<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="database.Session" %>
<%@ page import="database.Register" %>
<!DOCTYPE html>
<html>
	<head>
		<title>Register</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="materialize/css/materialize.min.css" media="screen,projection">
		<link rel="stylesheet" type="text/css" href="materialize/css/materialize.css" media="screen,projection">
		<link rel="stylesheet" type="text/css" href="materialize/css/style.css" media="screen,projection">
		<link rel="stylesheet" type="text/css" href="materialize/css/custom-style.css" media="screen,projection">
		<link rel="stylesheet" type="text/css" href="materialize/css/style-horizontal.css" media="screen,projection">
		<link rel="stylesheet" type="text/css" href="materialize/css/prism.css" media="screen,projection">
		<link rel="stylesheet" type="text/css" href="materialize/css/perfect-scrollbar.css" media="screen,projection">
		<script type="text/javascript" src="materialize/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="materialize/js/materialize.js"></script>
		<script type="text/javascript" src="materialize/js/prism.js"></script>
		<script type="text/javascript" src="materialize/js/perfect-scrollbar.min.js"></script>
	</head>
<%	
	
	boolean firstTime = true;
	int status = -100;
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String passwd = request.getParameter("passwd");
	
	if(id != null || name != null || email != null || passwd != null)
		firstTime = false;
	if(!firstTime){
		status = Register.register(id, name, email, passwd);
		if(status == 0){
			session.setAttribute("registered", "true");
			out.println("<script>window.location.assign('index.jsp')</script>");
		}
	}
	 %>
	 	
	<body>
		<div class="navbar-fixed">
			<nav class="light-blue">
				<div class="brand-logo center">Save your basic information</div>
			</nav>
		</div>
		<div id="basic-form" class="section">
		<div class="row">
			<div class="col s12 m12 l12">
				<div class="card-panel">
					<div class = "row" style="padding-top:120px">
						<form action="register.jsp" class="col s12" method="post" onsubmit="return verify()">
						<%
							if(status == 1){
								out.println("<script>$(document).ready(function(){$('#myModal').openModal();});</script>");
							}
						%>
						<div id="myModal" class="modal">
						    <!-- Modal content-->
						    <div class="modal-content">
						        <h4 class="modal-title">Instructions</h4>
						        <p style="color:red">User ID '<% out.println(id); %>' already exists! Try something else.</p>
						    </div>
						    <div class="modal-footer">
						    	<button type="button" class="btn waves-effect btn-flat modal-action modal-close">Close</button>
						    </div>
						</div>
						<div class="row">
				        	<div class="input-field col s12">
					            <i class="mdi-social-person-outline prefix"></i>
								<input type="text" name="id"  required value=""/>
								<label for="username" class="center-align">User ID</label>
							</div>
						</div>
						<%
							if(firstTime){
								out.println("<div class=\"row\"><div class=\"input-field col s12\"><i class=\"mdi-social-person-outline prefix\"></i><input type='text' name='name' required/><label for=\"username\" class=\"center-align\">Username</label></div></div>");
								out.println("<div class=\"row\"><div class=\"input-field col s12\"><i class=\"mdi-communication-email prefix\"></i><input type='email' name='email' required/><label for=\"email\" class=\"center-align\">Email</label></div></div>");
							}
							else{
								out.println("<div class=\"row\"><div class=\"input-field col s12\"><i class=\"mdi-social-person-outline prefix\"></i><input type='text' name='name' value='" + name + "'required/><label for=\"username\" class=\"center-align\">Username</label></div></div>");
								out.println("<div class=\"row\"><div class=\"input-field col s12\"><i class=\"mdi-communication-email prefix\"></i><input type='email' name='email' value='" + email + "' required/><label for=\"email\" class=\"center-align\">Email</label></div></div>");
							}
						%>
							<div class="row">
	          					<div class="input-field col s12">
	            					<i class="mdi-action-lock-outline prefix"></i>
	            					<input id="password" name="passwd" type="password" required>
	            					<label for="password">Password</label>
	          					</div>
	        				</div>
	        				<div class="row">
	          					<div class="input-field col s12">
	            					<i class="mdi-action-lock-outline prefix"></i>
	            					<input id="re_password" name="re_passwd" type="password" required>
	            					<label for="re_password">Retype Password</label>
	          					</div>
	        				</div>
	        				<div class="row">
	        					<div class="input-field col s6">
									<a class="btn waves-effect waves-light left" href="index.jsp"><i class="mdi-content-reply left"></i>Back to Login page</a>
								</div>
	          					<div class="input-field col s6">
									<button class="btn waves-effect waves-light right" type="submit">Register Now<i class="mdi-content-send right"></i></button>
								</div>
							</div>
						</form>
					</div>
				</div> 
			</div>
			</div>
		</div>
	</body>
</html>
