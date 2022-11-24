<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
	function check(){
		if(document.f.code.value==""){
			alert('카테고리 코드를 입력하세요.');
			f.code.focus();
			return false;
		}
		if(document.f.cname.value==""){
			alert('카테고리 이름을 입력하세요.');
			f.cname.focus();
			return false;
		}
	}
</script>  
<%@include file="admin_Main_top.jsp" %>      

<form action="cate_input_ok.jsp" method="POST" name="f">
	<table border=1 width=350 align=center  class="table">
	<caption><b>카테고리 등록</b></caption>
		<tr>
			<td align="center"><b>제품 상태</b></td>
			<td>
			<input type="hidden" name="cnum">
			<select name="cond">
				<option value="new">새상품</option>
				<option value="used">중고</option>
			</select>
			</td>
		</tr>
		<tr>
			<td align="center"><b>브랜드</b></td>
			<td>
			<input type=text name="brand">
			</td>
		</tr>
		<tr>
			<td align="center"><b>카테고리 코드</b></td>
			<td>
			<input type=text name="code">
			</td>
		</tr>
		<tr>
			<td align="center"><b>카테고리 이름</b></td>
			<td>
			<input type=text name="cname">
			</td>
		</tr>
		<tr>
			<td colspan=2 align="center">
			<input type=submit value="등록하기" onclick="return check()"> 
			<input type=reset value="취소" > 
			</td>
		</tr>
	</table>
</form>

<%@include file="admin_Main_bottom.jsp" %>  