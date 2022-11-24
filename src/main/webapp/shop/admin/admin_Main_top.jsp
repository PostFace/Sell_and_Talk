<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
	body{
		text-align: center;
	}
	table{
		text-align: center;
		align: center;
		margin: auto;
	}
</style> 

<h1>쇼핑몰(관리자용)</h1><br>
<a href="<%=request.getContextPath()%>/shop/admin/admin_Main.jsp">쇼핑몰홈</a> |
<a href="<%=request.getContextPath()%>/Main.jsp">메인홈</a> |
<a href="">로그아웃</a><br><br><br>
<head> 
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>세상의 모든 신발 Sell and Talk!</title>

    <!-- Bootstrap -->
    <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/kfonts2.css" rel="stylesheet">
    <style>
    h2 { margin: 20px 0} 
    </style>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

<table class="table table-dark table-hover" border='1' width="800" height="400">
	<tr align="center">
		<td><a href="<%=request.getContextPath()%>/shop/admin/cate_input_form.jsp">카테고리 등록</a></td>
		<td><a href="cate_list.jsp">카테고리 목록</a></td>
		<td><a href="prod_input.jsp">상품 등록</a></td>
		<td><a href="prod_list.jsp">상품 목록</a></td>
		<td><a href="shopping_list.jsp">쇼핑 내역</a></td>
		<td><a href="<%=request.getContextPath()%>/Main.jsp">사용자 홈</a></td>			
<!-- 	<td><a href="<%=request.getContextPath()%>/myshop/display/mall.jsp">사용자 홈</a></td>			 -->
	</tr>
	<tr height="500">
		<td colspan='6'>