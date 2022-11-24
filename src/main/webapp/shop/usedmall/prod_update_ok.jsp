<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="shop.sell.ProductDao"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
ServletContext sContext= config.getServletContext();
String folderPath=sContext.getRealPath("/shop/images");
int maxSize=1024*1024*5;
String encType="UTF-8";
MultipartRequest mr=new MultipartRequest( 
											request,
											folderPath,
											maxSize,
											encType,
											new DefaultFileRenamePolicy()
											);
String name=mr.getParameter("pname"); 
String proname=mr.getFilesystemName("pimage");
String proname1=mr.getFilesystemName("pimage1");
String proname2=mr.getFilesystemName("pimage2");
String proname3=mr.getFilesystemName("pimage3");
if(proname==null){
	proname =mr.getParameter("pimages");
}
if(proname1!=null){
	proname += "/"+proname1;
} else {
	if(mr.getParameter("pimages1")!=null){
		proname +="/"+mr.getParameter("pimages1");
	}
}
if(proname2!=null){
	proname += "/"+proname2;
} else {
	if(mr.getParameter("pimages2")!=null){
		proname +="/"+mr.getParameter("pimages2");
	}
}
if(proname3!=null){
	proname += "/"+proname3;
} else {
	if(mr.getParameter("pimages3")!=null){
		proname +="/"+mr.getParameter("pimages3");
	}
}

String FullPath=folderPath+"\\"+proname;
System.out.println(proname);
ProductDao pdao=ProductDao.getInstance();
int result=pdao.updateProduct(mr);
String msg,url;

if(result>0){
	msg="수정 성공";
	url="prod_list.jsp";
} else {
	msg="수정 실패";
	url="prod_input.jsp";		
}

%>
<script type="text/javascript">
alert('<%=msg%>');
location.href="<%=url%>";
</script>
%>