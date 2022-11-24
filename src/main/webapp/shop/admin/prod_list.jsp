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
<%@include file="admin_Main_top.jsp"%>    



	<table width='95%'  class="table">
				<caption><b>상품 목록</b></caption>
				<tr class="text-center">
					<th class="text-center">번호</th>
					<th class="text-center">상품코드</th>
					<th class="text-center">상품명</th>
					<th class="text-center">이미지</th>
					<th class="text-center">가격</th>
					<th class="text-center">제조사</th>
					<th class="text-center">수량</th>
					<th class="text-center">수정|삭제</th>
				</tr>
<%
ProductDao pdao=ProductDao.getInstance();
ArrayList<ProductBean> lists=pdao.getAllProduct("new");
String sContext= request.getContextPath()+"/shop/images/";
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
					<td><%=pb.getPrice()%></td>
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
			<%@include file="admin_Main_bottom.jsp"%>    