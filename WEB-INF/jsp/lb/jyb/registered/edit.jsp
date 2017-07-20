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
						<h5>快速注册用户</h5>
					</div>
					<div class="ibox-content">
						<form id="ArticleRotationForm" name="ArticleRotationForm" class="form-horizontal" method="post">
							<input type="hidden" name="UI_ID" id="UI_ID" value="${pd.UI_ID}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">姓名：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="UI_NAME" id="UI_NAME" value="${pd.UI_NAME}" />
								</div>
								<label class="col-sm-2 control-label">性别：</label>
							    <div class="col-sm-4">
							    	<select class="form-control" name="UI_SEX" id="UI_SEX" value="${pd.UI_SEX}">
					                   <option value="0" <c:if test="${pd.UI_SEX == 0}">selected="selected"</c:if>>女</option>
					                   <option value="1" <c:if test="${pd.UI_SEX == 1}">selected="selected"</c:if>>男</option>
					                 </select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">手机号：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="UI_PHONE" id="UI_PHONE" value="${pd.UI_PHONE}" onkeypress="return event.keyCode >= 48 && event.keyCode <= 57"/>
								</div>
								<label class="col-sm-2 control-label">身份证号：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control" name="UI_IDCARD" id="UI_IDCARD" value="${pd.UI_IDCARD}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">紧急联系人：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control" name="URGENT_NAME" id="URGENT_NAME" value="${pd.URGENT_NAME}" />
								</div>
								<label class="col-sm-2 control-label">紧急联系人电话：</label>
							    <div class="col-sm-4">
							    	<input type="text" class="form-control" name="URGENT_PHONE" id="URGENT_PHONE" value="${pd.URGENT_PHONE}" onkeypress="return event.keyCode >= 48 && event.keyCode <= 57"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">出生日期：</label>
							    <div class="col-sm-4">
									<input type="text" class="bootstrapdatetimepicker form-control" name="UI_BIRTHDAY" id="UI_BIRTHDAY" placeholder="请选择出生日期" value="${pd.UI_BIRTHDAY}" />
									<input type="hidden" id="msgCode" name="msgCode" value="${pd.msgCode }"/>
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="col-sm-3 col-sm-offset-5 text-center">
									<button id="btn_Save" class="btn btn-primary" type="button" onclick="submitForm();">保存内容</button>
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
	    	//表单提交JS验证
			$(formId).validate({
				rules: {
					URGENT_PHONE:{
						rangelength: [11, 11],
					},
					UI_IDCARD:{
						rangelength: [18, 18],
					},
					UI_PHONE: {
						rangelength: [11, 11],
						remote: {
							url: '/registered/selectPhone',
							type: 'POST',
							dataType: 'JSON',
							data: {
								'UI_PHONE': function() {
									return $('#UI_PHONE').val();
								}
							}
						}
					}
				},
				messages: {
					UI_PHONE: "输入的手机号格式不正确，或该手机号已被注册",
					URGENT_PHONE:"请输入11位正确手机号",
					UI_IDCARD:"请输入18位正确身份证号"
				}
			});
		//表单提交
	    function submitForm(){
	    	var UI_PHONE = $("#UI_PHONE").val();
	    	var msgCode = '';
	    	//发送验证码
			$.ajax({
				type: "POST",
				url: '<%=basePath%>registered/sendCode?tm=' +  new Date().getTime(),
				data: {
					"UI_PHONE": UI_PHONE
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					console.info(data.msg);
					if (data.msg == 'success') {
						//输入验证码
						layer.config({
			                extend: 'extend/layer.ext.js'
			            });
			            layer.ready(function () {
			                layer.prompt({
			                    title: '请输入验证码，并确认'
			                }, function (str) {
			                    if (str) {
			                        layer.msg(str);
			                        msgCode = str;
			                      //验证验证码
						            $.ajax({
										type: "POST",
										url: '<%=basePath%>registered/verification?tm=' +  new Date().getTime(),
										data: {
											UI_PHONE: UI_PHONE,
											msgCode:msgCode
										},
										dataType: 'json',
										//beforeSend: validateData,
										cache: false,
										success: function(data) {
											if (data.msg == 'success') {
												action = "registered/saveAdd";
										    	$(formId).attr("action", action);
										    	$(formId).submit();
										    	layer.msg("添加用户成功");
											} else {
												layer.msg(data.msg);
											}
										}
									});
			                    };
			                });
			            });
					} else {
						layer.msg('验证码发送失败');
						
					}
				}
			});
			
	    }
	</script>
</body>
</html>