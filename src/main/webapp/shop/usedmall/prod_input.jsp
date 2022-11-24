<%@page import="java.util.HashSet"%>
<%@page import="shop.sell.CategoryBean"%>
<%@page import="shop.sell.CategoryDao"%>
<%@page import="java.util.ArrayList"%>
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
CategoryDao cdao2=CategoryDao.getInstance();
ArrayList<CategoryBean> lists=cdao2.getCategory("used");
%>
<%@include file="/Main_top.jsp"%>
<%if(mid!=null) {%>
		<form name="myform" action="prod_input_ok.jsp" onsubmit="return check()"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="pcond" value="used">
			<input type="hidden" name="pseller" value='<%=nickname %>'>
			<table width="600" >
				<caption><b>중고 상품 등록 FORM</b></caption>				
				<tr>
					<th>카테고리</th>
					<td colspan="5" align="left">
						<select name="pcategory_fk">
							<%if(lists.size()==0){%>
							<option>카테고리 없음.</option>
							<% } else {
								for(CategoryBean cb : lists){
							%>
							<option value="<%=cb.getCode()%>">
								<%=cb.getCname()%>[<%=cb.getCode()%>]
							</option>
							<%}} %> 
						</select>
					</td>
				</tr>
				<tr>
					<th>브랜드</th>
					<td colspan="5" align="left">
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
						<input type="text" name="pname" placeholder="이름">
					</td>
				</tr>
				<tr>
					<th>상품코드</th>
					<td colspan="5" align="left">
						<input type="text" name="pcode" placeholder="이름">
					</td>
				</tr>
				<tr>
					<th>상품이미지</th>
					<td colspan="5" align="left">
						<input type="file" name="pimage">
					</td>
				</tr>
				<tr>
					<th>상품 수량</th>
					<td colspan="5" align="left">
						<input type="text" name="pqty" value="1" readonly>
					</td>
				</tr>
				<tr>
					<th>상품 가격</th>
					<td colspan="5" align="left">
						<input type="text" name="price" placeholder="100">
					</td>
				</tr>
				<tr>
					<th>상품 스펙</th>
					<td colspan="5" align="left">
						<select name="pspec">
							<option value="NORMAL">::NORMAL::</option>
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
						<input type="file" name="pimage1">					
					</td>
				</tr>
				<tr style="display: none" id="layer2">
					<th>이미지 2</th>
					<td colspan="5" align="left">
						<input type="file" name="pimage2">					
					</td>
				</tr>
				<tr style="display: none" id="layer3">
					<th>이미지 3</th>
					<td colspan="5" align="left">
						<input type="file" name="pimage3">					
					</td>
				</tr>
				<tr>
					<th>상품 소개</th>
					<td colspan="5" align="left">
						<textarea rows="5" cols="50" name="pcontents" style="resize: none;">설명</textarea>
					</td>
				</tr>
				<tr>
					<th>상품 포인트</th>
					<td colspan="5" align="left">
						<input type="text" name="point" value="0" readonly>
					</td>
				</tr>				
			</table>
			<input type="submit" value="상품 등록">		
			<input type="reset" value="취 소">		
		</form>	
		<%}else{ %>
		<script type="text/javascript">
			alert('로그인 후 이용 가능합니다.');
			location.href="<%=request.getContextPath()%>/Main.jsp"
		</script>
		<%} %>
<%@include file="/Main_bottom.jsp"%> 