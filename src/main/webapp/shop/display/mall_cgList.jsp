<%@page import="java.text.DecimalFormat"%>
<%@page import="shop.sell.ProductBean"%>
<%@page import="shop.sell.ProductDao"%>

<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	//request.setCharacterEncoding("UTF-8"); //get방식일땐 굳이 한글처리 안해줘도 된다.
	String code=request.getParameter("code");
	String cond=request.getParameter("cond");
	String cname=request.getParameter("cname");
	ProductDao pdao=ProductDao.getInstance();
	ArrayList<ProductBean> lists=pdao.getProductByCode(code,cond); 
	int count=0;
	DecimalFormat df=new DecimalFormat("###,###");
%> 
<%@include file="/Main_top.jsp" %> 


<h3><b>Welcome to My Mall</b></h3>
<hr color='green' width="80%">
<font color='red' size='3'><strong><%=cname.toUpperCase() %></strong></font>
<hr color='green' width="80%">  <br><br>
<table width='600' align='center'>
	<tr align='center'>
		<% 
		if(lists.size()==0){
			out.print("<td>해당 카테고리에 상품이 없습니다.</td>");
		}else{
			for(ProductBean pb :lists){ 
						if(count%3==0){
							out.print("</tr><tr align='center'>");
						}
						count++;
						String[] images=new String[4];
						String imgPath;
						if(pb.getPimage().contains("/")){
							images=pb.getPimage().split("/");
							imgPath=request.getContextPath()+"/shop/images/"+images[0];
						} else {
							imgPath=request.getContextPath()+"/shop/images/"+pb.getPimage();
						}
					%>
		<td ><a href="mall_prodView.jsp?pnum=<%=pb.getPnum()%>"><img src="<%=imgPath%>" width='120' height='120'><br>
			<%=pb.getPname() %><br> <font color='red'><%=df.format(pb.getPrice()) %></font>원<br>
			<font color='blue'>[<%=df.format(pb.getPoint()) %>]
		</font>포인트<br></a>
		<br></td>
		<%} 
		}%>
	</tr>
</table>
<%@include file="/Main_bottom.jsp" %>   