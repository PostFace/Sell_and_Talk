<%@page import="shop.sell.ProductBean"%>
<%@page import="shop.sell.ProductDao"%>
<%@page import="java.text.DecimalFormat"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/Main_top.jsp"%>
<style type="text/css">
	body{
		text-align: center;
	}
	table{
		text-align: left;
		align: center;
		margin: auto;
	}
</style>  
<script type="text/javascript">
	function goCart(pnum){
		//alert(1);
		if(document.f.oqty.value<=0||document.f.oqty.value.length==0){
			alert('상품 갯수는 1개 이상 입력해야합니다.');
			return;
		}
		location.href="mall_cartAdd.jsp?oqty="+f.oqty.value+"&pnum="+pnum;
	}
	function goOrder(pnum){
		//alert(1);
		if(document.f.oqty.value<=0||document.f.oqty.value.length==0){
			alert('상품 갯수는 1개 이상 입력해야합니다.');
			return;
		}
		document.f.action="mall_order.jsp?pnum="+pnum;//?oqty="+f.oqty.value+"&;
		document.f.submit();
	}
</script>   

<%
	String pnum= request.getParameter("pnum");
	ProductDao pdao=ProductDao.getInstance();
	ProductBean pb=pdao.getProductByNum(pnum);
	String[] images=new String[4];
	String[] imgPath=new String[4];
	if(pb.getPimage().contains("/")){
		images=pb.getPimage().split("/");
		imgPath[0]=request.getContextPath()+"/shop/images/"+images[0];
		if(images.length>1){
			imgPath[1]=request.getContextPath()+"/shop/images/"+images[1];
		}
		if(images.length>2){
			imgPath[2]=request.getContextPath()+"/shop/images/"+images[2];
		}
		if(images.length>3){
			imgPath[3]=request.getContextPath()+"/shop/images/"+images[3];
		}
	} else {
		imgPath[0]=request.getContextPath()+"/shop/images/"+pb.getPimage();
	}
	DecimalFormat df=new DecimalFormat("###,###");//텍스트 형식 지정 12,333,333,555,666처럼 계속 3자리마다 쉼표가 찍힌다.
%>
<table width=100% class='outline'>
	<tr class='m1' align="center">
		<th colspan='2'>
			<font color='green' size=3>[<%=pb.getPname()%>] 상품 정보</font>
		</th>
	</tr>
	<tr height='300' width=50%>
		<td class='m3' align='center'><img src="<%=imgPath[0]%>" width="200" height="200"></td>
		<td class='m3'>
		<form name='f' method='post' <%-- action="mall_order.jsp?pnum=<%=pb.getPnum()%>" --%>>
		상품 번호: <%=pb.getPnum() %>	<br>		
		상품 이름: <%=pb.getPname() %>	<br>
		판매자 :  <%=pb.getPseller() %><br>
		상품 가격:<font color='red'><strong>[<%=df.format(pb.getPrice())%>]</strong></font>원	<br>
		상품 포인트: <font color='red'><strong>[<%=df.format(pb.getPoint())%>]</strong></font> point
		<br>상품 갯수: 
		<input type="text" size="3" maxlength="3" name='oqty' value="1">개 <br>	
			<table align="left">
				<tr align="left">
					<td>
					<a href="javascript:goCart('<%=pb.getPnum() %>')">
				<input type="button" value="장바구니 담기" class="btn btn-primary"> 
					 <!-- <img src="../../images/cartbtn.gif" width=100 height=40> --> 					
					</a>
					</td>
					<td>
					<a href="javascript:goOrder('<%=pb.getPnum() %>')">
					<input type="button" value="즉시 구매하기" class="btn btn-success"> 
					<!-- <img src="../../images/orderbtn.gif" width=100 height=40> -->
					</a>
					</td>
				</tr>
			</table>
		</form>
		</td>
	</tr>
	<tr height='200' valign="top">
		<td colspan='2'>
		<b>상품 상세 설명</b><br>
			<%=pb.getPcontents() %><br>
		<%if(imgPath[1]!=null){%>
			<img src="<%=imgPath[1]%>"><br>
		<%}%>
		<%if(imgPath[2]!=null){%>
			<img src="<%=imgPath[2]%>"><br>
		<%}%>
		<%if(imgPath[3]!=null){%>
			<img src="<%=imgPath[3]%>"><br>
		<%}%>
		</td>
	</tr>
</table>
<%@include file="/Main_bottom.jsp"%>