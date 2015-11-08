<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="database.AccessDatabase" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Profile</title>
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
%>
<body>
<%
	if(session.getAttribute("update_profile") != null){
		if(session.getAttribute("update_profile").equals("true")){
			out.println("<script>$(document).ready(function(){$('#myModal1').openModal();});</script>");
			session.removeAttribute("update_profile");
		}
		else{
			out.println("<script>$(document).ready(function(){$('#myModal').openModal();});</script>");
			session.removeAttribute("update_profile");	
		}
	}
%>

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
<%
	ResultSet rs = AccessDatabase.GetProfileData(id);
%>
	<section id="content">
		<div class="container">
			<div id="profile-page" class="section">
				<div id="profile-page-header" class="card">
	                <div class="card-image hoverable waves-effect waves-block waves-light">
	                    <img src="http://demo.geekslabs.com/materialize/v2.1/layout03/images/user-profile-bg.jpg" alt="user background">                    
	                </div>
	                <div class="card-content">
                  		<div class="row">
                  		<% while(rs.next()) { %>
                  			<div class="col s4 center-align">                        
		                        <h4 class="card-title grey-text text-darken-4"> <%out.println(rs.getString(2)); %></h4>
		                        <p class="medium-small grey-text">User</p>                        
		                    </div>
		                    <div class="col s4 center-align">                        
		                        <h4 class="card-title grey-text text-darken-4"> <%out.println(rs.getString(1)); %></h4>
		                        <p class="medium-small grey-text">ID</p>                        
		                    </div>
		                    <div class="col s4 center-align">                        
		                        <h4 class="card-title grey-text text-darken-4"> <%out.println(rs.getString(4)); %></h4>
		                        <p class="medium-small grey-text">E-mail</p>                        
		                    </div>
		                    <%} %>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<div id="myModal" class="modal">
	    <!-- Modal content-->
	    <div class="modal-content">
	        <h4 class="modal-title">Instructions</h4>
	        <p>Profile could not be updated due to some error!</p>
	    </div>
	    <div class="modal-footer">
	    	<button type="button" class="btn waves-effect btn-flat modal-action modal-close">Close</button>
	    </div>
	</div>

	<div id="myModal1" class="modal">
	    <!-- Modal content-->
	    <div class="modal-content">
	        <h4 class="modal-title">Instructions</h4>
	        <p>Profile successfully updated!</p>
	    </div>
	    <div class="modal-footer">
	    	<button type="button" class="btn waves-effect btn-flat modal-action modal-close">Close</button>
	    </div>
	</div>
	
	<section>
	<div id="basic-form" class="section">
		<div class="row">
			<div class="col s12 m12 l12">
				<div class="card-panel">
					<div class = "row">
						<p class="caption center" style="font-size:40px">Update your profile</p>
						<form action="process.jsp" class="col s12" method="post">
						<input name="type_of" type="hidden" value="update_profile">
						<div class="row">
				        	<div class="input-field col s12">
					            <i class="mdi-social-person-outline prefix"></i>
								<input type="text" name="name"  required value=""/>
								<label for="username" class="center-align">Username</label>
							</div>
						</div>
						<div class="row">
				        	<div class="input-field col s12">
					            <i class="mdi-communication-email prefix"></i>
								<input type="email" name="email"  required value=""/>
								<label for="email" class="center-align">Email</label>
							</div>
						</div>
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
          					<div class="input-field col s12">
								<button class="btn waves-effect waves-light right" type="submit">Update Info<i class="mdi-content-send right"></i></button>
							</div>
						</div>
						</form>
					</div>
				</div> 
			</div>
		</div>
	</div>
	</section>
</body>
</html>