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
					<div class="ibox-content">
						<form id="HospitalExpertLibsForm" name="HospitalExpertLibsForm" class="form-horizontal" method="post">
							<div class="form-group">
								<label class="col-sm-3 control-label">排序号：</label>
							    <div class="col-sm-9">
							    	<input type="number" class="form-control required" name="HEL_ORDER" id="HEL_ORDER" value="${pd.HEL_ORDER}" />
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
		//表单ID
		var formId = "#HospitalExpertLibsForm";
		$(document).ready(function(){
			$(formId).validate({
				rules: {
					HEL_ORDER: {
						digits: true,
						rangelength: [1, 10],
						range:[1, 1000000000]
					}
				},
				messages: {
					HEL_ORDER: "请输入10位整数以内的排序号。"
				}
			});
		});
		function formData(){
			var order = $("#HEL_ORDER").val();
			if(order == null || order == ''){
				parent.layer.msg('请输入10位整数以内的排序号。');
				return null;
			}
			if(order > 999999999){
				parent.layer.msg('请输入10位整数以内的排序号。');
				return null;
			}
			return order;
		}
	</script>
</body>
</html>