<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<script src="plugins/pwdAlert/js/main.js"></script>
<link rel="stylesheet" href="hplus/css/plugins/jsTree/style.min.css" />
<link href="plugins/pwdAlert/css/main.css" rel="stylesheet" />
<div class="modal-dialog">
	<div class="modal-content animated bounceInRight">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">
				<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
			</button>
			<h1 class="modal-title" style="text-align: -webkit-left;">修改密码</h1>
		</div>
		<form id="changePwdForm" class="form-horizontal">
			<div class="modal-body">
				<div class="row" style="margin-bottom: -20px;">
					<div class="col-sm-12">
						<div class="ibox float-e-margins">
							<div class="ibox-content">
								<input type="hidden" name="USER_ID" id="user_id"
									value="${pd.USER_ID }" /> <input type="hidden" name="USERNAME"
									id="username" value="${pd.USER_NAME }" />
								<div class="form-group">
									<label class="col-sm-3 control-label">旧密码</label>
									<div class="col-sm-8">
										<input type="password" class="form-control" name="PWD"
											id="pwd">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">新密码</label>
									<div class="col-sm-4">
										<input type="password" class="form-control" name="NEWPASSWORD"
											id="newpassword">
									</div>
									<div class="col-sm-4">
	                                    <div id="passwordLevel" class="pw-strength">           	
											<div class="pw-bar"></div>
											<div class="pw-bar-on"></div>
											<div class="pw-txt">
											<span>弱</span>
											<span>中</span>
											<span>强</span>
											</div>
										</div>
	                                </div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">确认新密码</label>
									<div class="col-sm-8">
										<input type="password" class="form-control"
											name="CHECKNEWPASSWORD" id="checknewpassword">
									</div>
								</div>


							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" onclick="save()">保存修改</button>
				<button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">
	function save() {

		if ($("#pwd").val() == "") {

			$("#pwd").tips({
				side : 3,
				msg : '输入旧密码',
				bg : '#AE81FF',
				time : 2
			});

			$("#pwd").focus();
			return false;
		}
		if ($("#newpassword").val() == "") {

			$("#newpassword").tips({
				side : 3,
				msg : '输入新密码',
				bg : '#AE81FF',
				time : 2
			});

			$("#newpassword").focus();
			return false;
		}
		if($("#newpassword").val().length < 6 || $("#newpassword").val().length > 30){
			$("#newpassword").tips({
				side:3,
	            msg:'输入密码长度规则：大于等于6位或小于等于30位',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#newpassword").focus();
			return false;
		}
		if ($("#checknewpassword").val() == "") {

			$("#checknewpassword").tips({
				side : 3,
				msg : '输入确认新密码',
				bg : '#AE81FF',
				time : 2
			});

			$("#checknewpassword").focus();
			return false;
		}

		if ($("#newpassword").val() != $("#checknewpassword").val()) {

			$("#checknewpassword").tips({
				side : 3,
				msg : '两次密码不相同',
				bg : '#AE81FF',
				time : 3
			});

			$("#checknewpassword").focus();
			return false;
		}

		if ($("#user_id").val() == "") {

		} else {
			$("#changePwdForm").submit();
		}
	}

	$().ready(function(){
		$('#changePwdForm').validate({
			submitHandler:function(form){
			
				$.ajax({
					type:'post',
					url:'saveChangePwd',
					data : $('#changePwdForm').serialize(),
					success : function(data) {
	
						$("#indexModal").modal('hide');
	                    var info = data.result;
						if ("success" == info) {
							layer.msg('修改成功');
						} else if ("pwderror" == info) {
							layer.msg('旧密码错误');
						} else {
							layer.msg('修改失败');
						}
						
					}
				});
			}
		});
	});
</script>
