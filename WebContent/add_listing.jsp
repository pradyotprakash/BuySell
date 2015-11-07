<%@page import="database.AccessDatabase"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- CORE CSS-->    
    <link href="materialize/css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection">
    <link href="materialize/css/style.css" type="text/css" rel="stylesheet" media="screen,projection">   
    <script type="text/javascript" src="materialize/js/jquery-1.11.2.min.js"></script>    
    <!--materialize js-->
    <script type="text/javascript" src="materialize/js/materialize.js"></script>
    <!--scrollbar-->
    <script type="text/javascript" src="materialize/js/perfect-scrollbar.min.js"></script>
<title>Add listing</title>
</head>
<body>
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

	if(session.getAttribute("item_sell_insert") != null){
		if(session.getAttribute("item_sell_insert").equals("true")){
			out.println("<script>$(document).ready(function(){$('#myModal').openModal();});</script>");
			session.setAttribute("item_sell_insert",null);
		}
		else {
			out.println("<script>$(document).ready(function(){$('#myModal1').openModal();});</script>");
			session.setAttribute("item_sell_insert",null);
		}
	}
%>
	<div id="myModal" class="modal">
	    <!-- Modal content-->
	    <div class="modal-content">
	        <h4 class="modal-title">Instructions</h4>
	        <p>Listing added successfully! Add more below.</p>
	    </div>
	    <div class="modal-footer">
	    	<button type="button" class="btn waves-effect btn-flat modal-action modal-close">Close</button>
	    </div>
	</div>
	
	<div id="myModal1" class="modal">
	    <!-- Modal content-->
	    <div class="modal-content">
	        <h4 class="modal-title">Instructions</h4>
	        <p>Could not add listing! Try again!</p>
	    </div>
	    <div class="modal-footer">
	    	<button type="button" class="btn waves-effect btn-flat modal-action modal-close">Close</button>
	    </div>
	</div>
	
	<div class="col s6 m6 l6 center-align">
		<div class="row">
			<form method="post" class="login-form" action="process.jsp" id="selling" >
				<div class="input-field col s12">
					<input name="type_of" type="hidden" value="add_listing">
				</div>
				<div class="input-field col s12">
					<input type="text" name="item_name" required>
					<label for="name">Name of item</label>
				</div>
				<div class="input-field col s12">
					<textarea name="item_description" class="materialize-textarea" length="120" required></textarea>
					<label for="description">Item description</label>
				</div>
				<div class="input-field col s12">
					<input type="number" name="item_quantity" required min="1">
					<label for="quantity">Quantity to sell</label>
				</div>
				<div class="input-field col s12">
					<input type="number" name="item_price" required min="1">
					<label for="price">Price</label>
				</div>	
				<div class="input-field col s12">
					<label for="category">Category</label>
					<br>
<%
					ArrayList<String> al = AccessDatabase.GetExistingCategories();
					
					int i = 1;
					for(String s : al){
						if(s.equals("Others")){
							continue;
						}
						out.println("<p>");
						out.println("<input name='item_category' value='" + s + "' type='radio' id='test" + i + "' />");
						out.println("<label for='test" + i + "'>" + s + "</label>");
						++i;
				        out.println("</p>");
					}
					
					out.println("<p>");
					out.println("<input name='item_category' value='" + "Other" + "' type='radio' id='test" + i + "' />");
					out.println("<label for='test" + i + "'>" + "Other" + "</label>");
					++i;
			        out.println("</p>");
%>					
	                <br>
				</div>	
				<div class="file-field input-field col s12">
					<div class="btn">
						<span>Image</span>
						<input type="file" name="photo">
					</div>
				</div>
				<div class="input-field col s12">
					<button type="submit" class="btn waves-effect waves-light col s12">Submit</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>