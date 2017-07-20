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
						<h5>用户沟通备忘录信息</h5>
					</div>
					<div class="ibox-content">
						<form id="CommunicateMemoForm" name="CommunicateMemoForm" class="form-horizontal" method="post">
							<input type="hidden" name="CH_ID" id="CH_ID" value="${pd.CH_ID}" />
							<div class="form-group">
							    <div class="col-sm-12">
									<textarea class="form-control required" rows="8" cols="100" name="CH_MEMO" id="CH_MEMO" style="width:100%;">${pd.CH_MEMO }</textarea>
								</div>
							</div>
							<!-- <div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="col-sm-2 col-sm-offset-5 text-center">
									<button id="btn_Save" class="btn btn-primary" type="button" onclick="submitForm();">保存内容</button>
									<button id="btn_Cancel" class="btn btn-white" type="button" onclick="goBack();">取消</button>
								</div>
							</div> -->
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
		var formId = "#CommunicateMemoForm";
		$(document).ready(function(){
	    	//表单提交JS验证
			$(formId).validate();
		});
		function formData(){
			var memo = $("#CH_MEMO").val();
			if(memo == null || memo == ''){
				return null;
			}
			return memo;
		}
		//表单提交
	    function submitForm(){
	        var id = $('#CH_ID').val();
	    	var action = "";
	    	if(id == ""){
	    		action = "commMemo/saveAdd";
	    	}else{
	    		action = "commMemo/saveEdit";
	    	}
	    	$(formId).attr("action", action);
	    	$(formId).submit();
	    }
	    //返回到列表页面 
		function goBack(){
			this.location.href="<%=basePath%>guide/toLists";
		}
	</script>
</body>
</html>