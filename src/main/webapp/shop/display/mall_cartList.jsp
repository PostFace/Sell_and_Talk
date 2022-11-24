<%@page import="shop.sell.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/Main_top.jsp" %>
    

<!-- 또 생성되는 것은 아니다. -->
<jsp:useBean id="cbean" class="shop.sell.buy.CartBean" scope="session"/>
<%
Vector<ProductBean> lists=cbean.getLists();
//System.out.println(lists.size());
int totalPrice=0,totalPoint=0;
DecimalFormat df=new DecimalFormat("###,###");
%>
<table border=1  class="table">
	<tr class="m2">
		<th colspan=6 height=50>장바구니 보기</th>
	</tr>
	<tr>
		<th width='10%'>번호</th>
		<th width='20%'>상품명</th>
		<th width='20%'>수량</th>
		<th width='20%'>단가</th>
		<th width='20%'>금액</th>
		<th width='10%'>삭제</th>
	</tr>
	<%
	if(lists.size()==0){
		out.println("<tr><td colspan='6'>선택된 상품이 없습니다.</td></tr>");
	}else{
		for(ProductBean pb : lists){ 
			String[] images=new String[4];
			String imgPath;
			if(pb.getPimage().contains("/")){
				images=pb.getPimage().split("/");
				imgPath=request.getContextPath()+"/shop/images/"+images[0];
			} else {
				imgPath=request.getContextPath()+"/shop/images/"+pb.getPimage();
			}%>
	<tr>
		<td><%=pb.getPnum() %></td>
		<td>
			<img src="<%=imgPath%>" height=50 width=50>
			<br><%=pb.getPname()%>
		</td>
		<td>
			<form name='f' action='mall_cartEdit.jsp' method="post">				
				<input name="pnum" type="hidden" value="<%=pb.getPnum()%>">
				<input name="oqty" type="text" size='2' value="<%=pb.getPqty()%>">
				<input type="submit" value="수정">
			</form>
		</td>
		<td align='right'>
			<font color="navy"><%=df.format(pb.getPrice()) %> 원<br>
			[<%=df.format(pb.getPoint()) %>] point</font>
		</td>
		<td align='right'>
			<font color="red"><%=df.format(pb.getTotalPrice()) %> 원<br>
			[<%=df.format(pb.getTotalPoint()) %>] point</font>
		</td>
		<td><a href="mall_cartDel.jsp?pnum=<%=pb.getPnum()%>">삭제</a></td>
	</tr>
	<%
		totalPrice += pb.getTotalPrice();
		totalPoint += pb.getTotalPoint();
		}%>
	<tr>
		<td colspan='4' align='left'>
			<font color="navy">장바구니 총액 :</font><font color="red"> <%=df.format(totalPrice)%> 원</font> <br>	
			<font color="green">총 적립 포인트 : [<%=df.format(totalPoint)%>] point</font> 			
		</td>
		<td colspan='2'>
			<a href="mall_order.jsp">[주문하기]</a>			
			<a href="mall.jsp">[계속 쇼핑]</a>			
		</td>
	</tr>
	<% } %>
</table>
<%@include file="/Main_bottom.jsp" %>