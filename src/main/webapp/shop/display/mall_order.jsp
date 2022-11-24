<%@page import="shop.sell.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/Main_top.jsp" %>
<jsp:useBean id="cbean" class="shop.sell.buy.CartBean" scope="session"/>
<%
String pnum=request.getParameter("pnum");
String oqty=request.getParameter("oqty");
//System.out.println(pnum+"/"+oqty);
if(pnum!=null&&oqty!=null){
	cbean.addProduct(pnum, oqty);
}
Vector<ProductBean> lists=cbean.getLists();  
int totalPrice=0;
DecimalFormat df=new DecimalFormat("###,###");
%>	
<script type="text/javascript">
	function check(){
		alert('로그인 후 주문 가능합니다.');
	}
</script>	
<table border="1" width=90%  class="table" align="center">
  <tr class="m2">
    <td colspan="4">
    	<b>결제 내역서 보기</b>
    </td>
  </tr>
  <tr class="m1">
    <th width="30%">상품명</th>
    <th width="10%">상품상태</th>
    <th width="20%">수량</th>
    <th width="40%">금액</th>
  </tr>
  <%for(ProductBean pb : lists){ %>
  <tr height=60 style="text-align: center">
 		<td><%=pb.getPname() %><br></td> 
 		<td><%=pb.getPcond() %><br></td> 
 		<td><%=pb.getPqty() %><br></td> 
 		<td align="right"><%=df.format(pb.getTotalPrice()) %><br></td> 
  </tr>
  <%
  	totalPrice += pb.getTotalPrice();
  } %>
  <tr class="m1">
  	<td colspan="4" height=40>
  		<b>결제하실 총액은</b> : 
  		<font color="red"><%=df.format(totalPrice) %></font><br>
  	</td>
  </tr>
</table>
<br>
<%if(mid!=null){ %>
<input type="button" value="결제하기" onclick="location.href='mall_calculate.jsp'">
<%}else{ %>
<input type="button" value="결제하기" onclick="javascript : check()">
<%} %>	
<%@include file="/Main_bottom.jsp" %>