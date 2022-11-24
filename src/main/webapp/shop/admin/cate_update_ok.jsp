<%@page import="shop.sell.CategoryBean"%>
<%@page import="shop.sell.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
cate_input_form.jsp=>cate_input_ok.jsp<br>
<%
	request.setCharacterEncoding("UTF-8");
	int cnum=Integer.parseInt(request.getParameter("cnum"));
	String cond=request.getParameter("cond");
	String brand=request.getParameter("brand");
	String code=request.getParameter("code");
	String cname=request.getParameter("cname");
	CategoryDao cdao=CategoryDao.getInstance();
	CategoryBean cb=new CategoryBean();
	cb.setCnum(cnum);
	cb.setCond(cond);
	cb.setBrand(brand);
	cb.setCode(code);
	cb.setCname(cname);
	int result=cdao.updateCategory(cb);
	String msg,url;
	if(result>0){
		msg="수정 성공";
		url="cate_list.jsp";
	} else{
		msg="수정 실패";
		url="cate_input_form.jsp?cnum="+cnum;		 
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>