
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="cbean" class="shop.sell.buy.CartBean" scope="session"/>
<% 
	String oqty=request.getParameter("oqty");
	String pnum=request.getParameter("pnum");
	cbean.setEdit(pnum, oqty);
	response.sendRedirect("mall_cartList.jsp");
%>