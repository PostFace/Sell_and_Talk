<%@page import="shop.sell.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
cate_input_form.jsp=>cate_input_ok.jsp<br>
<% 
	request.setCharacterEncoding("UTF-8");	
%>
<jsp:useBean id="cb" class="shop.sell.CategoryBean"/>
<jsp:setProperty property="*" name="cb"/>
<% 
	CategoryDao cdao=CategoryDao.getInstance(); 
	int result=cdao.insertCategory(cb);
	String msg,url;	
	if(result>0){ 
		msg="입력 성공";
		url="cate_list.jsp";
	} else {
		msg="입력 실패";
		url="cate_input_form.jsp";		
	}
%>
<script type="text/javascript">
	alert('<%=msg%>');
	location.href="<%=url%>";
</script>