<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="database.AccessDatabase" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
    <script type="text/javascript" src="materialize/js/perfect-scrollbar.min.js"></script>
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
<script>
	function toggle_div_display(div_id){
		var x = document.getElementById("item" + div_id);
		var y = document.getElementById("b" + div_id);
		var stat = x.style.display;
		if(stat == "none"){
			x.style.display = "block";
			y.innerHTML = "Collapse";
		}
		else{
			x.style.display = "none";
			y.innerHTML = "Buy this";
		}
	}
	
	function verify(){
		var flag = true;
		var count = document.getElementsByTagName('div').length/2;
		for(var i=1;i<=count;++i){
			var x = document.getElementById('q' + i).innerHTML;
			var y = document.getElementsByName('item' + i + '_quantity')[0].value;
			if(parseInt(y) > parseInt(x.substr(20, x.length-20))){
				document.getElementById('e' + i).innerHTML = "Cannot order more than the available amount!";
				flag = false;
			}
			else if (parseInt(y)<0) {
				document.getElementById('e' + i).innerHTML = "Positive amount please Motherfucker!";
				flag = false;	
			}
			else{
				document.getElementById('e' + i).innerHTML = "";
			}
		}
		if(flag){
			var selected = '';
			for(var i=1;i<=count;++i){
				var val = document.getElementsByName('item' + i + '_quantity')[0].value; 
				if(val == ''){
				}
				else{
					selected += i + ',';
				}
			}
			document.getElementsByName('order_list')[0].value = selected;
			alert(selected);
			return true;
		}
		else 
			return false;
	}
</script>
<title>See Listings</title>
</head>

<body>
	<%@include file="header" %>
<%
	if(session.getAttribute("wishlist_updated") != null){
		if(session.getAttribute("wishlist_updated").equals("true")){
			out.println("<span>Wishlist successfully updated!</span><br>");
			session.removeAttribute("wishlist_updated");
		}
		else{
			out.println("<span>Wishlist could not be updated due to some error!</span><br>");
			session.removeAttribute("wishlist_updated");	
		}
	}
	
	ResultSet rs = AccessDatabase.Get_items_on_sale(id);
/* 	HashMap<String, ArrayList<String>> userWishlistInfo = AccessDatabase.GetAlreadyMarkedForBuyingListing(id);
 */	int count = 1;
	if(!rs.isBeforeFirst()){
		out.println("No items currently for sale!<br>");
	}
	else{
		%>
		<hr>
		<div class="card-panel">
		<form action="process.jsp" class="col s12" method="post" onsubmit="return verify()">
		<input name="type_of" type="hidden" value="sell_wishlist">
		<%
	
		while(rs.next()){
			out.println("<div id='entry'>");
			out.println("<span id='e" + count + "' style='color:red'></span><br>");
			out.print("<span>Item name: " + rs.getString(3) + "</span><br>\n\t");
			out.print("<span>Description: " + rs.getString(4) + "</span><br>\n\t");
			out.print("<span>Category: " + rs.getString(5) + "</span><br>\n\t");
			out.print("<span>Posted on: " + rs.getTimestamp(10) + "</span><br>\n\t");
			out.print("<span id='q" + count + "'>Quantity remaining: " + rs.getInt(8) + "</span><br>\n\t");
			out.print("<span>Price: " + rs.getInt(9) + "</span><br>\n\t");
			out.println("<button id= 'b" + count + "' type='button' onclick='toggle_div_display(" + count + ")' class='btn waves-effect waves-light col s12'>Buy this</button><br>");
			out.println("</div>");
			/* 
			ArrayList<String> al = userWishlistInfo.get(rs.getString(1)); 
			
			if(al == null){
				al = new ArrayList<String>();
				al.add("");
				al.add("");
				al.add("");
				al.add("");
			} */
			
			out.println("<div id='item" + count + "' style='display:none'>");
			out.println("<input type='hidden' name='item" + count + "_itemid' value='" + rs.getString(2) + "'>");
			out.println("<input type='hidden' name='item" + count + "_owner' value='" + rs.getString(1) + "'>");
			out.println("<div class='row'><div class='input-field col s12'><i class='mdi-action-question-answer prefix'></i><textarea name='item" + count + "_specification'  class='materialize-textarea'></textarea><label for='message'>Message</label></div></div>");
			out.println("<div class='row'><div class='input-field col s12'><i class='mdi-content-add-box prefix'></i><input type='number' name='item" + count + "_quantity'><label for='quantity'>Quantity</label></div></div>");
			out.println("</div>");
			count++; 
		}
		
		out.println("<input type='hidden' name='order_list'><br>");
		out.println("<div class='row'><div class='input-field col s2 right'><button type='submit' value='Submit' class='btn waves-effect waves-light col s12'>Submit<i class='mdi-content-send right'></i></button></div></div>");
		out.println("</form></div>"); 
	}
	
%>
</body>
</html>