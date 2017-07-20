<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>
<!-- jsp文件头和头部 -->
<link href="plugins/bigcolorpicker/jquery.bigcolorpicker.css"
	rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>陪诊信息</h5>
					</div>
					<div class="ibox-content">
						<form id="GuideForm" name="GuideForm" class="form-horizontal" method="post">
							<input type="hidden" name="IM_ID" id="IM_ID" value="${pd.IM_ID}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">组件名称：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="IM_NAME" id="IM_NAME" value="${pd.IM_NAME}" />
								</div>
								<label class="col-sm-2 control-label">功能参数：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required " name="ILD_MODULE_PARAM" id="ILD_MODULE_PARAM" value="${pd.ILD_MODULE_PARAM}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">标题：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="ILD_TIITLE" id="ILD_TIITLE"  value="${pd.ILD_TIITLE}" />
								</div>
								<label class="col-sm-2 control-label">类型：</label>
							    <div class="col-sm-4">
									<select class="form-control required" name="ILD_TYPE" id="ILD_TYPE" value="${pd.ILD_TYPE}">
										<option value="1">activity</option>
										<option value="2">action</option>
										<option value="3">广播</option>
										<option value="4">网页</option>
										<option value="5">点播</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">背景颜色：</label>
								<div class="col-sm-4">
									<input type="text" class="form-control"
										name="ILD_BG_COLOR" id="ILD_BG_COLOR" value="${pd.ILD_BG_COLOR}"
										placeholder="请选择颜色" />
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="col-sm-2 col-sm-offset-5 text-center">
									<button id="btn_Save" class="btn btn-primary" type="button" onclick="submitForm();">保存内容</button>
									<button id="btn_Cancel" class="btn btn-white" type="button" onclick="goBack();">取消</button>
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
    <script src="plugins/bigcolorpicker/jquery.bigcolorpicker.min.js"></script>
	<!-- 自定义js -->
	<script type="text/javascript">
		//表单ID
		var formId = "#GuideForm";
		$(document).ready(function(){
			$(formId).validate(); 
			$("#ILD_BG_COLOR").bigColorpicker("ILD_BG_COLOR");
			var ILD_TYPE = "${pd.ILD_TYPE}";
			$("#ILD_TYPE option[value='"+ILD_TYPE+"']").attr("selected", true);
		});
		//表单提交
	    function submitForm(){
	        var id = $('#IM_ID').val();
	    	if(id == ""){
	    		action = "iptvModule/saveAdd";
	    	}else{
	    		action = "iptvModule/saveEdit";
	    	}
	    	$(formId).attr("action", action);
	    	$(formId).submit();
	    }
		//查询手机号是否被注册
	    //返回到列表页面 
		function goBack(){
			window.location.href="<%=basePath%>iptvModule/toLists";
		}
		
	</script>
</body>
</html>