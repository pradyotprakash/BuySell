<%@page import="javax.swing.text.Document"%>
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
	var first_time=true;
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
		var count = document.getElementsByName('entries').length;
		for(var i=1;i<=count;++i){
			var x = document.getElementById('q' + i).innerHTML;
			var y = document.getElementsByName('item' + i + '_quantity')[0].value;
			if(parseInt(y) > parseInt(x.substr(20, x.length-20))){
				document.getElementById('e' + i).innerHTML = "Cannot order more than the available amount!";
				flag = false;
			}
			else if (parseInt(y)<0) {
				document.getElementById('e' + i).innerHTML = "Positive amount please!";
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
			return true;
		}
		else 
			return false;
	}
	
	function showMe(id) {
		var count = document.getElementsByName('entries').length;
	    var chboxs = document.getElementById(id);
		if(first_time) {
			for(var i=1;i<=count;i++) { 
				document.getElementById('entry'+i).style.display = "none";
			}
			first_time=false;
		}
	    for(var i=1;i<=count;i++) { 
	        if(id == 'cat1' && chboxs.checked == true){
		         var category = document.getElementById('category'+i).innerHTML;
				 if(category=="Category: Electronics") {
		        	 document.getElementById('entry'+i).style.display = "block";
		         }
	        }
	        if(id == 'cat1' && chboxs.checked == false){
		         var category = document.getElementById('category'+i).innerHTML;
				 if(category=="Category: Electronics") {
		        	 document.getElementById('entry'+i).style.display = "none";
		         }
	        }
	        if(id == "cat2" && chboxs.checked == true){
		         var category = document.getElementById('category'+i).innerHTML;
		         if(category=="Category: Clothes") {
		        	 document.getElementById('entry'+i).style.display = "block";
		         }
	        }
	        if(id == "cat2" && chboxs.checked == false){
		         var category = document.getElementById('category'+i).innerHTML;
		         if(category=="Category: Clothes") {
		        	 document.getElementById('entry'+i).style.display = "none";
		         }
	        }
	        if(id == "cat3" && chboxs.checked == true){
		         var category = document.getElementById('category'+i).innerHTML;
		         if(category!="Category: Clothes" && category!="Category: Electronics") {
		        	 document.getElementById('entry'+i).style.display = "block";
		         }
	        }
	        if(id == "cat3" && chboxs.checked == false){
		         var category = document.getElementById('category'+i).innerHTML;
		         if(category!="Category: Clothes" && category!="Category: Electronics") {
		        	 document.getElementById('entry'+i).style.display = "none";
		         }
	        }
	        if(document.getElementById('cat1').checked == false && document.getElementById('cat2').checked == false && document.getElementById('cat3').checked == false){
		        document.getElementById('entry'+i).style.display = "block";
		        first_time=true;
	        }
	    }
	    var j=1;
	    for(j=1;j<=count;j++) {
	    	if(document.getElementById('entry'+j).style.display == "block") {
	    		break;
	    	}
	    }
	    if(j==count+1) {
	    	document.getElementById('submit_btn').style.display = "none";
	    }
	    else {
	    	document.getElementById('submit_btn').style.display = "block";
	    }
	}
</script>
<title>See Listings</title>
</head>

<body>
	<%@include file="header" %>
	<form action="add_wishlist.jsp" class="col s12" method="post">
		<div class="row">
			<div class="input-field col s6">
				<input type="text" name="search_bar">
				<label for="search">Search Here!!</label>
			</div>	
			<div class="input-field col s6">
				<button type="submit" class="btn waves-effect waves-light col s4">Search</button>
			</div>
		</div>
	</form>
	<div class="row">
	    <div class="col s4 m4 l4">
	      <input type="checkbox" name="cat" onclick="showMe('cat1')" id="cat1" />
	      <label for="cat1">Electronics</label>
	    </div>
	    <div class="col s4 m4 l4">
	      <input type="checkbox" name="cat" onclick="showMe('cat2')" id="cat2" />
	      <label for="cat2">Clothes</label>
	    </div>
	    <div class="col s4 m4 l4">
	      <input type="checkbox" name="cat" onclick="showMe('cat3')" id="cat3" />
	      <label for="cat3">Others</label>
	    </div>
	</div>
<%
	if(session.getAttribute("wishlist_updated") != null){
		if(session.getAttribute("wishlist_updated").equals("true")){
			out.println("<script>$(document).ready(function(){$('#myModal1').openModal();});</script>");
			session.removeAttribute("wishlist_updated");
		}
		else{
			out.println("<script>$(document).ready(function(){$('#myModal').openModal();});</script>");
			session.removeAttribute("wishlist_updated");	
		}
	}
	String search="";
	
	search=request.getParameter("search_bar");
	if(search==null) {
		search="";
	}
	
	ResultSet rs = AccessDatabase.Get_items_on_sale(id, search);
 	HashMap<String, ArrayList<String>> userWishlistInfo = AccessDatabase.GetAlreadyMarkedForBuyingListing(id);
 	int count = 1;
	if(!rs.isBeforeFirst()){
		out.println("No items currently for sale!<br>");
	}
	else{
		%>
		
		<div id="myModal" class="modal">
		    <!-- Modal content-->
		    <div class="modal-content">
		        <h4 class="modal-title">Instructions</h4>
		        <p>Wishlist could not be updated due to some error!</p>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn waves-effect btn-flat modal-action modal-close">Close</button>
		    </div>
		</div>
	
		<div id="myModal1" class="modal">
		    <!-- Modal content-->
		    <div class="modal-content">
		        <h4 class="modal-title">Instructions</h4>
		        <p>Wishlist successfully updated!</p>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn waves-effect btn-flat modal-action modal-close">Close</button>
		    </div>
		</div>
	
		<div class="card-panel">
		<form action="process.jsp" class="col s12" method="post" onsubmit="return verify()">
		<input name="type_of" type="hidden" value="sell_wishlist">
		<%
		StringBuilder sb1 = new StringBuilder();
		StringBuilder sb2 = new StringBuilder();
		StringBuilder current = null;
		while(rs.next()){
			
			ArrayList<String> al = userWishlistInfo.get(rs.getString(2)); 
			
			if(al == null){
				al = new ArrayList<String>();
				al.add("");
				al.add("");
				current = sb2;
			}
			else{
				current = sb1;
			}
			
			current.append("<div class='card-panel' id='entry" + count + "' name='entries'>\n");
			current.append("<span id='e" + count + "' style='color:red'></span><br>\n");
			current.append("<span>Item name: " + rs.getString(3) + "</span><br>\n\t");
			current.append("<span>Description: " + rs.getString(4) + "</span><br>\n\t");
			current.append("<span id='category" + count + "'>Category: " + rs.getString(5) + "</span><br>\n\t");
			current.append("<span>Posted on: " + rs.getTimestamp(10) + "</span><br>\n\t");
			current.append("<span id='q" + count + "'>Quantity remaining: " + rs.getInt(8) + "</span><br>\n\t");
			current.append("<span>Price: " + rs.getInt(9) + "</span><br>\n\t");
			current.append("<ul class='collapsible' data-collapsible='accordion'>");
			current.append("<li><div id= 'b" + count + "' class='collapsible-header light-blue accent-3'>Buy this</div>\n");
			
			
			current.append("<div class='collapsible-body' id='item" + count + "'>\n");
			current.append("<input type='hidden' name='item" + count + "_itemid' value='" + rs.getString(2) + "'>\n");
			current.append("<input type='hidden' name='item" + count + "_owner' value='" + rs.getString(1) + "'>\n");
			current.append("<div class='row'><div class='input-field col s10'><i class='mdi-action-question-answer prefix'></i><textarea name='item" + count + "_specification' value='" + al.get(0) + "' style='min-height:15px;max-height:18px' class='materialize-textarea'></textarea><label for='message'>Message</label></div>\n");
			current.append("<div class='input-field col s2'><i class='mdi-content-add-box prefix'></i><input type='number' min='1' name='item" + count + "_quantity' value='" + al.get(1) + "' ><label for='quantity'>Quantity</label></div></div>\n");
			current.append("</div>\n</li></ul>");
			current.append("</div>\n");
			count++; 
		}
		
		if(sb1.length() != 0){
			out.println("Items you wish to buy:<br>");
			out.println(sb1.toString());
			out.println("<br><hr>");
			out.println("Other items on sale:<br>");
		}
		out.println(sb2.toString());
		out.println("<input type='hidden' name='order_list'><br>");
		out.println("<div id='submit_btn' class='row'><div class='input-field col s2 right'><button type='submit' value='Submit' class='btn waves-effect waves-light col s12'>Submit<i class='mdi-content-send right'></i></button></div></div>");
		out.println("</form></div>"); 
	}
	
%>
</body>
</html>