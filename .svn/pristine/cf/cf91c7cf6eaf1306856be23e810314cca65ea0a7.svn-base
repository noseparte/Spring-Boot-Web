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
						<h5>
							系统常量管理
						</h5>
						<div class="ibox-tools"></div>
					</div>
					<div class="ibox-content">
						<form id="systemConstantForm" name="systemConstantForm" class="form-horizontal">
							<input type="hidden" name="SC_ID" id="SC_ID" value="${pd.SC_ID}" />
							
							<div class="form-group">
								<label class="col-sm-2 control-label">系统常量代码</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="SC_CODE"
										id="SC_CODE" value="${pd.SC_CODE}">
								</div>
								<label class="col-sm-2 control-label">系统常量名称</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="SC_NAME"
										id="SC_NAME" value="${pd.SC_NAME}">
								</div>
							</div>
							
							
							
							
							<div class="form-group">
								<label class="col-sm-2 control-label">系统常量值</label>
								<div class="col-sm-4">
									<input type="text" class="form-control required" name="SC_VALUE"
										id="SC_VALUE" value="${pd.SC_VALUE}">
								</div>
								<label class="col-sm-2 control-label">备注</label>
								<div class="col-sm-4">
                                    <input type="text" class="form-control" name="SC_REMARK"
										id="SC_REMARK" value="${pd.SC_REMARK}">
								</div>
							</div>
							
							
							
							<div class="form-group">
								<label class="col-sm-2 control-label">排序</label>
								<div class="col-sm-4">
                                    <input type="text" class="form-control digits" name="SC_ORD_BY"
										id="SC_ORD_BY" value="${pd.SC_ORD_BY}">
								</div>
							</div>
					
					       
						
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="col-sm-4 col-sm-offset-2">
									<button class="btn btn-primary" type="button" onclick="submitForm();">保存内容</button>
									<button class="btn btn-white" type="button" onclick="goBack();">取消</button>
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
	var editor;
    $().ready(function(){
	    $("#systemConstantForm").validate();
    });
    
    
    function submitForm(){
        var id=$('#SC_ID').val();
    	var action="";
    	if(id==""){
    		action="constant/saveAdd";
    	}else{
    		action="constant/saveEdit";
    	}
    	//$("#EP_CONTENT").val(editor.getValue());
    	$("#systemConstantForm").attr("action",action);
    	$("#systemConstantForm").submit();
    }
    
    
    
	function goBack(){
		this.location.href="<%=basePath%>systemConstant/listSystemConstants";
	}
	</script>
</body>
</html>

