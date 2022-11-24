<%@page import="shop.sell.buy.OrdersBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- (orders)mno,(members)no join
	 (orders)pnum,(product)pnum join -->
<jsp:useBean id="odao" class="shop.sell.buy.OrdersDao"/>	 
<%
	String mid=request.getParameter("mid");
	ArrayList<OrdersBean> lists=null;
	if(mid!=null){		
		lists=odao.getOrderList(mid);
	}
	DecimalFormat df=new DecimalFormat("###,###");
	int totalPrice=0;
%>	
<%@include file="admin_Main_top.jsp"%>

	<table border="1" width="800"  class="table">
		<tr>
			<td colspan="6" align="center">
			<form name="f" action="shopping_list.jsp">
				조회할 회원 아이디 입력 :
				<input name='mid' type="text">
				<input type="submit" value="내역 조회"> 
			</form>
			</td>
		</tr>
		<tr align="center">
			<td ><B>고객명</B></td>
			<td ><b>판매자명</b></td>
			<td><b>아이디</b></td>
			<td><b>상품명</b></td>
			<td><b>수량</b></td>
			<td><b>금액</b></td>
		</tr>
		<%
		if(lists == null){
			out.println("<tr><td colspan='6'>검색하세요</td></tr>");
		}else if(lists.size()==0){
			out.println("<tr><td colspan='6'>검색결과 없음</td></tr>");
		} else {
			for(OrdersBean ob : lists){ %>
		<tr>
			<td><%=ob.getMname() %></td>
			<td><%=ob.getSellerId() %></td>
			<td><%=ob.getMid() %></td>
			<td><%=ob.getPname() %></td>
			<td><%=ob.getQty() %></td>
			<td>￦<%=df.format(ob.getAmount()) %></td>
		</tr>	
		<%totalPrice += ob.getAmount();
			}
		} %>
		<tr>
			<td colspan='5'>총 합</td>
			<td>￦<%=df.format(totalPrice) %> </td>
		</tr>	
	</table>		
		
<%@include file="admin_Main_bottom.jsp"%>