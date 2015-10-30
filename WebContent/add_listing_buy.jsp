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

%>
	<%@include file="header" %>
<%
	if(session.getAttribute("item_buy_insert") != null){
		if(session.getAttribute("item_buy_insert").equals("true")){
			out.println("<script>$(document).ready(function(){$('#myModal').openModal();});</script>");
			session.setAttribute("item_buy_insert",null);
		}
		else {
			out.println("<script>$(document).ready(function(){$('#myModal1').openModal();});</script>");
			session.setAttribute("item_buy_insert",null);
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
	
	<div class="col s12 m8 l9">
		<div class="row">
			<form method="post" class="login-form" action="process.jsp">
				<div class="input-field col s12">
					<input name="type_of" type="hidden" value="add_listing_buy">
				</div>
				<div class="input-field col s12">
					<input type="text" name="item_name" required>
					<label for="name">Name of item</label>
				</div>
				<div class="input-field col s12">
					<textarea name="item_description" required class="materialize-textarea"></textarea>
					<label for="description">Item specifications</label>
				</div>
				<div class="input-field col s12">
					<input type="number" name="item_quantity" required min="1">
					<label for="quantity">Quantity to Buy</label>
				</div>
				<div class="input-field col s12">
					<input type="number" name="item_price1" required min="0">
					<label for="price">Price Range Start</label>
				</div>
				<div class="input-field col s12">
					<input type="number" name="item_price2" required>
					<label for="price">Price Range End</label>
				</div>
				<div class="input-field col s12">
					<label for="category">Category</label>
					<br>
					<p>
	                  <input name="item_category" value="Electronics" type="radio" id="test1" />
	                  <label for="test1">Electronics</label>
	                </p>
	                <p>
	                  <input name="item_category" value="Clothes" type="radio" id="test2" />
	                  <label for="test2">Clothes</label>
	                </p>
	                <br>
				</div>
				<div class="input-field col s12">
					<input type="text" name="item_comments" required><br>
					<label for="comments">Comments</label>
				</div>
				<div class="input-field col s12">
					<button type="submit" class="btn waves-effect waves-light col s12">Submit</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>