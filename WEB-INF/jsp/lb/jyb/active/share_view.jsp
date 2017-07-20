<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath = basePath +"";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, width=device-width">
  <meta content="telephone=no" name="format-detection" />
<title>精彩活动</title>
<!-- jsp文件头和头部 -->
<style type="text/css">
.download{ height:35px; width:240px; background:#00a3ef; color:#FFF; text-align:center; outline:none; border:none; margin:auto; line-height:35px;}
a{ text-decoration:none;}
.logo{ width:200px; height:100px; margin:auto;}
</style>
</head>
<body>
	
							<c:if test="${pd.A_APP_POST_THUMBNAIL != null && pd.A_APP_POST_THUMBNAIL != '' }">
									<img alt="${pd.A_NAME}-手机海报缩略图" src="filesUploads/backFile?ID=${pd.A_APP_POST_THUMBNAIL}" style="width: 100%;height: 100%;">
							</c:if>
   <div class="logo">
  		<img src="<%=basePath %>images/logo_top.png" width="100%" height="100%">
	</div>
	<a href="${appDownloadUrl}">
	   <div class="download">
	      安全下载
	   </div> 
	</a>
	<!-- 全局js -->
	<!-- 自定义js -->
</body>
</html>