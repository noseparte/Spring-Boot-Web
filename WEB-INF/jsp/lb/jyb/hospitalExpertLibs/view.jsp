<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
						<h5>专家：${pd.HEL_NAME}</h5>
					</div>
					<div class="ibox-content">
						<form id="HospitalExpertLibsForm" name="HospitalExpertLibsForm" class="form-horizontal" method="post">
							<div class="form-group">
								<label class="col-sm-2 control-label">性别：</label>
							    <div class="col-sm-4">
									${pd.HEL_SEX}
								</div>
								<label class="col-sm-2 control-label">出生日期：</label>
							    <div class="col-sm-4">
									${pd.HEL_BIRTHDAY}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">所属区域：</label>
							    <div class="col-sm-4">
									${pd.HE_AREA}
								</div>
								<label class="col-sm-2 control-label">所属医院：</label>
							    <div class="col-sm-4">
									${pd.HE_HOSPITAL}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">所属科室：</label>
							    <div class="col-sm-4">
									${pd.HD_NAME}
								</div>
								<label class="col-sm-2 control-label">职务：</label>
							    <div class="col-sm-4">
									${pd.HEL_DUTY}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">擅长专业：</label>
								<div class="col-sm-10" style="word-break:break-all;">
									${pd.HEL_GOODPRO}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">教育背景：</label>
								<div class="col-sm-10" style="word-break:break-all;">
									${pd.HEL_EDU}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">相关荣誉：</label>
								<div class="col-sm-10" style="word-break:break-all;">
									${pd.HEL_HONOR}
								</div>
							</div>
							<div class="form-group">
								<c:if test="${pd.REJECT_REASON != null && pd.REJECT_REASON != '' }">
									<label class="col-sm-2 control-label">退回理由：</label>
									<div class="col-sm-10" style="word-break:break-all;">
										${pd.REJECT_REASON}
									</div>
								</c:if>
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