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
						<h5>健康教育</h5>
					</div>
					<div class="ibox-content">
						<form id="ArticleHealthForm" name="ArticleHealthForm" class="form-horizontal" method="post">
							<input type="hidden" name="ARTICLE_ID" id="ARTICLE_ID" value="${pd.ARTICLE_ID}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">标题：</label>
							    <div class="col-sm-10">
									<input type="text" class="form-control required" name="ARTICLE_TITLE" id="ARTICLE_TITLE" value="${pd.ARTICLE_TITLE}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">专家：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="EXPERT_NAME" id="EXPERT_NAME" value="${pd.EXPERT_NAME}" />
								</div>
								<label class="col-sm-2 control-label">职称：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="EXPERT_DUTY" id="EXPERT_DUTY" value="${pd.EXPERT_DUTY}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">所属医院：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="EXPERT_HOSP" id="EXPERT_HOSP" value="${pd.EXPERT_HOSP}" />
								</div>
								<label class="col-sm-2 control-label">所属科室：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="EXPERT_DEPT" id="EXPERT_DEPT" value="${pd.EXPERT_DEPT}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">发表人：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="PUBLISH_NAME" id="PUBLISH_NAME" value="${pd.PUBLISH_NAME}" />
								</div>
								<label class="col-sm-2 control-label">发表单位：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="PUBLISH_DEPT" id="PUBLISH_DEPT" value="${pd.PUBLISH_DEPT}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">文章类型：</label>
							    <div class="col-sm-4">
							    	<select class="form-control required" name="ARTICLE_TYPE" id="ARTICLE_TYPE" value="${pd.ARTICLE_TYPE}"
				                         ajax--url="dic/getDicForSelect?code=articleType" ajax--column="ID,TEXT">
					                 </select>
									<%-- <select class="form-control required" name="ARTICLE_TYPE" id="ARTICLE_TYPE" value="${pd.ARTICLE_TYPE}">
										<option value="0" <c:if test="${pd.ARTICLE_TYPE == 0}">selected="selected"</c:if>>新闻</option>
										<option value="1" <c:if test="${pd.ARTICLE_TYPE == 1}">selected="selected"</c:if>>医学</option>
									</select> --%>
								</div>
								<label class="col-sm-2 control-label">APP轮播缩略图：</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" name="PHOTO_THUMBNAIL" id="PHOTO_THUMBNAIL" value="${pd.PHOTO_THUMBNAIL}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">内容：</label>
								<div class="col-sm-10">
									<script id="container" name="ARTICLE_CONTENTS" id="ARTICLE_CONTENTS" type="text/plain">${pd.ARTICLE_CONTENTS}</script>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">备注：</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" name="REMARKS" id="REMARKS" value="${pd.REMARKS}">
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
		var formId = "#ArticleHealthForm";
		$(document).ready(function(){
	    	//初始化下拉菜单
	    	$("#ARTICLE_TYPE").createOption();
	    	//表单提交JS验证
			$(formId).validate();
	    	//加载UEditor
			UE.getEditor('container',{
		        initialFrameWidth : '100%',
		        initialFrameHeight: 300
		    });
			//当审核状态非“未送审”时，不可修改
			if('${pd.ARTICLE_ID}' != null && '${pd.ARTICLE_ID}' != '' && '${pd.CHECK_STATE}' != '0' && '${pd.CHECK_STATE}' != '6'){
	    		$('#ARTICLE_TITLE').attr("readonly", 'readonly');
	    		$('#PUBLISH_NAME').attr("readonly", 'readonly');
	    		$('#PUBLISH_DEPT').attr("readonly", 'readonly');
	    		$('#ARTICLE_TYPE').attr("readonly", 'readonly');
	    		$('#EXPERT_NAME').attr("readonly", 'readonly');
	    		$('#EXPERT_DUTY').attr("readonly", 'readonly');
	    		$('#EXPERT_HOSP').attr("readonly", 'readonly');
	    		$('#EXPERT_DEPT').attr("readonly", 'readonly');
	    		$('#ARTICLE_CONTENTS').attr("readonly", 'readonly');
	    		$('#PHOTO_THUMBNAIL').attr("readonly", 'readonly');
	    		$('#REMARKS').attr("readonly", 'readonly');
	    		$('#btn_Save').attr("disabled", true); 
	    	}
		});
		//表单提交
	    function submitForm(){
	        var id = $('#ARTICLE_ID').val();
	    	var action = "";
	    	if(id == ""){
	    		action = "articleHealth/saveAdd";
	    	}else{
	    		action = "articleHealth/saveEdit";
	    	}
	    	$(formId).attr("action", action);
	    	$(formId).submit();
	    }
	    //返回到列表页面 
		function goBack(){
			this.location.href="<%=basePath%>articleHealth/toLists";
		}
	</script>
</body>
</html>