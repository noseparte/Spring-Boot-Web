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
                        <h5>用户信息管理 <small>新增</small></h5>
                        <div class="ibox-tools">
                            
                        </div>
                    </div>
                    <div class="ibox-content">
                        <form action="user/saveAdd"  method="post" class="form-horizontal">
                        	<input type="hidden" name="USER_ID" id="user_id" value="${pd.USER_ID }"/>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">登录名</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="USERNAME" id="loginname">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">编号</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="SNUMBER" id="SNUMBER" onblur="hasN('${pd.USERNAME }')">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">密码</label>
                                <div class="col-sm-6">
                                    <input type="password" class="form-control" name="PASSWORD" id="password">
                                </div>
                                <div class="col-sm-2">
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
                                <label class="col-sm-2 control-label">确认密码</label>
                                <div class="col-sm-8">
                                    <input type="password" class="form-control" name="chkpwd" id="chkpwd">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">姓名</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="NAME" id="name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">手机号</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="PHONE" id="PHONE">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">邮箱</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="EMAIL" id="EMAIL" onblur="hasE('${pd.USERNAME }')">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">所属班组</label>
                                <div class="col-sm-8">
                                    <input type="hidden" class="form-control" name="DEPT_ID" id="DEPT_ID">
                                    <input type="text" class="form-control" name="DEPT_NAME" id="DEPT_NAME" readonly>
                                </div>
                                <div class="col-sm-1">
									<button class="btn btn-primary" type="button" onclick="openDeptSelect()">班组选择</button>
								</div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">备注</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="BZ" id="BZ">
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-2">
                                    <button class="btn btn-primary" type="button" onclick="save();">保存内容</button>
                                    <button class="btn btn-white" type="button" onclick="goBack();">取消</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>	
	</div>	
	<div id="myModal" class="modal inmodal fade" tabindex="-1" role="dialog"  aria-hidden="true"></div>
		<!-- 全局js -->
    <system:jsFooter/>
    <script src="hplus/js/plugins/jeditable/jquery.jeditable.js"></script>
	
    <!-- 自定义js -->
    <script src="hplus/js/content.min.js"></script>
    
    <script type="text/javascript">
	//保存
	function save(){
		if($("#loginname").val()=="" || $("#loginname").val()=="此用户名已存在!"){
			
			$("#loginname").tips({
				side:3,
	            msg:'输入用户名',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#loginname").focus();
			$("#loginname").val('');
			$("#loginname").css("background-color","white");
			return false;
		}else{
			$("#loginname").val(jQuery.trim($('#loginname').val()));
		}
		
		if($("#SNUMBER").val()==""){
			
			$("#SNUMBER").tips({
				side:3,
	            msg:'输入编号',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#SNUMBER").focus();
			return false;
		}else{
			$("#SNUMBER").val($.trim($("#SNUMBER").val()));
		}
		
		if($("#user_id").val()=="" && $("#password").val()==""){
			$("#password").tips({
				side:3,
	            msg:'输入密码',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#password").focus();
			return false;
		}
		if($("#password").val().length < 6 || $("#password").val().length > 30){
			$("#password").tips({
				side:3,
	            msg:'输入密码长度规则：大于等于6位或小于等于30位',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#password").focus();
			return false;
		}
		if($("#password").val()!=$("#chkpwd").val()){
			
			$("#chkpwd").tips({
				side:3,
	            msg:'两次密码不相同',
	            bg:'#AE81FF',
	            time:3
	        });
			
			$("#chkpwd").focus();
			return false;
		}
		if($("#name").val()==""){
			
			$("#name").tips({
				side:3,
	            msg:'输入姓名',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#name").focus();
			return false;
		}
		
		var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;
		if($("#PHONE").val()==""){
			
// 			$("#PHONE").tips({
// 				side:3,
// 	            msg:'输入手机号',
// 	            bg:'#AE81FF',
// 	            time:3
// 	        });
// 			$("#PHONE").focus();
// 			return false;
		}else if($("#PHONE").val().length != 11 && !myreg.test($("#PHONE").val())){
			$("#PHONE").tips({
				side:3,
	            msg:'手机号格式不正确',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#PHONE").focus();
			return false;
		}
		
		if($("#EMAIL").val()==""){
			
// 			$("#EMAIL").tips({
// 				side:3,
// 	            msg:'输入邮箱',
// 	            bg:'#AE81FF',
// 	            time:3
// 	        });
// 			$("#EMAIL").focus();
// 			return false;
		}else if(!ismail($("#EMAIL").val())){
			$("#EMAIL").tips({
				side:3,
	            msg:'邮箱格式不正确',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#EMAIL").focus();
			return false;
		}
		
		if($("#user_id").val()==""){
			hasU();
		}else{
			$("form").submit();
		}
	}
	
	function ismail(mail){
		return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
		}
	
	//判断用户名是否存在
	function hasU(){
		var USERNAME = $.trim($("#loginname").val());
		alert(USERNAME);
		$.ajax({
			type: "POST",
			url: 'user/hasU.do',
	    	data: {USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				//if("success" == data.result){
				 if(true == data){
					$("form").submit();
				 }else{
					$("#loginname").css("background-color","#D16E6C");
					setTimeout("$('#loginname').val('此用户名已存在!')",500);
				 }
			}
		});
	}
	
	//判断邮箱是否存在
	function hasE(USERNAME){
		var EMAIL = $.trim($("#EMAIL").val());
		$.ajax({
			type: "POST",
			url: 'user/hasE.do',
	    	data: {EMAIL:EMAIL,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#EMAIL").tips({
							side:3,
				            msg:'邮箱已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					setTimeout("$('#EMAIL').val('')",2000);
				 }
			}
		});
	}
	
	//判断编码是否存在
	function hasN(USERNAME){
		var NUMBER = $.trim($("#SNUMBER").val());
		$.ajax({
			type: "POST",
			url: 'user/hasN.do',
	    	data: {SNUMBER:NUMBER,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#SNUMBER").tips({
							side:3,
				            msg:'编号已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					setTimeout("$('#SNUMBER').val('')",2000);
				 }
			}
		});
	}
	
	function goBack(){
		this.location.href="<%=basePath%>user/listUsers";
	}
	
	
	function openDeptSelect(){
		$("#myModal").load("user/toDeptSelect?DEPT_ID="+$("#DEPT_ID").val(),function(){
			$("#myModal").modal();
		});
	}
	
</script>
	</body>
</html>

