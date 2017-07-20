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
						<h5>验证信息</h5>
					</div>
					<div class="ibox-content">
						<form id="ArticleRotationForm" name="ArticleRotationForm" class="form-horizontal" method="post">
							<input type="hidden" name="UI_ID" id="UI_ID" value="${pd.UI_ID}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">验证码：</label>
							    <div class="col-sm-10">
									<input type="text" class="form-control required" name="HEL_NAME" id="HEL_NAME" value="${pd.HEL_NAME}" />
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="col-sm-3 col-sm-offset-5 text-center">
									<button id="btn_Save" class="btn btn-primary" type="button" onclick="submitForm();">确认</button>
									<!-- <button id="btn_Cancel" class="btn btn-primary" type="button" onclick="sendCode();">发送验证码</button> -->
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
			var formId = "#ArticleRotationForm";
	    	
		//表单提交
	    function submitForm(){
	      
	    	action = "registered/saveAdd";
	    	$(formId).attr("action", action);
	    	$(formId).submit();
	    }
	</script>
</body>
</html>