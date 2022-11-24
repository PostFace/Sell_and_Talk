<%@page import="shop.sell.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.sell.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="admin_Main_top.jsp" %>      

<table border='1' valign='top' class="table">
		<caption><b>카테고리 목록</b></caption>
	<tr>
		<th>번호</th>
		<th>브랜드</th>
		<th>카테고리 코드</th>
		<th>카테고리명</th>
		<th>수정</th>
		<th>삭제</th>
	</tr> 
	<%
	request.setCharacterEncoding("UTF-8");
	CategoryDao cdao=CategoryDao.getInstance();
	ArrayList<CategoryBean> newLists=cdao.getCategory("new"); 
	%>
	<tr><td colspan='6'><b>  새상품</b></td></tr>
	<%if(newLists.size()==0){%>
	<tr><td colspan='6'>해당 카테고리가 없습니다.</td></tr>	
	<% } else{
			for(CategoryBean cb: newLists){ %>
	<tr>
		<td><%=cb.getCnum() %></td>		
		<td><%=cb.getBrand() %></td>
		<td><%=cb.getCode() %></td>
		<td><%=cb.getCname() %></td>
		<td><a href="cate_update_form.jsp?cnum=<%=cb.getCnum() %>">수정</a></td>
		<td><a href="cate_delete.jsp?cnum=<%=cb.getCnum() %>">삭제</a></td>
	</tr>
	<%}
	}%>
	<tr><td colspan='6'><b>  중고</b></td></tr>
	<%ArrayList<CategoryBean> usedLists=cdao.getCategory("used"); 
	if(usedLists.size()==0){%>
	<tr><td colspan='6'>해당 카테고리가 없습니다.</td></tr>	
	<% } else{
			for(CategoryBean cb: usedLists){ %>
	<tr>
		<td><%=cb.getCnum() %></td>		
		<td><%=cb.getBrand() %></td>
		<td><%=cb.getCode() %></td>
		<td><%=cb.getCname() %></td>
		<td><a href="cate_update_form.jsp?cnum=<%=cb.getCnum() %>">수정</a></td>
		<td><a href="cate_delete.jsp?cnum=<%=cb.getCnum() %>">삭제</a></td>
	</tr>
	<%}
	}%>
</table>
<%@include file="admin_Main_bottom.jsp" %>  