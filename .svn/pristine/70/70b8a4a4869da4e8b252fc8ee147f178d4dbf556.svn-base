<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>
<!-- jsp文件头和头部 -->
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>${pd.ARTICLE_TITLE}</h5>
					</div>
					<div class="ibox-content">
						<form id="ArticleRotationForm" name="ArticleRotationForm" class="form-horizontal" method="post">
							<div class="form-group">
								<label class="col-sm-2 control-label">发表人：</label>
							    <div class="col-sm-4">
									${pd.PUBLISH_NAME}
								</div>
								<label class="col-sm-2 control-label">发表单位：</label>
							    <div class="col-sm-4">
									${pd.PUBLISH_DEPT}
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12" style="word-break:break-all;">
									${pd.ARTICLE_CONTENTS}
								</div>
							</div>
							<c:if test="${pd.PHOTO_THUMBNAIL != null && pd.PHOTO_THUMBNAIL != '' }">
							<div class="form-group">
								<div class="col-sm-12" style="text-align: center;">
									<a href="filesUploads/backFile?ID=${pd.PHOTO_THUMBNAIL}" target="_blank"><img alt="${pd.ARTICLE_TITLE}-缩略图" src="filesUploads/backFile?ID=${pd.PHOTO_THUMBNAIL}" style="width: 50%;height: 50%;"></a>
								</div>
							</div>
							</c:if>
							<div class="form-group">
								<label class="col-sm-2 control-label">备注：</label>
								<div class="col-sm-10">
									${pd.REMARKS}
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 全局js -->
    <system:jsFooter/>
	<!-- 自定义js -->
	<script type="text/javascript">
		$(document).ready(function(){
		});
	</script>
</body>
</html>