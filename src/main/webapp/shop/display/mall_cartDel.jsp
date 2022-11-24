<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="cbean" class="shop.sell.buy.CartBean" scope="session"/>
<%
	String pnum=request.getParameter("pnum");
	boolean result=cbean.delProduct(pnum);
	String msg;
	if(result){
		msg="삭제 성공";
	} else {
		msg="삭제 실패";		
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href='mall_cartList.jsp';
</script>