<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
   <%@ include file="header.jsp"%> 
</head>

<body class="gray-bg top-navigation">
    <div id="wrapper">
        <div id="page-wrapper" class="gray-bg">
            <div class="row border-bottom white-bg">
                <nav class="navbar navbar-static-top" role="navigation">
                    <div class="navbar-header" style="background-color:honeydew;">
                        <button id="navButton" aria-controls="navbar" aria-expanded="false" data-target="#navbar" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
                            <i class="fa fa-reorder"></i>
                        </button>
                        <div class="navbar-brand" style="color:black;padding:0px 0px 0px 25px ;text-align: right" ><img height="45" style="margin-top:3px" src="<%=path %>/images/LOGO-0630-0.png"/></div>
                        <font id="sysname_font" class="navbar-brand" style="color:black;">${pd.SYSNAME } - 识别编审子系统</font>
                        
                    </div>
                    <div class="navbar-collapse collapse" id="navbar">
                        <ul class="nav navbar-nav">
                            <li class="dropdown" class="active">
                                <a aria-expanded="false" role="button" href="javascript:void(0);" onclick="openMenu('${pd.HOMEPAGE}',this)" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-desktop"></i>&nbsp;首页&nbsp;</a>
                            </li>
                            <c:forEach items="${menuList}" var="item" varStatus="i">
							<li class="dropdown">
                                <a aria-expanded="false" role="button" href="javascript:void(0);" onclick="openMenu('${item.MENU_URL}',this)" class="dropdown-toggle" data-toggle="dropdown">
                               	 <i class="fa ${item.MENU_ICON}"></i>${item.MENU_NAME} <span class="caret"></span>
                                </a>
                                <ul role="menu" class="dropdown-menu">
                                    <c:forEach items="${item.SubMenu}" var="subItem" varStatus="si">
										<li><a href="javascript:void(0);" onclick="openMenu('${subItem.MENU_URL}',this)"><i class="fa ${subItem.MENU_ICON}"></i>&nbsp;${subItem.MENU_NAME}</a>
										</li>
									</c:forEach>
                                </ul>
                            </li>
							</c:forEach>
                        </ul>
                        <ul class="nav navbar-nav" style="float:right;">
							<li class="dropdown">
                                <a aria-expanded="false" role="button" href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i>${user.NAME} <span class="caret"></span></a>
                                <ul role="menu" class="dropdown-menu">
									<li><a href="javascript:void(0);" onclick="changePwd()">修改密码</a>
									</li>
                                </ul>
                            </li>
<!--                             <li class="dropdown" id="msgDD"> -->
<!--                             <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">  -->
<!--                             <i class="fa fa-envelope"></i> <span class="label label-warning" id="msgNumTag">0</span> -->
<!-- 							</a> -->
<!-- 							<ul class="dropdown-menu dropdown-messages" style="overflow-y:scroll;" id="msgul"> -->
<!-- 								<li> -->
<!-- 									<div class="text-center link-block"> -->
<!-- 										<a href="javascript:void(0);" onclick="openAllMsg()"> <i -->
<!-- 											class="fa fa-envelope"></i> <strong> 查看所有消息</strong> -->
<!-- 										</a> -->
<!-- 									</div> -->
<!-- 								</li> -->
<!-- 								<li class="divider" id="msgList"></li> -->
<!-- 							</ul></li> -->
							
<!-- 							<li class="dropdown" id="alarmDD"> -->
<!--                             <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">  -->
<!--                             <i class="fa fa-envelope"></i> <span class="label label-warning" id="alarmNumTag">0</span> -->
<!-- 							</a> -->
<!-- 							<ul class="dropdown-menu dropdown-messages" style="overflow-y:scroll;" id="alarmul"> -->
<!-- 								<li> -->
<!-- 									<div class="text-center link-block"> -->
<!-- 										<a href="javascript:void(0);" onclick="openAllMsg()"> <i -->
<!-- 											class="fa fa-envelope"></i> <strong> 查看所有消息</strong> -->
<!-- 										</a> -->
<!-- 									</div> -->
<!-- 								</li> -->
<!-- 								<li class="divider" id="alarmList"></li> -->
<!-- 							</ul></li> -->
                            <li>
                                <a href="<%=basePath%>logout" >
                                    <i class="fa fa-sign-out"></i> 退出
                                </a>
                            </li>
                        </ul>
                        
                    </div>
                </nav>
            </div>
            <div class="wrapper wrapper-content">
                <iframe id="iframepage" src="welcome/homePage" frameborder="0" scrolling="auto" marginheight="0" marginwidth="0" width="100%" height="0"></iframe>

            </div>
            
            <div class="footer" style="position: fixed;bottom: 0;width: 100%;">
                <div class="pull-right">
                    By：<a href="javascript:window.open('http://www.maryun.net/index.html','_blank')" >MarYun.net</a>
                </div>
                <div>
                    <strong>Copyright</strong> MarYun.net &copy; 2017
                </div>
            </div>
        </div>
    </div>
	<div id="indexModal" class="modal inmodal fade" tabindex="-1"
		role="dialog" aria-hidden="true"></div>
	<div class="hplusProgress"></div>
    <%@ include file="jsFooter.jsp"%>
    <%--<script src="hplus/js/plugins/toastr/toastr.min.js"></script>
    --%>
    <script src="hplus/js/plugins/toastr/toastr.notmin.js"></script>
    <script>

        $(document).ready(function(){
        	var ifm= document.getElementById("iframepage");   
	    	ifm.height = $(window).height()-140;
	    	$("#msgul").height($(window).height()-300);
        });
    
        function openMenu(url,obj){
        	if(url=='#')
        		return false;
        	
        	if($("#navbar").attr("aria-expanded")=='true'){
        		$("#navButton").click();
        	}
        	document.getElementById("sysname_font").innerText ="${pd.SYSNAME }"+" -"+obj.innerText;
        	$("#iframepage").attr("src",url);
        	
        	if($(obj).parent().hasClass("dropdown")){
        		$(".active").removeClass("active");
        		$(obj).parent().parent().addClass("active");
        	}else if($(obj).parent().parent().parent().hasClass("dropdown")){
        		$(".active").removeClass("active");
        		$(obj).parent().parent().parent().addClass("active");
        	}
        	
        }
        
        function changePwd(){
    		$("#indexModal").load("toChangePwd",function(){
    			$("#indexModal").modal();
    		});
    	}
      //获取服务器设置，被message.js调用
        function getMessageServer(){
        	var server = '${msgServer}';
        	return server;
        }
        //获取用户信息，被message.js调用
        function getMessageUser(){
        	var user='${user.USERNAME}';
        	return user;
        }
      	//获取是否提醒，被message.js调用
        function getMessageEnabled(){
        	var msgEnabled='${msgEnabled}';
        	return msgEnabled;
        }
      	
      	
        
    	/**
    	 * 消息提醒
    	 * @param type success info warning error
    	 * @param msg 消息提醒内容
    	 * @param title 标题
    	 * @param clickmethod 点击回调的方法名-可以写在调用页面
    	 */
    	function doToast(type,msg,title,clickmethod,timeout,extendedTimeOut,closeBut,needClickHide){
    		toastr.options = {
    				  "closeButton": closeBut==null?true:closeBut,
    				  "debug": false,
    				  "progressBar": true,
    				  "positionClass": "toast-top-right",
    				  "onclick": clickmethod,
    				  "showDuration": "400",
    				  "hideDuration": "1000",
    				  "timeOut": timeout!=null?timeout:"10000",
    				  "extendedTimeOut": extendedTimeOut!=null?extendedTimeOut:"1000",
    				  "showEasing": "swing",
    				  "hideEasing": "linear",
    				  "showMethod": "fadeIn",
    				  "hideMethod": "fadeOut",
    				  "needClickHide":needClickHide== null?true:needClickHide
    				};
    		var toastrElement;
    		if(type!=null && "successinfowarningerrordtsdvsdx".indexOf(type)!=-1){
    			toastrElement = toastr[type](msg,title)
    		}else{
    			toastrElement = toastr['warning'](msg,title)
    		}
    		return toastrElement;
    	}
    	
    	 var msgNum = 0;
    	 var alarmNum = 0;
    	 Date.prototype.format = function(fmt)   
    	 {
    	   var o = {   
    	     "M+" : this.getMonth()+1,                 //月份   
    	     "d+" : this.getDate(),                    //日   
    	     "h+" : this.getHours(),                   //小时   
    	     "m+" : this.getMinutes(),                 //分   
    	     "s+" : this.getSeconds(),                 //秒   
    	     "q+" : Math.floor((this.getMonth()+3)/3), //季度   
    	     "S"  : this.getMilliseconds()             //毫秒   
    	   };   
    	   if(/(y+)/.test(fmt))   
    	     fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
    	   for(var k in o)   
    	     if(new RegExp("("+ k +")").test(fmt))   
    	   fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
    	   return fmt;   
    	 }
    	  
    	function showMessage(data){
    		  doToast(data.msgtype,data.message,data.title,null);
    		  
    		  var sendtime = "&nbsp;";
    		  
    		  if(data.sendtime!='undefined'){
    			  sendtime=new Date(data.sendtime).format("yyyy-MM-dd hh:mm:ss");
    		  }
    		  
    		  var msgHtml = '<li id=\"li'+data.messageid+'\">'
    			  		  + '<div class=\"dropdown-messages-box\">'
    			  		  + '<div class=\"media-body\">'
    			  		  + '<strong><i class=\"fa fa-envelope fa-fw\"></i></strong>'+data.message	
    			  		  + '<br>'
    			  		  + '<small class=\"text-muted\">'+sendtime+'</small><small class=\"text-muted\"><a href=\"javascript:void(0);\" onclick=\"readMsg(\''+data.messageid+'\');\"><i class=\"fa fa-envelope\"></i> <strong>接收</strong></a></small>'
    			  		  + '</div>'
    	                  + '</div>'
    	                  + '</li>'
    	                  + '<li class=\"divider\" id=\"lid'+data.messageid+'\"></li>';
    		  
    		  
    		  $("#msgList").after(msgHtml);
    		  msgNum++;
    		  $("#msgNumTag").html(msgNum);
    	}
    	
    	function readMsg (messageid){
    		$("#li"+messageid).remove();
    		$("#lid"+messageid).remove();
    		msgNum--;
    		$("#msgNumTag").html(msgNum);
    		socket.emit('recive message', messageid);
    	}
    	
    	function openAllMsg(){
    		$("#indexModal").load("message/listAllMsg",function(){
    			$("#indexModal").modal();
    		});
    	}
    	var tempdata;
    	function isEmpty(obj)
    	{
    	    for (var name in obj)
    	    {
    	        return false;
    	    }
    	    return true;
    	};
    	
    	
    	function getTimeDifference(alarmtime){
    		alarmtime = alarmtime.replace("T"," ").replace("Z","").replace(".000","");
    		var begintime_ms = Date.parse(new Date(alarmtime.replace(/-/g, "/")));  
    		var endtime="2016-04-20 05:16:18";
    		var d=  new Date()
    		var endtime_ms = d.getTime();// Date.parse(new Date(endtime.replace(/-/g, "/")));  
    		return endtime_ms-begintime_ms;
    	}
    	
    
    	function addEventHandler(obj,eventName,fun,param){
    	    var fn = fun;
    	    if(param)
    	    {
    	        fn = function(e)
    	        {
    	            fun.call(this, param);  
    	        }
    	    }
    	    if(obj.attachEvent){
    	        obj.attachEvent('on'+eventName,fn);
    	    }else if(obj.addEventListener){
    	        obj.addEventListener(eventName,fn,false);
    	    }else{
    	        obj["on" + eventName] = fn;
    	    }
    	}
    	
    </script>
    <!-- 消息组件 -->
	<script src="plugins/socketioMsg/socket.io/socket.io.js"></script>
	<script src="plugins/socketioMsg/message.js"></script>
</body>

</html>