<%@page import="java.text.DecimalFormat"%>
<%@page import="shop.sell.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.sell.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script type="text/javascript">
	function checkDel(pnum,pimage){
		//alert(pnum+','+pimage);
		var isdel=window.confirm("정말로 삭제하시겠습니까?");
		if(isdel){
			location.href="prod_delete.jsp?pnum="+pnum+"&pimage="+pimage;
		}
	}
</script>
<style type="text/css">
	th{
		text-align: right;
	}
</style>
<%@include file="/Main_top.jsp"%>    
<%if(mid!=null){ %>
<br><br>
<b>내가 등록한 상품</b><br>

	<table width='95%'>
				<caption><b>상품 목록</b></caption>
				<tr>
					<td>
						<input type="button" value="상품등록하기" onclick="location.href='prod_input.jsp'" class="btn">
					</td>
				</tr>
				<tr align="center">
					<th>   번호</th>
					<th>    상품코드</th>
					<th>    상품명</th>
					<th>   이미지</th>
					<th>   가격</th>
					<th>   제조사</th>
					<th>   수량</th>
					<th>   수정 | 삭제</th>
				</tr>
<%
ProductDao pdao=ProductDao.getInstance();
ArrayList<ProductBean> lists=pdao.getSellerProduct(nickname); 
String sContext= request.getContextPath()+"/shop/images/";
DecimalFormat df=new DecimalFormat("###,###");
if(lists.size()==0){
	out.print("<tr><td colspan='8'>조회된 상품 없음</td></tr>");
} else{
	for(ProductBean pb : lists){
		String[] img=new String[4];
		if(pb.getPimage()!=null){
			img=pb.getPimage().split("/");	
		}
		
	String fullpath=sContext+img[0];
	%>
				<tr>
					<td><%=pb.getPnum()%></td>
					<td><%=pb.getPcategory_fk() %></td>
					<td><%=pb.getPname()%></td>
					<td><img src="<%=fullpath%>" width="60" height="60"></td>
					<td><%=df.format(pb.getPrice())%></td>
					<td><%=pb.getPbrand()%></td>
					<td><%=pb.getPqty()%></td>
					<td>
						<a href="prod_update.jsp?pnum=<%=pb.getPnum()%>">수정</a>|
						<a href="javascript:checkDel('<%=pb.getPnum()%>','<%=pb.getPimage()%>')" >삭제</a><!-- a태그를 통해 함수 호출시 -->
					</td>
				</tr>
<% 	}
}%>
			</table>
			
<%}//if
else{%>
<script type="text/javascript">
	alert('로그인 후 이용가능합니다.');
	location.href="<%=request.getContextPath()%>/Main.jsp";
</script>
<%
	
}%>
			<%@include file="/Main_bottom.jsp"%>    