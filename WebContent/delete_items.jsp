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
		
	function showMe(id,s,l1) {
		var count = document.getElementsByName('entries').length;
	    var chboxs = document.getElementById(id);
		if(first_time) {
			for(var i=1;i<=count;i++) { 
				document.getElementById('entry'+i).style.display = "none";
			}
			first_time=false;
		}
	    for(var i=1;i<=count;i++) {
	        if(chboxs.checked == true){
		         var category = document.getElementById('category'+i).innerHTML;
				 if(category=="Category: "+s) {
		        	 document.getElementById('entry'+i).style.display = "block";
		         }
	        }
	        if(chboxs.checked == false){
		         var category = document.getElementById('category'+i).innerHTML;
				 if(category=="Category: "+s) {
		        	 document.getElementById('entry'+i).style.display = "none";
		         }
	        }
	    }
	    var j=1;
        var none_selected=true;
        for(j=1;j<l1;j++) {
	        if(document.getElementById('cat'+j).checked == true){
		        none_selected=false;
		        break;
	        }
        }
        if(document.getElementById('Others').checked == true){
	        none_selected=false;
        }
        if(none_selected==true){
        	for(var i=1;i<=count;i++) {
        		document.getElementById('entry'+i).style.display = "block";
        	}
	        first_time=true;
        }
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
<title>Delete items</title>
</head>

<body>
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
<%
		ArrayList<String> al1 = AccessDatabase.GetExistingCategories();
		int l=al1.size();
		int l1=al1.size();
		if(12/l == 0){
			l=12;
		}
		int i=1;
		for(String s : al1){
			if(s.equals("Others")){
				continue;
			}
			out.println("<div class='col s" + 12/l + " m" + 12/l +" l" + 12/l + "'>");
			out.println("<input type='checkbox' name='cat' onclick=\"showMe('cat"+i+"','"+s+"',"+l1+")\" id='cat"+i+"' />");
			out.println("<label for='cat"+i+"'>"+s+"</label></div>");
			i++;
		}
		out.println("<div class='col s" + 12/l + " m" + 12/l +" l" + 12/l + "'>");
		out.println("<input type='checkbox' name='cat' onclick=\"showMe('Others','Others',"+l1+")\" id='Others' />");
		out.println("<label for='Others'>Others</label></div>");
%>
	</div>
<%
	if(session.getAttribute("items_updated") != null){
		if(session.getAttribute("items_updated").equals("true")){
			out.println("<script>$(document).ready(function(){$('#myModal1').openModal();});</script>");
			session.removeAttribute("items_updated");
		}
		else{
			out.println("<script>$(document).ready(function(){$('#myModal').openModal();});</script>");
			session.removeAttribute("items_updated");	
		}
	}
	String search="";
	
	search=request.getParameter("search_bar");
	if(search==null) {
		search="";
	}
	
	ResultSet rs = AccessDatabase.Get_items_on_sale(id, search);
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
		        <p>Item list could not be updated due to some error!</p>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn waves-effect btn-flat modal-action modal-close">Close</button>
		    </div>
		</div>
	
		<div id="myModal1" class="modal">
		    <!-- Modal content-->
		    <div class="modal-content">
		        <h4 class="modal-title">Instructions</h4>
		        <p>Item list successfully updated!</p>
		    </div>
		    <div class="modal-footer">
		    	<button type="button" class="btn waves-effect btn-flat modal-action modal-close">Close</button>
		    </div>
		</div>
	
		<div class="card-panel">
		<form action="process.jsp" class="col s12" method="post" onsubmit="populate_input_field()">
		<input name="type_of" type="hidden" value="delete_items">
		<%
		StringBuilder current = new StringBuilder();
		while(rs.next()){
									
			current.append("<div class='card-panel' id='entry" + count + "' name='entries'>\n");
			current.append("<div>\n");
			current.append("<span onclick='mark_for_deletion(" + count + ")' id='d" + count + "' class='btn waves-effect waves-light col s4'>Delete</span>\n");
			current.append("</div>\n<br>\n");
			current.append("<span>Item name: " + rs.getString(3) + "</span><br>\n\t");
			current.append("<span>Description: " + rs.getString(4) + "</span><br>\n\t");
			current.append("<span id='category" + count + "'>Category: " + rs.getString(5) + "</span><br>\n\t");
			current.append("<span>Posted on: " + rs.getTimestamp(10) + "</span><br>\n\t");
			current.append("<span id='q" + count + "'>Quantity remaining: " + rs.getInt(8) + "</span><br>\n\t");
			current.append("<span>Price: " + rs.getInt(9) + "</span><br>\n\t");
			
			current.append("<input type='hidden' name='item" + count + "_itemid' value='" + rs.getString(2) + "'>\n");
			current.append("<input type='hidden' name='item" + count + "_owner' value='" + rs.getString(1) + "'>\n");
			current.append("</div>\n");
			count++; 
		}
		
		out.println(current.toString());
		out.println("<input type='hidden' name='deletion_list'><br>");
		out.println("<div id='submit_btn' class='row'><div class='input-field col s2 right'><button type='submit' value='Submit' class='btn waves-effect waves-light col s12'>Submit<i class='mdi-content-send right'></i></button></div></div>");
		out.println("</form></div>"); 
	}
	
%>
</body>
<script>
	deletion_list = [];
	function mark_for_deletion(curr){
		var s = document.getElementsByName("item" + curr + "_itemid")[0].value;
		var index = deletion_list.indexOf(s); 
		if(index > -1){
			deletion_list.splice(index, 1);
			document.getElementById("d" + curr).innerHTML = "Delete";
		}
		else{
			deletion_list.push(s);
			document.getElementById("d" + curr).innerHTML = "Marked for deletion";
		}
	}
	
	function populate_input_field(){
		document.getElementsByNames("deletion_list")[0].value = deletion_list;
		return true;
		
	}
	</script>
</html>