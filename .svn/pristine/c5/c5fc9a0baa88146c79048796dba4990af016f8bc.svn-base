<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
%>
	
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="favicon.ico"/>
<link rel="bookmark" href="favicon.ico"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0,  user-scalable=0;" name="viewport" />
<base href="<%=basePath%>">
<title>${pd.SYSNAME}</title>
<link rel="stylesheet" href="static/loginsimple/css/style.default.css" type="text/css" />
<script type="text/javascript" src="static/loginsimple/js/plugins/jquery-1.7.min.js"></script>
<script type="text/javascript" src="static/loginsimple/js/plugins/jquery-ui-1.8.16.custom.min.js"></script>
<script type="text/javascript" src="static/loginsimple/js/plugins/jquery.cookie.js"></script>
<script type="text/javascript" src="static/loginsimple/js/plugins/jquery.uniform.min.js"></script>
<script type="text/javascript" src="static/loginsimple/js/custom/index.js"></script>

<script>
	//TOCMAT重启之后 点击左侧列表跳转登录首页 
	if (window != top) {
		top.location.href = location.href;
	}
	function setFocus(id) {
	    var element = document.getElementById(id);
	    element.focus();
	    element.value = element.value;
	    var elementTop = $("#"+id).offset().top; // $element是保存的input
	    var elementBottom = elementTop - 100;
        var t=setTimeout("window.scrollTo(0,"+elementBottom+")",100); 
	}
</script>
</head>

<body class="loginpage">
	<div class="loginbox">
    	<div class="loginboxinner">
        	
          <%-- <div class="logo">
            	<h1 class="logo">${pd.BIG_TITLE}<br/><span>${pd.TITLE}</span></h1>
				<span class="slogan">${pd.SUB_TITLE}</span>
            </div><!--logo--> --%>
            
            <div class="logo">
            	<h1 class="logo">山东新媒体老伴儿<br />业务管理平台</h1>
				<!-- <span class="slogan">业务管理平台</span> -->
            </div><!--logo-->
            
            <br clear="all" /><br />
            
            <div class="errarginfo">
				<div class="loginmsg">缺少参数.</div>
            </div><!--errarginfo-->
            <div class="errTimeinfo">
				<div class="loginmsg">登录失败多次，账户锁定10分钟.</div>
            </div>
            <div class="errscodeinfo">
				<div class="loginmsg">验证码输入有误.</div>
            </div><!--errscodeinfo-->
            <div class="erruserinfo">
				<div class="loginmsg">账号或密码错误.</div>
            </div><!--erruserinfo-->
            <div class="nousername">
				<div class="loginmsg">请输入账号.</div>
            </div><!--nousername-->
            <div class="nopassword">
				<div class="loginmsg">请输入密码.</div>
            </div><!--nopassword-->
            <div class="nologincode">
				<div class="loginmsg">请输入验证码.</div>
            </div><!--nologincode-->
            <div class="userVisitorNoStart">
				<div class="loginmsg">您登陆帐号未被启用，请与管理员联系.</div>
            </div><!--userNoStart-->
            <form id="login" action="dashboard.html" method="post">
            	
                <div class="username">
                	<div class="usernameinner">
                    	<input type="text" name="loginname" onclick="setFocus(this.id)" id="loginname"  value="admin"/>
                    </div>
                </div>
                
                <div class="password">
                	<div class="passwordinner">
                    	<input type="password" name="password" onclick="setFocus(this.id)" id="password" value="123456"/>
                    </div>
                </div>
                <div class="scode">
                	<div class="scodeinner" onclick="setFocus('code')" >
                    	<input type="text" name="code" id="code" value=""/><img style="height:32px;" id="codeImg" alt="点击更换"
								title="点击更换" src="" /> 
                    </div>
                </div>
                <button>登录</button>
                
                <!-- <div class="keep"><input type="checkbox" id="saveid" onclick="savePaw();" /> <span style="vertical-align:middle">记住密码</span></div> -->
            
            </form>
            
        </div><!--loginboxinner-->
    </div><!--loginbox-->


</body>
<script type="text/javascript">
	$(document).ready(function() {
		changeCode();
		$("#codeImg").bind("click", changeCode);
	});
	function changeCode() {
		$("#codeImg").attr("src", "code.do?t=" + genTimestamp());
	}
</script>
</html>
