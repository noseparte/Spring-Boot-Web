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
						<h5>退回原因</h5>
					</div>
					<div class="ibox-content">
						<div class="form-group">
						    <div class="col-sm-12">
								<textarea rows="5" cols="5" class="form-control required" name="RETURN_REASON" id="RETURN_REASON">${pd.CL_REASON }</textarea>
							</div>
						</div>
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
		function formData(){
			var backReason = $.trim($("#RETURN_REASON").val());
			if(backReason == null || backReason == ''){
				return null;
			}
			return backReason;
		}
	</script>
</body>
</html>