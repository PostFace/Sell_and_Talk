<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- session : mid,mno,cbean,odao -->
<% 
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/Main.jsp");
%>