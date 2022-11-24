<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/Main_top.jsp" %>
<jsp:useBean id="cbean" class="shop.sell.buy.CartBean" scope="session"/>    
<jsp:useBean id="odao" class="shop.sell.buy.OrdersDao" scope="session"/> 
<!-- OrdersDao객체도 하나만 만들기 위해 세션처리 -->   

<%
	int mno=(Integer)session.getAttribute("mno");

	int count=odao.insertOrders(mno,cbean);  

	
	String msg;
	if(count>0){
		msg=count+"개 주문 완료";
		cbean.removeAllProduct();
	} else {
		msg="주문 실패";
	}
%>
<script type="text/javascript">
	alert('<%=msg%>');
	location.href='<%=request.getContextPath()%>/Main.jsp';
</script>
<%@include file="/Main_bottom.jsp" %>