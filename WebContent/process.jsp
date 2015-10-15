<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="database.UpdateDatabase" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	String id = "", name;
	boolean logged_in = false;
	if(session.getAttribute("user_logged_in") == null){
		out.println("<script>window.location.assign('index.jsp')</script>");
	}
	else{
		if(session.getAttribute("id") != null)
			id = session.getAttribute("id").toString();
		if(session.getAttribute("username") != null)
			name = session.getAttribute("username").toString();
		logged_in = true;
	}
	System.out.println(request.getParameter("type_of") + logged_in);
	if(logged_in && request.getParameter("type_of") != null){
		String type = request.getParameter("type_of");
		if(type.equals("add_listing")){
			String item_name = request.getParameter("item_name");
			String item_description = request.getParameter("item_description");
			String item_category = request.getParameter("item_category");
			int item_price = Integer.parseInt(request.getParameter("item_price"));
			int item_quantity = Integer.parseInt(request.getParameter("item_quantity"));
			String item_biddable = request.getParameter("item_biddable");
			int item_bidding_price = -1;
			if(!item_biddable.equals("no")){
				item_bidding_price = Integer.parseInt(request.getParameter("item_bidding_price"));
			}
			
			// execute insert
			boolean success = UpdateDatabase.AddSellingListing(id, item_name, item_description, item_category, item_price, item_quantity, item_biddable, item_bidding_price);
			if(success){
				session.setAttribute("item_sell_insert", "true");
			}
			else session.setAttribute("item_sell_insert", "false");
			out.println("<script>window.location.assign('add_listing.jsp')</script>");
		}
		else{
			//System.out.println("Errorrrrr!");
		}
	}
	
%>
<body>

</body>
</html>