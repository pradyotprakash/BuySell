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
	String id = "", name="";
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
	System.out.println(request.getParameter("item_name"));
	if(logged_in && request.getParameter("type_of") != null){
		String type = request.getParameter("type_of");
		if(type.equals("add_listing")){
			String item_name = request.getParameter("item_name");
			String item_description = request.getParameter("item_description");
			String item_category = request.getParameter("item_category");
			//String photo = request.getParameter("photo");
			
			int item_price = Integer.parseInt(request.getParameter("item_price"));
			int item_quantity = Integer.parseInt(request.getParameter("item_quantity"));
			
			// execute insert
			boolean success = UpdateDatabase.AddSellingListing(id, item_name, item_description, item_category, item_price, item_quantity);
			if(success){
				session.setAttribute("item_sell_insert", "true");
			}
			else{
				session.setAttribute("item_sell_insert", "false");
			}
			System.out.println(type);

			out.println("<script>window.location.assign('add_listing.jsp')</script>");
		}
		else if(type.equals("add_listing_buy")){
			String item_name = request.getParameter("item_name");
			String item_description = request.getParameter("item_description");
			String item_category = request.getParameter("item_category");
			String item_comments = request.getParameter("item_comments");
			int item_price1 = Integer.parseInt(request.getParameter("item_price1"));
			int item_price2 = Integer.parseInt(request.getParameter("item_price2"));
			int item_quantity = Integer.parseInt(request.getParameter("item_quantity"));

			
			// execute insert
			boolean success = UpdateDatabase.AddBuyingListing(id, item_name, item_description, item_category, item_comments, item_price1, item_price2, item_quantity);
			if(success){
				session.setAttribute("item_buy_insert", "true");
			}
			else session.setAttribute("item_buy_insert", "false");
			out.println("<script>window.location.assign('add_listing_buy.jsp')</script>");
		}
		
		else if(type.equals("sell_wishlist")){
			
			String orderList = request.getParameter("order_list");
			int count = orderList.length() - orderList.replace(",", "").length();
			if(orderList.length() == 0 || count == 0){
				session.setAttribute("wishlist_updated", "false");
				out.println("<script>window.location.assign('add_wishlist.jsp')</script>");
			}
			else{
				String[] entriesToUpdate = orderList.split(",");
				
				for(int i=0;i<entriesToUpdate.length;++i){
					String index = entriesToUpdate[i];
					// check if already present in the database
					String itemid = request.getParameter("item" + index + "_itemid");
					
					// insert
					String owner = request.getParameter("item" + index + "_owner");
					String specification = request.getParameter("item" + index + "_specification");
					String quantity1 = request.getParameter("item" + index + "_quantity");
					Integer quantity = Integer.parseInt(quantity1);
					boolean success = UpdateDatabase.AddToSellWishlist(id, itemid, specification, quantity);
					
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
		else if(type.equals("sell_item")){
			
			String itemid = request.getParameter("id");
			String owner = request.getParameter("owner");
			String buyer = request.getParameter("buyer");
			String quantity1 = request.getParameter("quantity");
			Integer quantity = Integer.parseInt(quantity1);
			boolean success = UpdateDatabase.Sell_item(itemid, buyer, owner, quantity);
			if(success){
				session.setAttribute("Selling_Successful", "true");
				out.println("<script>window.location.assign('see_listings.jsp')</script>");
			}
			else{
				session.setAttribute("Selling_Successful", "false");
				out.println("<script>window.location.assign('see_listings.jsp')</script>");
			}
		}
	}
	
%>
<body>

</body>
</html>