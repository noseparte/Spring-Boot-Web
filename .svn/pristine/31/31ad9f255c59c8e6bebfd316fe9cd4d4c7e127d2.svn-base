<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>山东新媒体老伴儿业务管理平台</title>

<base href="<%=basePath%>">
<title>${pd.SYSNAME}</title>
<!-- <link rel="stylesheet" href="static/loginsimple/css/style.default.css" type="text/css" /> -->
<script type="text/javascript"
	src="static/loginsimple/js/plugins/jquery-1.7.min.js"></script>
<script type="text/javascript"
	src="static/loginsimple/js/plugins/jquery-ui-1.8.16.custom.min.js"></script>
<script type="text/javascript"
	src="static/loginsimple/js/plugins/jquery.cookie.js"></script>
<script type="text/javascript"
	src="static/loginsimple/js/plugins/jquery.uniform.min.js"></script>
<script type="text/javascript"
	src="static/loginsimple/js/custom/index.js"></script>

<link href="static/laobaner/css/css.css" rel="stylesheet"
	type="text/css">
	<!-- layim -->
<link href="http://127.0.0.1:9999/hplus/js/plugins/layim/css/layui.css" rel="stylesheet" />
<script src="http://127.0.0.1:9999/hplus/js/plugins/layer/layer.min.js"></script>
<!--<script type="text/javascript">
  window.onload=function(){
      var con=document.getElementById('con');
      con.style.height=($window.innerHeight)+'px';
      con.style.width=($window.innerWidth)+'px';
      }
  </script>
-->
<style type="text/css">
    .ripple-container {
          }
          .ripple-container .ripple{
              background-color: rgba(255,255,255,0.4);
              animation: ripple 2s forwards cubic-bezier(0, 0, 0.2, 1);
          }
          @keyframes ripple {
              0% {
                  transform: scale(0);
                  opacity: 1;
              }
              80% {
                  transform: scale(1);
              }
              100% {
                  opacity: 0;
              }
          }
        
  </style>
<script>
	//TOCMAT重启之后 点击左侧列表跳转登录首页 
	if (window != top) {
		top.location.href = location.href;
	}
	function setFocus(id) {
		var element = document.getElementById(id);
		element.focus();
		element.value = element.value;
		var elementTop = $("#" + id).offset().top; // $element是保存的input
		var elementBottom = elementTop - 100;
		var t = setTimeout("window.scrollTo(0," + elementBottom + ")", 100);
	}
</script>
</head>

<body class="loginpage" style="text-align: center; font-family:"微软雅黑";">
	<div class="img"></div>

	<div class="con">
		<div class="text">
			<p>老伴儿智慧健康综合服务云平台</p>
		</div>

		<form id="login" action="dashboard.html" method="post">
			<div class="denglu">
				<div class="input_01">
					<input name="loginname" onfocus="this.placeholder=''" onblur="if(this.placeholder==''){this.placeholder='请输入帐号'}" onclick="setFocus(this.id)" id="loginname" class="yhm" placeholder="请输入用帐号">
				</div>
				<div class="input_02">
					<input  name="password" onfocus="this.placeholder=''" onblur="if(this.placeholder==''){this.placeholder='请输入密码'}"  onclick="setFocus(this.id)" id="password" type="password" class="yhm" placeholder="请输入密码">
				</div>
				<div class="input_03">
					<input  name="code" onfocus="this.placeholder=''"  onblur="if(this.placeholder==''){this.placeholder='请输入验证码'}"  id="code" type="text" class="yhm_0" placeholder="请输入验证码">
				</div>
				<div class="input_04" ><img style="height:100%; width:120%" id="codeImg" alt="点击更换"
								title="点击更换" src="" /></div>

				<div class="input_05">
					<img src="static/laobaner/img/shuaxin.png" width="20" height="20">
				</div>
				<div class="input_06">
					<button data-ripple style="background: transparent; width:100%;height:100%;line-height:40px;cursor: pointer;border: 0px;color:white;font-size: 16px;outline: none;">登录</button> 
				</div>

			</div>

		</form>
		</br>
		<div class="loginbox" >
			<div class="errarginfo">
				<div class="loginmsg">缺少参数.</div>
			</div>
			<!--errarginfo-->
			<div class="errTimeinfo">
				<div class="loginmsg">登录失败多次，账户锁定10分钟.</div>
			</div>
			<div class="errscodeinfo">
				<div class="loginmsg">验证码输入有误.</div>
			</div>
			<!--errscodeinfo-->
			<div class="erruserinfo">
				<div class="loginmsg">账号或密码错误.</div>
			</div>
			<!--erruserinfo-->
			<div class="nousername">
				<div class="loginmsg">请输入账号.</div>
			</div>
			<!--nousername-->
			<div class="nopassword">
				<div class="loginmsg">请输入密码.</div>
			</div>
			<!--nopassword-->
			<div class="nologincode">
				<div class="loginmsg">请输入验证码.</div>
			</div>
			<!--nologincode-->
			<div class="userVisitorNoStart">
				<div class="loginmsg">您登陆帐号未被启用，请与管理员联系.</div>
			</div>
			<!--userNoStart-->
		</div>
	</div>


<script src="plugins/utils/ripple.js"></script>

<script type="text/javascript">
    // just add effect to elements
        Array.prototype.forEach.call(document.querySelectorAll('[data-ripple]'), function(element){
            // find all elements and attach effect
            new RippleEffect(element); // element is instance of javascript element node
        });
  </script>
<script type="text/javascript">
	$(document).ready(function() {
		changeCode();
		$("#codeImg").bind("click", changeCode);
	});
	function changeCode() {
		$("#codeImg").attr("src", "code.do?t=" + genTimestamp());
	}
	var browser=navigator.appName 
	var b_version=navigator.appVersion 
	var version=b_version.split(";"); 
	var trim_Version=version[1].replace(/[ ]/g,""); 
	for (var i = 6; i < 10; i++) {
		if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE"+i+".0") 
		{ 
			layer.msg('请使用ie9以上版本的浏览器登录本系统！', {
					icon: 4
				  ,shade: 0.5
				  ,time:60*60*60*1000
				});
		} 
	}
</script>
</body>
</html>

