<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//String basePath = "http://c.pegoe.com:8799/lbaner/images/";
%>
<!DOCTYPE html>

<html lang="en">
<head>
<meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, width=device-width">
  <meta content="telephone=no" name="format-detection" />
<title>智慧健康</title>
<base href="${IMGPATH}/">
<!-- jsp文件头和头部 -->
<style type="text/css">
@media screen and (max-width:500px){
img{width:100%}
}/*宽度小于500px时 绿色*/
.download{ height:35px; width:240px; background:#00a3ef; color:#FFF; text-align:center; outline:none; border:none; margin:auto; line-height:35px;}
a{ text-decoration:none;}
.logo{ width:200px; height:100px; margin:auto;}
</style>
</head>
<body>
	<div style="word-break:break-all;">
		${pd.ARTICLE_CONTENTS}
	</div>
</body>
</html>