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
							<h5>收款账号</h5>
						</div>
						<div class="ibox-content">
							<form id="ArticleForm" name="BankAccountForm" class="form-horizontal">
								<input type="hidden" name="ARTICLE_ID" id="BA_ID" value="${pd.ARTICLE_ID}" />
								<div class="form-group">
									<label class="col-sm-2 control-label">银行卡号：</label>
								    <div class="col-sm-4">
										<input type="text" class="form-control required" name="PUBLISH_NAME" id="BA_NUM" value="${pd.PUBLISH_NAME}" />
									</div>
									<label class="col-sm-2 control-label">户头：</label>
								    <div class="col-sm-4">
										<input type="text" class="form-control required" name="PUBLISH_DEPT" id="BA_NAME" value="${pd.PUBLISH_DEPT}" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">开户地址：</label>
								    <div class="col-sm-4">
										<input type="text" class="form-control required" name="ARTICLE_TYPE" id="BA_REGISTER_ADDR" value="${pd.ARTICLE_TYPE}" />
									</div>
									<label class="col-sm-2 control-label">开户行：</label>
									<div class="col-sm-4">
										<input type="text" class="form-control required" name="PUBLISH_DEPT" id="BA_REGISTER_BANK" value="${pd.PUBLISH_DEPT}" />
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
		<script src="hplus/js/plugins/jeditable/jquery.jeditable.js"></script>
		<!-- 自定义js -->
		<script src="hplus/js/content.min.js"></script>
		<script type="text/javascript">
			//表单ID
			var formId = "#ArticleForm";
			/* $(document).ready(function(){
		    	//初始化下拉菜单
		    	$("#ARCHIVE_STATE").createOption();
		    	//表单提交JS验证
				$(formId).validate();
		    	//加载UEditor
				UE.getEditor('container',{
			        initialFrameWidth : '100%',
			        initialFrameHeight: 300
			    });
			}); */
			//表单提交
		    function submitForm(){
		        var id = $('#BA_ID').val();
		    	var action = "";
		    	if(id == ""){
		    		action = "article/saveAdd";
		    	}else{
		    		action = "article/saveEdit";
		    	}
		    	$(formId).attr("action", action);
		    	$(formId).submit();
		    }
		    
		</script>
	</body>
	</html>