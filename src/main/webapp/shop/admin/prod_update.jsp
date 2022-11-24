<%@page import="shop.sell.CategoryDao"%>
<%@page import="shop.sell.CategoryBean"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.sell.ProductBean"%>
<%@page import="shop.sell.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<style>
	h2{
		color : aqua;
	}
	
	a{
		text-decoration : none;
	}
	
	table{
	   margin : 0px auto;
	}

</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
	function toggle_layer() {
	if($("#layer1").css("display") == "none"){
		$("#layer1").show();
	}else{
		$("#layer1").hide();
	}
	if($("#layer2").css("display") == "none"){
		$("#layer2").show();
	}else{
		$("#layer2").hide();
	}
	if($("#layer3").css("display") == "none"){
		$("#layer3").show();
	}else{
		$("#layer3").hide();
	}
}
</script>
<%
request.setCharacterEncoding("UTF-8");
ProductDao pdao=ProductDao.getInstance();
String pnum=request.getParameter("pnum");
ProductBean pb=pdao.getProductByNum(pnum);
String[] images=new String[4];
if(pb.getPimage().contains("/")){
	images=pb.getPimage().split("/");
	
}

String pimage = request.getContextPath()+"/shop/images/";
CategoryDao cdao= CategoryDao.getInstance();
ArrayList<CategoryBean> lists = cdao.getCategory("new");

%>
<%@include file="admin_Main_top.jsp"%>
		<form name="myform" action="prod_update_ok.jsp" onsubmit="return check()"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="pcond" value="new">
			<table width="600" >
				<caption><b>상품 수정 FORM</b></caption>
				<tr>
					<th class="m2">상품번호</th>
					<td colspan="5" align="left">
						<%=pb.getPnum() %>
						<input type="hidden" name="pnum" value="<%=pb.getPnum() %>">
					</td>
				</tr>			
				<tr>
					<th>카테고리</th>
					<td colspan="5" align="left">
						<input type="text" name="pcategory_fk" value="<%=pb.getPcategory_fk() %>" readonly>
					</td>
				</tr>
				<tr>
					<th>브랜드</th>
					<td colspan="5" align="left">
					<input type="hidden" name="pseller" value="admin">
						<select name="pbrand">
							<%if(lists.size()==0){%>
							<option>브랜드 없음.</option>
							<% } else {
								HashSet<String> hash=new HashSet<String>();
								for(int i=0;i<lists.size();i++){
									CategoryBean cb=lists.get(i);
									hash.add(cb.getBrand());
								}
								for(String cb2 : hash){
									
							%>
								<option value="<%=cb2 %>">
								<%=cb2%>
								</option>
							<%}} %> 
						</select>
					</td>
				</tr>
				<tr>
					<th>상품명</th>
					<td colspan="5" align="left">
						<input type="text" name="pname" value="<%=pb.getPname()%>">
					</td>
				</tr>
				<tr>
					<th>상품이미지</th>
					<td colspan="5" align="left">
						<input type="file" name="pimage" value='<%=pimage+images[0] %>'>
						<br><img src="<%=pimage+images[0] %>" width=60 height=60>
						<input type="hidden" name="pimages" value="<%=images[0] %>">
					</td>
				</tr>
				<tr>
					<th>상품 수량</th>
					<td colspan="5" align="left">
						<input type="text" name="pqty" value="<%=pb.getPqty()%>">
					</td>
				</tr>
				<tr>
					<th>상품 가격</th>
					<td colspan="5" align="left">
						<input type="text" name="price" value="<%=pb.getPrice()%>">
					</td>
				</tr>
				<tr>
					<th>상품 스펙</th>
					<td colspan="5" align="left">
						<select name="pspec">
							<option value="NORMAL"
							<%if(pb.getPspec().equals("NORMAL")){ %>
							selected<%} %>>::NORMAL::</option>
							<option value="HIT"
							<%if(pb.getPspec().equals("HIT")){ %>
							selected<%} %>>HIT</option>
							<option value="NEW"
							<%if(pb.getPspec().equals("NEW")){ %>
							selected<%} %>>NEW</option>
							<option value="BEST"
							<%if(pb.getPspec().equals("BEST")){ %>
							selected<%} %>>BEST</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>추가이미지</th>
					<td colspan='5' align="left">
					<input type="button" name="tog" value="추가등록" onclick="toggle_layer()">
					</td>					
				</tr>
				<tr style="display: none" id="layer1">
					<th>이미지 1</th>
					<td colspan="5" align="left">
						<input type="file" name="pimage1" 
						<%if(images.length>1&&images[1]!=null) {%> value='<%=pimage+images[1]%>'>	
						<br><img src="<%=pimage+images[1] %>" width=60 height=60>
						<input type="hidden" name="pimages1" value="<%=images[1] %>">	
						<%} %>		
					</td>
				</tr>
				<tr style="display: none" id="layer2">
					<th>이미지 2</th>
					<td colspan="5" align="left">
						<input type="file" name="pimage2"
						<%if(images.length>2&&images[2]!=null) {%> value='<%=pimage+images[2]%>'>
						<br><img src="<%=pimage+images[2] %>" width=60 height=60>
						<input type="hidden" name="pimages2" value="<%=images[2] %>">
						<%} %>
					</td>
				</tr>
				<tr style="display: none" id="layer3">
					<th>이미지 3</th>
					<td colspan="5" align="left">
						<input type="file" name="pimage3"
					 	<%if(images.length>3&&images[3]!=null) {%> value='<%=pimage+images[3]%>'>
					 	<br><img src="<%=pimage+images[3] %>" width=60 height=60>
					 	<input type="hidden" name="pimages3" value="<%=images[3] %>">
					 	<%} %>					
					</td>
				</tr>
				<tr>
					<th>상품 소개</th>
					<td colspan="5" align="left">
						<textarea rows="5" cols="50" name="pcontents" style="resize: none;"><%=pb.getPcontents() %></textarea>
					</td>
				</tr>
				<tr>
					<th>상품 포인트</th>
					<td colspan="5" align="left">
						<input type="text" name="point" value="<%=pb.getPoint()%>">
					</td>
				</tr>				
			</table>
			<input type="submit" value="상품 등록">		
			<input type="reset" value="취 소">		
		</form>	
<%@include file="admin_Main_bottom.jsp"%>