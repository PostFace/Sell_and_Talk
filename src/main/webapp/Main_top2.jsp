<%@page import="shop.sell.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.sell.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>세상의 모든 신발 Sell and Talk!</title>

<!-- Bootstrap -->
<link href="<%=request.getContextPath()%>/css/bootstrap.min.css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/kfonts2.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/style.css">
</head>
Main_top.jsp
<br>

<style type="text/css">
table {
	text-align: center;
	align: center;
	margin: auto;
}

.logout {
	float: right;
	color: #fff;
}
</style>
<%request.setCharacterEncoding("UTF-8");
CategoryDao cdao=CategoryDao.getInstance();
ArrayList<CategoryBean> cateList=cdao.getAllCategory();
String cPath=request.getContextPath();%>
<!DOCTYPE>
<body>
	<table align='center' class="table" class="container fluid">
		<tr align='center'>
			<th colspan='2' align='center' height=40>
				<div class="container">
					<div class="col-md-1"></div>
					<div class="NavbarDesktop_header__1GIWM">
						<div class="NavbarDesktop_width-box__FLokA">
							<div class="NavbarDesktop_flex-wrapper__3w9VA">
								<a href="<%=cPath%>/Main.jsp" class="head">HOME</a> |
								<%
			String mid=(String)session.getAttribute("mid");
			String nickname=(String)session.getAttribute("nickname");
			if(mid!=null){
				if(mid.equals("admin")){ %>

								<a href="<%=cPath%>/shop/admin/admin_Main.jsp" class="head">관리자홈</a>
								|
								<%}} %>
								<a href="<%=cPath%>/shop/display/mall.jsp" class="head">상품 전체 보기</a>
								|<a href="<%=cPath%>/shop/display/mall.jsp" class="head"
							>공식 판매 상품</a>
							 |<a href="<%=cPath%>/shop/usedmall/usedmall.jsp"
							class="head">중고 상품</a>
								|<a href="<%=cPath%>/shop/display/mall_cartList.jsp"
									class="head">장바구니</a> |
								<div class="row">

									<%if(mid==null) {%>
									<a href="<%=cPath%>/shop/member/login.jsp" class='logout'><img
										src="<%=cPath%>/images/login-button-blue-th.png" width=50
										height=20></a> <span class='logout' class="head">비회원
										님</span>
									<%}else{ %>
									<a href="<%=cPath%>/shop/member/logout.jsp" class='logout'><img
										src="<%=cPath%>/images/logout3-removebg-preview.png" width=50 height=20></a>
									<span class='logout' class="head"><%=nickname %>님</span>
									<%} %>
								</div>
							</div>
						</div>
						<div class="col-md-1"></div>
					</div>
				</div>
			</th>
		</tr>
	</table>
	<table align="top" class="container fluid">
		<tr align='center' bgcolor="#EAEAEA">
			<th colspan='4' valign='top'>
				<div class="col-md-3"></div>
				<div class="col-md-6"></div>
				<div class="col-md-3"></div>

			</th>
		</tr>
		<tr>
			<td valign='top' align="left">
				<table width='200' style="text-align: left">
					
					<tr width='200' height="40">
						<td><a href="<%=cPath%>/shop/member/login.jsp"
							style="color: #121517">로그인</a></td>
					</tr>
					<tr width='200' height="40">
						<td><a href="<%=cPath%>/shop/member/register.jsp"
							style="color: #121517">회원 가입</a></td>
					</tr>
					<tr width='200' height="40">
						<td><a href="<%=cPath%>/shop/member/findid.jsp"
							style="color: #121517">아이디 찾기</a>
					</tr>
					<tr width='200' height="40">
						<td><a href="<%=cPath%>/shop/member/findpw.jsp"
							style="color: #121517">비밀번호 찾기</a>
					</tr>
					
					
				</table>
			</td>
			<td valign='top' align='center' width="1000">
</body>
