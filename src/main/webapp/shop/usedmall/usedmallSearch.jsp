<%@page import="java.text.DecimalFormat"%>
<%@page import="shop.sell.ProductBean"%>
<%@page import="shop.sell.ProductDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
request.setCharacterEncoding("UTF-8");
ProductDao pdao = ProductDao.getInstance();
String imgPath = request.getContextPath() + "/shop/images/";
String[] spec = { "NORMAL" };
int count = 0;
DecimalFormat df = new DecimalFormat("###,###");
String search = request.getParameter("search");
%>
<%@include file="/Main_top.jsp"%>
<br>

<table width='600' align='center'>
	<tr align='center'>
		<td>
			<form action="usedmallSearch.jsp">
				<input type="text" name="search" placeholder="검색할 제품 입력" height="40"
					maxlength="10"> &nbsp;|&nbsp; <input type="submit"
					class="btn" value="검색">
			</form>
		</td>
	</tr>
</table>
<br>
<br>
<b><%=search%> 검색 결과</b>

<br>
<%
for (int i = 0; i < spec.length; i++) {
	ArrayList<ProductBean> prodList = pdao.getProductBySearchSpec(search, spec[i], "used");
%>
<input type="button" value="상품등록하기"
	onclick="location.href='prod_input.jsp'" class="btn"
	style="float: right">
<br>

<hr color='green' width="80%">
<font color='red'><strong>전체 상품(<%=prodList.size()%>개)
</strong></font>
<hr color='green' width="80%">
<%
if (prodList.size() == 0) {
%>
아직 상품이 없습니다.
<%
} else {
%>
<table width='600' align='center'>
	<tr align='center'>
		<%
		for (ProductBean pb : prodList) {
			String[] images = new String[4];
			if (pb.getPimage().contains("/")) {
				images = pb.getPimage().split("/");
			} else {
				images[0] = pb.getPimage();
			}
			count++;
			if (count % 3 == 1) {
				out.print("</tr><tr align='center'>");
			}
		%>
		<td><a
			href="<%=cPath%>/shop/display/mall_prodView.jsp?pnum=<%=pb.getPnum()%>"><img
				src="<%=imgPath + images[0]%>" width='80' height='80'><br>
				<%=pb.getPname()%><br> <font color='red'><%=df.format(pb.getPrice())%></font>원<br>
				<font color='blue'>[<%=df.format(pb.getPoint())%>]
			</font>포인트<br></a> <br></td>
		<%
		}
		%>
	</tr>
</table>
<%
}
}
%>
<%@include file="/Main_bottom.jsp"%>
