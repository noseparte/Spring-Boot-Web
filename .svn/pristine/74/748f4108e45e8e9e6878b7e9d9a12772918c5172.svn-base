<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- 全局css -->
<system:header/>
<!-- jsp文件头和头部 -->
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>标题</h5>
					</div>
					<div class="ibox-content">
						<form id="userForm" name="userForm" class="form-horizontal" method="POST">
							<input type="hidden" name="id" id="id" value="${user.id}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">用户名：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="username" id="username" value="${user.username}" />
								</div>
								<label class="col-sm-2 control-label">密码：</label>
								<div class="col-sm-4">
									<input type="password" class="form-control required" name="password" id="password" value="${user.password}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">用户类型：</label>
								<div class="col-sm-4">
									<select class="form-control" name="usertype" id="usertype" value="${user.usertype}"
				                         ajax--url="user/getDicForSelect?param=alert" ajax--column="ID,TEXT">
					                 </select>
								</div>
								<label class="col-sm-2 control-label">是否启用</label>
								<div class="col-sm-4">
									<select class="form-control" name="enabled" id="enabled" value="${user.enabled}"
				                         ajax--url="user/getDicForSelect?param=map" ajax--column="ID,TEXT">
					                 </select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">真实姓名：</label>
								<div class="col-sm-4">
									<input type="text" class="form-control required" name="realname" id="realname" value="${user.realname}" />
								</div>
								<label class="col-sm-2 control-label">联系电话：</label>
								<div class="col-sm-3">
									<input type="text" class="form-control required" name="tel" id="tel" value="${user.tel}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">QQ：</label>
								<div class="col-sm-4">
									<input type="text" class="form-control required" name="qq" id="qq" value="${user.qq}" />
								</div>
								<label class="col-sm-2 control-label">电子邮箱：</label>
								<div class="col-sm-3">
									<input type="text" class="form-control required" name="email" id="email" value="${user.email}" />
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="col-sm-2 col-sm-offset-5 text-center">
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
	<!-- 自定义js -->
	<script src="hplus/js/content.min.js"></script>
	<script type="text/javascript">
		//表单ID
		var formId = "#userForm";
	    $(document).ready(function(){
	    	//初始化下拉菜单
	    	$("#M_TYPE_ID").createOption();
	    	$("#M_MAPALARM").createOption();
	    	$("#M_MAPSHOW").createOption();
	    	//表单提交JS验证
			$(formId).validate();
		});
	    //表单提交
	    function submitForm(){
	        var id = $('#id').val();
	    	var action = "";
	    	if(id == ""){
	    		action = "users/saveAdd";
	    	}else{
	    		action = "users/saveEdit";
	    	}
	    	$(formId).attr("action", action);
	    	$(formId).submit();
	    }
	    //返回到列表页面 
		function goBack(){
			this.location.href="users/lists";
		}
	</script>
</body>
</html>