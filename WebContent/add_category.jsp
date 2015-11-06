<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="database.Session" %>
<%@ page import="database.AccessDatabase"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">

<head>
    <title>Home</title>
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
	if(id.equals("admin")){
%>
	<%@include file="admin_header"%>
	<div class="container">
		<p class="caption">Already existing categories:<br></p>
		<div id="category_container">
			
		</div>
		<div class="row">
			<div class="input-field col s6">
			<input id="category_inp" />
			</div>
			<div class="input-field col s6">
			<button onclick="create_new_row()" class="btn waves-effect waves-light left">Add category<br></button>
			</div>
		</div>	
		
	<form action="process.jsp" method="post" onsubmit="populate_form()">
		<input name="type_of" type="hidden" value="add_category">
		<div class="row">
			<div class="input-field col s12">
			<input name="categories" type="hidden" value="">
			</div>
		</div>
		<button type="submit" class="btn waves-effect waves-light left">Submit</button>
	</form>
	</div>
	<script>
	var li = [];
	var ne = [];
<%	
		
		ArrayList<String> al = AccessDatabase.GetExistingCategories();
	
		for(String s : al){
			out.println("li.push('" + s + "')");
		}
		out.println("document.getElementById('category_container').innerHTML = li;");
			
%>	
 
		function create_new_row(){
			
			var s = document.getElementById("category_inp").value;
			if(li.indexOf(s) > -1){
				alert("Already exists!");
			}
			else{
				ne.push(s);
				li.push(s);
				s = "";
				for(var i=0;i<li.length;++i){
					s += li[i] + "<br>";
				}
				
				document.getElementById("category_container").innerHTML = s;
				document.getElementById("category_inp").value = "";
			}			
		}
		
		function populate_form(){
			document.getElementsByName("categories")[0].value = ne;
			return true;
		}

	</script>
<%
	}
	else{
		out.println("Not authorized to access this page!! Go away.");	
	}
%>

</body>
</html>