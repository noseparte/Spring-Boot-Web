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
						<h5>用户禁言原因</h5>
					</div>
					<div class="ibox-content">
						<form id="JybUsersForm" name="JybUsersForm" class="form-horizontal" method="post">
							<c:if test="${pd.FS_DAYS != null}">
								<div class="form-group">
									<label class="col-sm-6 control-label">开始日期：</label>${pd.FS_START_DATE}							    
									<label class="col-sm-2 control-label">持续天数：</label>${pd.FS_DAYS}&nbsp;天
								</div>
							</c:if>
							<c:if test="${pd.FS_DAYS == null }">
								<div class="form-group col-sm-12">
									<label class="col-sm-2 control-label">禁言天数：</label>
								    <div class="col-sm-2">
										<input type="text" class="form-control required digits" name="FS_DAYS" id="FS_DAYS" value="${pd.FS_DAYS}" />
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
		//表单ID
		var formId = "#JybUsersForm";
		$(document).ready(function(){
			$(formId).validate({
				rules: {
					FS_DAYS: {
						digits: true,
						rangelength: [1, 5]
					}
				},
				messages: {
					FS_DAYS: "请输入5位整数以内的天数。"
				}
			});
		});
		function formData(){
			var days = $("#FS_DAYS").val();
			if(days == null || days == ''){
				parent.layer.msg('请输入5位整数以内的禁言天数。');
				return null;
			}
			if(days > 99999){
				parent.layer.msg('请输入5位整数以内的禁言天数。');
				return null;
			}
			return days;
		}
	</script>
</body>
</html>