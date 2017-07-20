<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>
<!-- jsp文件头和头部 -->
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.js"> </script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>就医关键节点</h5>
					</div>
					<div class="ibox-content">
						<form id="NMForm" name="NMForm" class="form-horizontal" method="post">
							<input type="hidden" name="NM_ID" id="NM_ID" value="${pd.NM_ID}" />
							<div class="form-group">
								<label class="col-sm-3 control-label">标题：</label>
							    <div class="col-sm-6">
									<input type="text" class="form-control required" name="NM_TITLE" id="NM_TITLE" value="${pd.NM_TITLE}" />
								</div>
								<div class="col-sm-3">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">排序：</label>
							    <div class="col-sm-6">
									<input type="number" class="form-control required" name="NM_ORDER" id="NM_ORDER" value="${pd.NM_ORDER}" />
								</div>
								<div class="col-sm-3">
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
	<!-- 自定义js -->
	<script type="text/javascript">
		//表单ID
		var formId = "#NMForm";
		$(document).ready(function(){
	    	//表单提交JS验证
			$(formId).validate();
		});
		//表单提交
	    function submitForm(){
	        var id = $('#NM_ID').val();
	    	var action = "";
	    	if(id == ""){
	    		action = "keysteptemp/saveAdd";
	    	}else{
	    		action = "keysteptemp/saveEdit";
	    	}
	    	$(formId).attr("action", action);
	    	$(formId).submit();
	    }
	    //返回到列表页面 
		function goBack(){
			this.location.href="<%=basePath%>keysteptemp/toLists";
		}
	</script>
</body>
</html>