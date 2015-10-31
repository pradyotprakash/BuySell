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
<%@ include file="header" %>
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

</body>
</html>