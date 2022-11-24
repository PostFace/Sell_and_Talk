<%@page import="shop.sell.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
cate_delete.jsp<br>
<%
	String cnum=request.getParameter("cnum");
	CategoryDao cdao=CategoryDao.getInstance();
	int result=cdao.deleteCategory(cnum);
	String msg,url;
	if(result>0){
		msg="삭제 성공";
		url="cate_list.jsp";
	} else{
		msg="삭제 실패";
		url="cate_list.jsp";		 
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>
