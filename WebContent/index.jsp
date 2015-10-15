<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="database.Session" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Log in</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="materialize/css/materialize.min.css" media="screen,projection">
		<link rel="stylesheet" type="text/css" href="materialize/css/materialize.css" media="screen,projection">
		<link rel="stylesheet" type="text/css" href="materialize/css/style.css" media="screen,projection">
		<link rel="stylesheet" type="text/css" href="materialize/css/custom-style.css" media="screen,projection">
		<link rel="stylesheet" type="text/css" href="materialize/css/style-horizontal.css" media="screen,projection">
		<link rel="stylesheet" type="text/css" href="materialize/css/page-center.css" media="screen,projection">
		<link rel="stylesheet" type="text/css" href="materialize/css/prism.css" media="screen,projection">
		<link rel="stylesheet" type="text/css" href="materialize/css/perfect-scrollbar.css" media="screen,projection">
		<script type="text/javascript" src="materialize/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="materialize/js/materialize.js"></script>
		<script type="text/javascript" src="materialize/js/prism.js"></script>
		<script type="text/javascript" src="materialize/js/perfect-scrollbar.min.js"></script>
	</head>

	<body>
		<%
			boolean firstTime = true;
			String status = null;
			String id = request.getParameter("id");
			String passwd = request.getParameter("password");
			
			if(id != null || passwd != null)
				firstTime = false;
			
			if(!firstTime){
				status = Session.getUserName(id, passwd);
				
				if(status != null){
					session.setAttribute("user_logged_in", "true");
					session.setAttribute("username", status);
					session.setAttribute("id", id);
					out.println("<script>window.location.assign('home.jsp')</script>");
				}
			}
		%>
		<nav class="light-blue">
			<div class="brand-logo center">Login Page</div>
		</nav>
		<%
			if(status== null && !firstTime){
				out.println("<script>$(document).ready(function(){$('#myModal').openModal();});</script>");
			}
		%>
		<div id="myModal" class="modal">
		    <!-- Modal content-->
		    <div class="modal-content">
		        <h4 class="modal-title">Instructions</h4>
		        <p>Your username/password combination doesn't seem to exist.</p>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn waves-effect btn-flat modal-action modal-close">Close</button>
		    </div>
		</div>
		<div id="login-page" class="row">
			<div class="col s12 z-depth-4 card-large">
				<form id="login_form" class="login-form" method="post" action="index.jsp">
					<%
						if(firstTime && session.getAttribute("registered") != null && session.getAttribute("registered").equals("true")){
							out.println("<script>$(document).ready(function(){$('#myModal1').openModal();});</script>");
					%>
					<div class="modal" id="myModal1">
		      			<div class="modal-content">
	          				<h4 class="modal-title">Instructions</h4>
		        			<p>Account successfully created.<br>
		        			Please use your credentials to login.</p>
			        	</div>
			        	<div class="modal-footer">
			          		<button type="button" class="btn waves-effect btn-flat modal-action modal-close">Close</button>
			    		</div>
			      	</div>
					<%
						session.setAttribute("registered", "");
						}
					%>
					<div class="row margin">
						<div class="input-field col s12">
							<i class="mdi-social-person-outline prefix"></i>
							<input id="username" name="id" type="text" required>
	            			<label for="ID">ID</label>
						</div>
					</div>
					<div class="row margin">
						<div class="input-field col s12">
							<i class="mdi-action-lock-outline prefix"></i>
				            <input id="password" name="password" type="password" required>
				            <label for="password">Password</label> 
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<button type="submit" value="submit" class="btn waves-effect waves-light col s12">submit</button>
			            </div>
			        </div>
		            <div class="row">
						<div class="input-field col s12">
			            	<p>
			            		First time here? <a href="register.jsp">Sign Up</a> <br>
			            		<a class="tooltipped" data-toggle="popover" data-delay=20 data-position="right" data-tooltip="So that you can enter what you wanna buy/sell from/to other users." style="text-decoration:none;"><span> Why Sign Up? </span></a>
			            	</p>
			            </div>
					</div>
				</form>
			</div>
		</div>
		<script>
			$(document).ready(
				function () {
					$('[data-toggle="popover"]').popover();   
				}
			);
			
		</script>
	</body>
</html>
