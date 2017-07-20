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
						<h5>${pd.A_NAME}</h5>
					</div>
					<div class="ibox-content">
						<form id="ActiveForm" name="ActiveForm" class="form-horizontal" method="post">
							<div class="form-group">
								<label class="col-sm-2 control-label">活动日期：</label>
							    <div class="col-sm-4">
									${pd.A_START_DATE}～${pd.A_END_DATE}
								</div>
								<label class="col-sm-2 control-label">报名截止日期：</label>
							    <div class="col-sm-4">
									${pd.A_APPLY_STOP}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">活动地点：</label>
								<div class="col-sm-10">
									${pd.A_ADDR}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">报名人/团体数：</label>
							    <div class="col-sm-4">
									${pd.A_APPLY_NUM}
								</div>
								<label class="col-sm-2 control-label">团体人数：</label>
							    <div class="col-sm-4">
									下限：${pd.A_GROUP_LOW }&nbsp;上限：${pd.A_GROUP_UP}
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12" style="word-break:break-all;">
									${pd.A_CONTENT}
								</div>
							</div>
							<c:if test="${pd.A_APP_ROTATION_THUMBNAIL != null && pd.A_APP_ROTATION_THUMBNAIL != '' }">
							<div class="form-group">
								<div class="col-sm-12" style="text-align: center;">
									<a href="filesUploads/backFile?ID=${pd.A_APP_ROTATION_THUMBNAIL}" target="_blank"><img alt="${pd.A_NAME}-缩略图" src="filesUploads/backFile?ID=${pd.A_APP_ROTATION_THUMBNAIL}" style="width: 50%;height: 50%;"></a>
								</div>
							</div>
							</c:if>
							<c:if test="${pd.A_TV_POST_LIST_THUMBNAIL != null && pd.A_TV_POST_LIST_THUMBNAIL != '' }">
							<div class="form-group">
								<div class="col-sm-12" style="text-align: center;">
									<a href="filesUploads/backFile?ID=${pd.A_TV_POST_LIST_THUMBNAIL}" target="_blank"><img alt="${pd.A_NAME}-电视海报列表缩略图" src="filesUploads/backFile?ID=${pd.A_TV_POST_LIST_THUMBNAIL}" style="width: 50%;height: 50%;"></a>
								</div>
							</div>
							</c:if>
							<c:if test="${pd.A_TV_POST_THUMBNAIL != null && pd.A_TV_POST_THUMBNAIL != '' }">
							<div class="form-group">
								<div class="col-sm-12" style="text-align: center;">
									<a href="filesUploads/backFile?ID=${pd.A_TV_POST_THUMBNAIL}" target="_blank"><img alt="${pd.A_NAME}-电视海报缩略图" src="filesUploads/backFile?ID=${pd.A_TV_POST_THUMBNAIL}" style="width: 50%;height: 50%;"></a>
								</div>
							</div>
							</c:if>
							<c:if test="${pd.A_APP_POST_THUMBNAIL != null && pd.A_APP_POST_THUMBNAIL != '' }">
							<div class="form-group">
								<div class="col-sm-12" style="text-align: center;">
									<a href="filesUploads/backFile?ID=${pd.A_APP_POST_THUMBNAIL}" target="_blank"><img alt="${pd.A_NAME}-手机海报缩略图" src="filesUploads/backFile?ID=${pd.A_APP_POST_THUMBNAIL}" style="width: 50%;height: 50%;"></a>
								</div>
							</div>
							</c:if>
							<c:if test="${pd.A_TV_AWARD_THUMBNAIL != null && pd.A_TV_AWARD_THUMBNAIL != '' }">
							<div class="form-group">
								<div class="col-sm-12" style="text-align: center;">
									<a href="filesUploads/backFile?ID=${pd.A_TV_AWARD_THUMBNAIL}" target="_blank"><img alt="${pd.A_NAME}-电视评奖结果缩略图" src="filesUploads/backFile?ID=${pd.A_TV_AWARD_THUMBNAIL}" style="width: 50%;height: 50%;"></a>
								</div>
							</div>
							</c:if>
							<c:if test="${pd.A_APP_AWARD_THUMBNAIL != null && pd.A_APP_AWARD_THUMBNAIL != '' }">
							<div class="form-group">
								<div class="col-sm-12" style="text-align: center;">
									<a href="filesUploads/backFile?ID=${pd.A_APP_AWARD_THUMBNAIL}" target="_blank"><img alt="${pd.A_NAME}-手机评奖结果缩略图" src="filesUploads/backFile?ID=${pd.A_APP_AWARD_THUMBNAIL}" style="width: 50%;height: 50%;"></a>
								</div>
							</div>
							</c:if>
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