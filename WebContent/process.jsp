<%@page import="database.AccessDatabase"%>
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
	

	if(logged_in && request.getParameter("type_of") != null){
		String type = request.getParameter("type_of");
		if(type.equals("add_listing")){
			String item_name = request.getParameter("item_name");
			String item_description = request.getParameter("item_description");
			String item_category = request.getParameter("item_category");
			
			int item_price = Integer.parseInt(request.getParameter("item_price"));
			int item_quantity = Integer.parseInt(request.getParameter("item_quantity"));

			
			// execute insert
			boolean success = UpdateDatabase.AddSellingListing(id, item_name, item_description, item_category, item_price, item_quantity);
			if(success){
				session.setAttribute("item_sell_insert", "true");
			}
			else session.setAttribute("item_sell_insert", "false");
			out.println("<script>window.location.assign('add_listing.jsp')</script>");
		}
		
		else if(type.equals("sell_wishlist")){
			
			String orderList = request.getParameter("order_list");
			int count = orderList.length() - orderList.replace(",", "").length();
			if(orderList.length() == 0 || count==0){
				session.setAttribute("wishlist_updated", "true");
				out.println("<script>window.location.assign('add_wishlist.jsp')</script>");
				System.out.println("YOYO " + orderList);
			}
			else{
				ArrayList<String> itemsAlreadyInWishlist = AccessDatabase.GetItemsInWishlistForUser(id);
				String[] entriesToUpdate = orderList.split(",");
				
				for(int i=0;i<entriesToUpdate.length;++i){
					String index = entriesToUpdate[i];
					// check if already present in the database
					String itemid = request.getParameter("item" + index + "_itemid");
					
					// insert
					String owner = request.getParameter("item" + index + "_owner");
					String specification = request.getParameter("item" + index + "_specification");
					
					boolean success = UpdateDatabase.AddToSellWishlist(id, itemid, specification);
					
					if(success){
						session.setAttribute("wishlist_updated", "true");
						out.println("<script>window.location.assign('add_wishlist.jsp')</script>");
					}
					else{
						session.setAttribute("wishlist_updated", "false");
						out.println("<script>window.location.assign('add_wishlist.jsp')</script>");
					}
				}
			}	
		}
		else if(type.equals("add_message")){
			String receiver = session.getAttribute("receiver_id").toString();
			String message = request.getParameter("message_text").toString();
			
			boolean success = UpdateDatabase.InsertMessageIntoDatabase(id, receiver, message);
			session.setAttribute("refresh_message_frame", "true");
			out.println("<script>window.location.assign('message_input.jsp')</script>");
		}
	}
	
%>
<body>

</body>
</html>