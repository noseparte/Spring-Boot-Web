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
						<h5>编辑科室信息</h5>
					</div>
					<div class="ibox-content">
						<form id="BAForm" name="BAForm" class="form-horizontal" method="post">
							<input type="hidden" name="HD_ID" id="HD_ID" value="${pd.HD_ID}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">科室名称：</label>
							    <div class="col-sm-4">
							    <c:if test="${pd.HD_ID != null && pd.HD_ID != '' }">
							    	<input type="text" class="form-control required" name="HD_NAME" id="HD_NAME" value="${pd.HD_NAME}"  disabled = "true"/>
							    </c:if>
							    <c:if test="${pd.HD_ID == null || pd.HD_ID == '' }">
							    	<input type="text" class="form-control required" name="HD_NAME" id="HD_NAME" value="${pd.HD_NAME}"  />
							    </c:if>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">排序：</label>
							    <div class="col-sm-4"> 	
									<input type="number" class="form-control required" name="HD_SORTING" id="HD_SORTING" value="${pd.HD_SORTING}" maxlength="3"/>
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
	   /*  function submitForm(){
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
	    } */
	    
		function submitForm(){
			var HD_ID = $("#HD_ID").val();
			var HD_NAME = $("#HD_NAME").val();
			var HD_SORTING = $("#HD_SORTING").val();
			var action = '';
			var describeSuc = '';
			var describefail = '';
			if(HD_ID != null && HD_ID != ''){
				action = "saveEditLocation";
				describeSuc  = "修改成功";
				describefail = "修改失败";
			}else{
				action = "saveAddLocation";
				describeSuc  = "保存成功";
				describefail = "保存失败";
			}
			$.ajax({
				type: "POST",
				url: '<%=basePath%>hospDept/' + action,
				data: {
					HD_ID: HD_ID,
					HD_NAME: HD_NAME,
					HD_SORTING: HD_SORTING
				},
				success: function(data) {
					
						if('success'==data.success){
							layer.confirm(describeSuc, {
								btn: ['确认'],
								shade: false,
								yes: function(index, layero){
									parent.bstQuery(); //刷新父页面
									var indexs = parent.layer.getFrameIndex(window.name); //获取窗口索引
									parent.layer.close(indexs);  // 关闭layer
								}
							});
						}else{
							layer.confirm(describefail, {
								btn: ['确认'],
								shade: false,
								yes: function(index, layero){
									parent.bstQuery(); //刷新父页面
									var indexs = parent.layer.getFrameIndex(window.name); //获取窗口索引
									parent.layer.close(indexs);  // 关闭layer
								}
							});
						}
				}
			});
		}
	</script>
</body>
</html>