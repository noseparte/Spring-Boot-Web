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
						<h5>收款账号</h5>
					</div>
					<div class="ibox-content">
						<form id="BAForm" name="BAForm" class="form-horizontal" method="post">
							<input type="hidden" name="BA_ID" id="BA_ID" value="${pd.BA_ID}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">银行卡号：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="BA_NUM" id="BA_NUM" value="${pd.BA_NUM}" maxlength="32" onkeypress="return event.keyCode >= 49 && event.keyCode <= 57"/>
								</div>
								<label class="col-sm-2 control-label">户头：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="BA_NAME" id="BA_NAME" value="${pd.BA_NAME}" maxlength="32"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">开户行：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="BA_REGISTER_BANK" id="BA_REGISTER_BANK" value="${pd.BA_REGISTER_BANK}" maxlength="32"/>
								</div>
								<label class="col-sm-2 control-label">开户地址：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="BA_REGISTER_ADDR" id="BA_REGISTER_ADDR" value="${pd.BA_REGISTER_ADDR}" maxlength="50"/>
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="col-sm-2 col-sm-offset-5 text-center">
									<button class="btn btn-primary" type="button" onclick="submitForm();">保存内容</button>
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
		var formId = "#BAForm";
		$(document).ready(function(){
	    	//表单提交JS验证
			$(formId).validate();
		});
		//表单提交
	    function submitForm(){
	        var id = $('#BA_ID').val();
	    	var action = "";
	    	if(id == ""){
	    		action = "bankaccount/saveAdd";
	    	}else{
	    		action = "bankaccount/saveEdit";
	    	}
	    	if("save" == '${pd.succe}')
	    	{
	    		layer.msg('保存成功');
	    	}
	    	if("edit" == '${pd.succe}')
	    	{
	    		layer.msg('修改成功');
	    	}
	    	$(formId).attr("action", action);
	    	$(formId).submit();
	    }
	</script>
</body>
</html>