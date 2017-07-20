<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="cn">
<head>
<%@ include file="header.jsp"%>
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow: hidden">
	<div id="wrapper">
		<!--左侧导航开始-->
		<nav class="navbar-default navbar-static-side" role="navigation">
			<div class="nav-close">
				<i class="fa fa-times-circle"></i>
			</div>
			<div class="sidebar-collapse">
				<ul class="nav" id="side-menu">
					<c:forEach items="${menuList}" var="item" varStatus="i">
						<li>
							<a href="${item.MENU_URL}"> 
								<i class="fa ${item.MENU_ICON}"></i>
								<span class="nav-label">${item.MENU_NAME}</span> 
								<span class="fa arrow"></span>
							</a>
							<ul class="nav nav-second-level">
								<c:forEach items="${item.SubMenu}" var="subItem" varStatus="si">
									<li>
										<a class="J_menuItem" href="${subItem.MENU_URL}">
											<i class="fa ${subItem.MENU_ICON}"></i>
											${subItem.MENU_NAME}
										</a>
									</li>
								</c:forEach>
							</ul>
						</li>
					</c:forEach>
				</ul>
			</div>
		</nav>
					
						<!-- <li><a href=""> 
								<i class="fa"></i>
								<span class="nav-label">系统设置</span> 
								<span class="fa arrow"></span>
						</a>
							<ul class="nav nav-second-level">
									<li>
										<a class="J_menuItem" href="menu/listMenus"><i class="fa "></i>菜单管理</a>
									</li>
									<li>
										<a class="J_menuItem" href="button/listButtons"><i class="fa "></i>按钮管理</a>
									</li>
									<li>
										<a class="J_menuItem" href="dept/listDepts"><i class="fa "></i>部门管理</a>
									</li>
									<li>
										<a class="J_menuItem" href="dic/listDics"><i class="fa "></i>数据字段管理</a>
									</li>
									<li>
										<a class="J_menuItem" href="role/listRoles"><i class="fa "></i>角色管理</a>
									</li>
									<li>
										<a class="J_menuItem" href="user/listUsers"><i class="fa "></i>用户管理</a>
									</li>
							</ul></li> -->
					
					
					
					

		<!--左侧导航结束-->

		<!--右侧部分开始-->
		<div id="page-wrapper" class="gray-bg dashbard-1">
			<div class="row border-bottom">
				<nav class="navbar navbar-static-top" role="navigation"
					style="margin-bottom: 0">
					<ul class="nav navbar-top-links navbar-left mini-navbar-hidden">
						<li class="dropdown" style="padding-top:5px;">
							<img src="${pd.LOGO }" height="50px">
							<font style="font-size:large;">${pd.SYSNAME }</font>
						</li>
					</ul>
					<ul class="nav navbar-top-links navbar-right">
						<li class="dropdown mini-navbar-show">
						<button class="navbar-minimalize-title  roll-nav" style="background-color:#1ab394;color:#fff;padding: 6px 12px;font-size: 14px;border:0;margin-left:10px;">
							<i class="fa fa-reorder"></i>
						</button>
						</li>
						<li class="dropdown">
							<!-- <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                               	 欢迎你，系统管理员
                            </a> --> <a data-toggle="dropdown"
							class="dropdown-toggle" href="#"> <span
								class="text-muted text-xs block"><i class="fa fa-user"></i>${user.NAME}<b class="caret"></b></span>
						</a>
							<ul class="dropdown-menu animated fadeInRight">
								<li>
										<a href="javascript:void(0);" onclick="changePwd()">修改密码</a>
								</li>

							</ul>
						</li>
						<li class="dropdown" id="msgDD"><a
							class="dropdown-toggle count-info" data-toggle="dropdown"
							href="#"> <i class="fa fa-envelope"></i> <span
								class="label label-warning" id="msgNumTag">0</span>
						</a>
							<ul class="dropdown-menu dropdown-messages">

								<li>
									<div class="text-center link-block">
										<a href="javascript:void(0);" onclick="openAllMsg()"> <i
											class="fa fa-envelope"></i> <strong> 查看所有消息</strong>
										</a>
									</div>
								</li>
								<li class="divider" id="msgList"></li>

							</ul></li>
						<li class="hidden-xs"><a href="<%=basePath%>logout "
							class="J_menuItem" data-index="0"><i class="fa fa-sign-out"></i>退出</a>
						</li>

					</ul>
				</nav>
			</div>
			<div class="row content-tabs">
				<button class="navbar-minimalize  roll-nav J_tabLeft">
					<i class="fa fa-bars"></i>
				</button>
				<button class="roll-nav roll-left J_tabLeft" style="left:40px;">
					<i class="fa fa-backward"></i>
				</button>
				<nav class="page-tabs J_menuTabs">
					<div class="page-tabs-content">
						<a href="javascript:;" class="active J_menuTab"
							data-id="${pd.HOMEPAGE}">首页</a>
					</div>
				</nav>
				<button class="roll-nav roll-right J_tabRight">
					<i class="fa fa-forward"></i>
				</button>
				<div class="btn-group roll-nav roll-right">
					<button class="dropdown J_tabClose" data-toggle="dropdown">
						关闭操作

					</button>
					<ul role="menu" class="dropdown-menu dropdown-menu-right">
						<li class="J_tabShowActive"><a>关闭当前选项卡</a></li>
						<li class="divider"></li>
						<li class="J_tabCloseAll"><a>关闭全部选项卡</a></li>
						<li class="J_tabCloseOther"><a>关闭其他选项卡</a></li>
					</ul>
				</div>
			</div>
			<div class="row J_mainContent" id="content-main">
				<iframe class="J_iframe" id="iframepage" name="iframe0" width="100%" height="100%"
					src="" seamless></iframe>
			</div>
			<div class="footer">
				<div class="pull-right">
					&copy; 2015-2017 <a
						href="javascript:window.open('http://www.maryun.net/index.html','_blank')">MarYun.net</a>
				</div>
			</div>
		</div>
		<!--右侧部分结束-->
		<!--右侧边栏开始-->
		<div id="right-sidebar">
			<div class="sidebar-container">
				<ul class="nav nav-tabs navs-3">
					<li class="active"><a data-toggle="tab" href="#tab-1"> 主题
					</a></li>
				</ul>
				<div class="tab-content">
					<div id="tab-1" class="tab-pane active">
						<div class="skin-setttings">
							
							<div class="setings-item">
								<span>固定顶部</span>

								<div class="switch">
									<div class="onoffswitch">
										<input type="checkbox" checked="checked" name="fixednavbar"
											class="onoffswitch-checkbox" id="fixednavbar"> <label
											class="onoffswitch-label" for="fixednavbar"> <span
											class="onoffswitch-inner"></span> <span
											class="onoffswitch-switch"></span>
										</label>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<!--右侧边栏结束-->
	</div>



	<div id="indexModal" class="modal inmodal fade" tabindex="-1"
		role="dialog" aria-hidden="true"></div>
	<!-- 全局js -->
	<%@ include file="jsFooter.jsp"%>

	<script src="hplus/js/plugins/metisMenu/jquery.metisMenu.js"></script>
	<script src="hplus/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

	<!-- 自定义js -->
	<script src="hplus/js/hplus.js"></script>
	<script src="hplus/js/contabs.min.js" type="text/javascript"></script>

	<!-- 第三方插件 -->
	<!-- 第三方插件 -->
	<script src="hplus/js/plugins/pace/pace.min.js"></script>
	<script src="hplus/js/plugins/toastr/toastr.min.js"></script>

	<script type="text/javascript">
    //锁定头部
    //$("#fixednavbar").trigger("click");
    $("#fixednavbar").is(":checked") ? ($(".navbar-static-top").removeClass("navbar-static-top").addClass("navbar-fixed-top"), $("body").removeClass("boxed-layout"), $("body").addClass("fixed-nav"), $("#boxedlayout").prop("checked", !1), localStorageSupport && localStorage.setItem("boxedlayout", "off"), localStorageSupport && localStorage.setItem("fixednavbar", "on")) : ($(".navbar-fixed-top").removeClass("navbar-fixed-top").addClass("navbar-static-top"), $("body").removeClass("fixed-nav"), localStorageSupport && localStorage.setItem("fixednavbar", "off"));
    //消息序号
    var crtNo = 0;
    var msgType = '';
    var msgTxt = '';
    
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
	function doToast(type,msg,title,clickmethod){
		toastr.options = {
				  "closeButton": true,
				  "debug": false,
				  "progressBar": true,
				  "positionClass": "toast-top-right",
				  "onclick": clickmethod,
				  "showDuration": "400",
				  "hideDuration": "1000",
				  "timeOut": "10000",
				  "extendedTimeOut": "1000	",
				  "showEasing": "swing",
				  "hideEasing": "linear",
				  "showMethod": "fadeIn",
				  "hideMethod": "fadeOut"
				};
		if(type!=null && "successinfowarningerror".indexOf(type)!=-1){
			toastr[type](msg,title)
		}else{
			toastr['warning'](msg,title)
		}
	}
	
	 var msgNum = 0;
	 
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
	
	
	function changePwd(){
		$("#indexModal").load("toChangePwd",function(){
			$("#indexModal").modal();
		});
	}
	 function fullScreen(element) {
		    var el = document.getElementById("iframepage"),
		        rfs = el.requestFullScreen || el.webkitRequestFullScreen || el.mozRequestFullScreen || el.msRequestFullScreen,
		        wscript;
		 
		    if(typeof rfs != "undefined" && rfs) {
		        rfs.call(el);
		        return;
		    }
		 
		    if(typeof window.ActiveXObject != "undefined") {
		        wscript = new ActiveXObject("WScript.Shell");
		        if(wscript) {
		            wscript.SendKeys("{F11}");
		        }
		    }
		}
function exitFullScreen() {
	  if(document.exitFullscreen) {
	    document.exitFullscreen();
	  } else if(document.mozCancelFullScreen) {
	    document.mozCancelFullScreen();
	  } else if(document.webkitExitFullscreen) {
	    document.webkitExitFullscreen();
	  }	}
		var __sto = setInterval;
		window.setInterval = function(callback,timeout,param){    
		    var args = Array.prototype.slice.call(arguments,2);     
		    var _cb = function(){     
		        callback.apply(null,args);
		    };
		    __sto(_cb,timeout);
		}
		//病历窗口打开状态
		var openWin_history = false;
		//聊天记录窗口打开状态
		var openWin_chatLog = false;
		//病历窗口index
		var winIndex_history = null;
		//聊天记录窗口index
		var winIndex_chatLog = null;
		$(document).ready(function (){
			//导医人员显示IM聊天界面
			if("2" == "${user.TYPE}"){
				$.ajax({
					type: "POST",
					url: '/app/im/customerOnline?tm=' +  new Date().getTime(),
					data: {
						HANDLER_ID: "${user.USER_ID}",
						USER_NAME: "${user.NAME}"
					},
					async: true,
					dataType: 'json',
					cache: false,
					success: function(data) {
						console.info(data);
					}
				}); 
				layim_chat();
			}
		});
		//打开聊天界面
		function layim_chat() {
			layui.use('layim', function(layim){
				var layim = layui.layim;
				layim.config({
					init: {
					  //配置客服信息
						mine: {
							username: "${user.NAME}", //我的昵称
							id: "${user.USER_ID}", //我的ID
							status: "online", //在线状态 online：在线、hide：隐身
							remark: "", //我的签名
							avatar: "http://tp1.sinaimg.cn/5619439268/180/40030060651/1" //我的头像
						}
					},
					//上传图片接口
				    uploadImage: {
						url: '/filesUploads/uploadImHeadPortrait?MASTER_ID=IM', //返回的数据格式见下文
						type: '', //默认post
						success: function(res, to, mine){
							/*console.info(res);
							console.info(mine);
							console.info(to);*/
							$.ajax({
								type: "POST",
								url: '/app/im/customerSendMsg?tm=' +  new Date().getTime(),
								data: {
									TITLE_ID: to.data.titleId,
									CONTENT: res.data.srcSlt,
									IMAGE_PATH: res.data.src,
									MESSAGETYPE: '2'//1：消息、2：图片
								},
								async: true,
								dataType: 'json',
								cache: false,
								success: function(data) {
									if(data.state != 200){
										layer.msg("发送消息错误，请重新发送或与管理员联系！");
									}
								}
							});
							if(res.code == 0){
								layer.msg(res.msg);
							}else{
								layer.msg("上传图片出现网络故障！");
							}
						}
				    },
					tool: [{
						alias: 'history', //工具别名
						title: '病历', //工具名称
						icon: '&#xe60a;' //工具图标，参考图标文档
					}, {
						alias: 'chatLog', //工具别名
						title: '聊天记录', //工具名称
						icon: '&#xe63a;' //工具图标，参考图标文档
					}, {
						alias: 'Online', //工具别名
						title: '上线', //工具名称
						icon: '&#xe60e;' //工具图标，参考图标文档&#xe604;
					}, {
						alias: 'Offline', //工具别名
						title: '下线', //工具名称
						icon: '&#x1006;' //工具图标，参考图标文档
					}],
					/*&#xe611;&#xe614;&#x1002;&#xe60f;&#xe615;&#xe641;&#xe620;&#xe628;&#x1006;&#x1007;&#xe629;&#xe600;&#xe617;&#xe606;&#xe609;&#xe60a;
					&#xe62c;&#x1005;&#xe61b;&#xe610;&#xe62d;&#xe63d;&#xe602;&#xe603;&#xe62e;&#xe62f;&#xe61f;&#xe601;&#xe630;&#xe631;&#xe642;&#xe644;
					&#xe645;&#xe61a;&#xe621;&#xe632;&#xe618;&#xe608;&#xe633;&#xe61c;&#xe634;&#xe607;&#xe635;&#xe636;&#xe60b;&#xe619;&#xe637;&#xe61d;
					&#xe640;&#xe604;&#xe612;&#xe605;&#xe638;&#xe60c;&#xe616;&#xe613;&#xe61e;&#xe60d;&#xe64c;&#xe60e;&#xe622;&#xe64f;&#xe64d;&#xe639;
					&#xe63e;&#xe623;&#xe63f;&#xe643;&#xe647;&#xe648;&#xe649;&#xe626;&#xe627;&#xe62b;&#xe63a;&#xe624;&#xe63b;&#xe650;&#xe64b;&#xe63c;
					&#xe62a;&#xe64e;&#xe646;&#xe625;&#xe64a;*/
					//chatLog: layui.cache.dir + 'css/modules/layim/html/chatlog.html', //聊天记录页面地址
					brief: false,//开启客服模式
					isfriend:false,//开启好友
					isgroup:false//开启分组
				});
				//初次加载
				getChats(layim);
				//监听自定义工具栏
				layim.on('tool(history)', function(insert, send, obj){//病历
					if(openWin_history){
						layer.close(winIndex_history);
					}
					openWin_history = !openWin_history;
					//患者ID
					var userId = obj.data.id;
					//患者名称
					var userName = obj.data.name;
					//会话ID
					var titleId = obj.data.titleId;
					winIndex_history = openLayerWin('history', 'userHistoryID_' + userId, '患者&nbsp;' + userName + '&nbsp;病历及备忘录', '400px', '92.5%', 'lb', '/caseHist/toEditByChat?UI_ID=' + userId + "&TITLE_ID=" + titleId);
				}).on('tool(chatLog)', function(insert, send, obj){//聊天记录
					if(openWin_chatLog){
						layer.close(winIndex_chatLog);
						//layer.iframeSrc(winIndex_chatLog, '/commMemo/toLists?UI_ID=' + userId + "&TITLE_ID=" + titleId);
					}
					openWin_chatLog = !openWin_chatLog;
					//患者ID
					var userId = obj.data.id;
					//患者名称
					var userName = obj.data.name;
					//会话ID
					var titleId = obj.data.titleId;
					//winIndex_chatLog = openLayerWin('chatlog', 'userChatlogID_' + userId, '与&nbsp;' + userName + '&nbsp;的聊天记录', '400px', '92.5%', 'rb', '/chat/toChatlog?UI_ID=' + userId + "&TITLE_ID=" + titleId);
					winIndex_chatLog = openLayerWin('chatlog', 'userChatlogID_' + userId, '与&nbsp;' + userName + '&nbsp;的聊天记录', '400px', '92.5%', 'rb', '/commMemo/toLists?UI_ID=' + userId + "&TITLE_ID=" + titleId);
				}).on('tool(Online)', function(insert, send, obj){//上线
					$.ajax({
						type: "POST",
						url: '/app/im/customerOnline?tm=' +  new Date().getTime(),
						data: {
							HANDLER_ID: "${user.USER_ID}",
							USER_NAME: "${user.USER_NAME}"
						},
						async: true,
						dataType: 'json',
						cache: false,
						success: function(data) {
							layer.msg("导医[ ${user.NAME} ]已上线！");
						}
					});
				}).on('tool(Offline)', function(insert, send, obj){//下线
					$.ajax({
						type: "POST",
						url: '/app/im/customerOffline?tm=' +  new Date().getTime(),
						data: {
							HANDLER_ID: "${user.USER_ID}"
						},
						async: true,
						dataType: 'json',
						cache: false,
						success: function(data) {
							layer.msg("导医[ ${user.NAME} ]已下线！");
							layim.setChatMin(); //收缩聊天面板
						}
					});
				}).on('chatChange', function(res){//监听聊天窗口切换
					var userType = res.data.type;
					var userName = res.data.name;
					var userId = res.data.id;
					var titleId = res.data.titleId;
					/*if(openWin_chatLog){
						layer.close(winIndex_chatLog);
					}*/
					//layer.closeAll('iframe');
					/* if(openWin_history){
						winIndex_history = openLayerWin('history', 'userHistoryID_' + userId, '患者&nbsp;' + userName + '&nbsp;病历及备忘录', '400px', '92.5%', 'lb', '/caseHist/toEditByChat?UI_ID=' + userId + "&TITLE_ID=" + titleId);
					} */
					if(openWin_chatLog){
						layer.title('与&nbsp;' + userName + '&nbsp;的聊天记录', winIndex_chatLog);
						layer.iframeSrc(winIndex_chatLog, '/commMemo/toLists?UI_ID=' + userId + "&TITLE_ID=" + titleId);
						//winIndex_chatLog = openLayerWin('chatlog', 'userChatlogID_' + userId, '与&nbsp;' + userName + '&nbsp;的聊天记录', '400px', '92.5%', 'rb', '/commMemo/toLists?UI_ID=' + userId + "&TITLE_ID=" + titleId);
						//winIndex_chatLog = openLayerWin('chatlog', 'userChatlogID_' + userId, '与&nbsp;' + userName + '&nbsp;的聊天记录', '400px', '92.5%', 'rb', '/chat/toChatlog?UI_ID=' + userId + "&TITLE_ID=" + titleId);												
					}
				}).on('sendMessage', function(res){//监听发送消息
					var mine = res.mine; //包含我发送的消息及我的信息
					var to = res.to; //对方的信息
					var flag = res.flag;
					//只发送点击“发送”的内容
					if(flag != '2'){
						$.ajax({
							type: "POST",
							url: '/app/im/customerSendMsg?tm=' +  new Date().getTime(),
							data: {
								TITLE_ID: to.titleId,
								CONTENT: mine.content,
								MESSAGETYPE: '1'//1：消息、2：图片
							},
							async: true,
							dataType: 'json',
							cache: false,
							success: function(data) {
								if(data.state != 200){
									layer.msg("发送消息错误，请重新发送或与管理员联系！");
								}
							}
						});
					}
				});
				window.setInterval(getChats, 1 * 20 * 1000, layim);
				//收缩聊天面板
				//layim.setChatMin();
			});
		}
		//定时刷新患者列表
		function getChats(layim){
			$.ajax({
				type: "POST",
				url: '/app/im/customerTitles?tm=' +  new Date().getTime(),
				data: {
					HANDLER_ID: "${user.USER_ID}"
				},
				async: true,
				dataType: 'json',
				cache: false,
				success: function(data) {
					var newInfo = "";
					var content = "";
					var time = "";
					var contentList = "";
					var imgServer = data.IMGSERVER;
					if(null != data.NEWTITLE && data.NEWTITLE.length > 0){
						for(var i_tmp = 0; i_tmp < data.NEWTITLE.length; i_tmp++){
							contentList = data.NEWTITLE[i_tmp].CONTENTLIST;
							if(null != contentList && contentList != ''){
								for(var j_tmp = 0; j_tmp < contentList.length; j_tmp++){
									if("2" == contentList[j_tmp].MESSAGETYPE){
										content += "img[" + imgServer + contentList[j_tmp].CONTENT + "]";
									}else if("1" == contentList[j_tmp].MESSAGETYPE){
										content += contentList[j_tmp].CONTENT;
									}
									time = contentList[j_tmp].CREATE_TIME;
								}
							}
							/* if(null != content && content != ''){
								newInfo = "<span>新消息</span>";
							}else{
								newInfo = "";
							} */
							layim.chat({
								titleId: data.NEWTITLE[i_tmp].TITLE_ID, //会话ID
								name: data.NEWTITLE[i_tmp].USER_NAME, //名称
								type: 'kefu', //聊天类型
								avatar: imgServer + data.NEWTITLE[i_tmp].USER_PHOTO, //头像'http://tp1.sinaimg.cn/5619439268/180/40030060651/1'
								id: data.NEWTITLE[i_tmp].USER_ID //定义唯一的id方便你处理信息
							});
							if(null != content && content.length > 0){
								layim.getMessage({
									  username: data.NEWTITLE[i_tmp].USER_NAME, //消息来源用户名
									  avatar: imgServer + data.NEWTITLE[i_tmp].USER_PHOTO, //消息来源用户头像
									  id: data.NEWTITLE[i_tmp].USER_ID, //消息的来源ID（如果是私聊，则是用户id，如果是群聊，则是群组id）
									  type: "kefu", //聊天窗口来源类型，从发送消息传递的to里面获取
									  content: content, //消息内容
									  mine: false, //是否我发送的消息，如果为true，则会显示在右方
									  fromid: data.NEWTITLE[i_tmp].USER_ID, //消息的发送者id（比如群组中的某个消息发送者），可用于自动解决浏览器多窗口时的一些问题
									  timestamp: time //服务端动态时间戳
								});
								content = "";
							}
						}
					}
					if(null != data.OLDTITLE && data.OLDTITLE.length > 0){
						for(var i_tmp = 0; i_tmp < data.OLDTITLE.length; i_tmp++){
							contentList = data.OLDTITLE[i_tmp].CONTENTLIST;
							if(null != contentList && contentList != ''){
								for(var j_tmp = 0; j_tmp < contentList.length; j_tmp++){
									if("2" == contentList[j_tmp].MESSAGETYPE){
										content += "img[" + imgServer + contentList[j_tmp].CONTENT + "]";
									}else if("1" == contentList[j_tmp].MESSAGETYPE){
										content += contentList[j_tmp].CONTENT;
									}
									time = contentList[j_tmp].CREATE_TIME;
								}
							}
							/* if(null != content && content != ''){
								newInfo = "<span>新消息</span>";
							}else{
								newInfo = "tmp";
							} */
							layim.chat({
								titleId: data.OLDTITLE[i_tmp].TITLE_ID, //会话ID
								name: data.OLDTITLE[i_tmp].USER_NAME, //名称
								type: 'kefu', //聊天类型
								avatar: imgServer + data.OLDTITLE[i_tmp].USER_PHOTO, //头像'http://tp1.sinaimg.cn/5619439268/180/40030060651/1'
								id: data.OLDTITLE[i_tmp].USER_ID //定义唯一的id方便你处理信息
							});
							if(null != content && content.length > 0){
								layim.getMessage({
									  username: data.OLDTITLE[i_tmp].USER_NAME, //消息来源用户名
									  avatar: imgServer + data.OLDTITLE[i_tmp].USER_PHOTO, //消息来源用户头像
									  id: data.OLDTITLE[i_tmp].USER_ID, //消息的来源ID（如果是私聊，则是用户id，如果是群聊，则是群组id）
									  type: "kefu", //聊天窗口来源类型，从发送消息传递的to里面获取
									  content: content, //消息内容
									  mine: false, //是否我发送的消息，如果为true，则会显示在右方
									  fromid: data.OLDTITLE[i_tmp].USER_ID, //消息的发送者id（比如群组中的某个消息发送者），可用于自动解决浏览器多窗口时的一些问题
									  timestamp: time //服务端动态时间戳
								});
								content = "";
							}
						}
					}
				}
			});
		}
		//打开Layer Iframe窗口
		function openLayerWin(flag, id, title, height, width, offset, url){
			var index = layer.open({
				id: id,
				type: 2,
				title: title,//窗体标题
				area: [height, width],//整个窗体宽、高，单位：像素px
				fix: true,//窗体位置固定
				offset: offset,//坐标
				shade: 0,//遮罩
				maxmin: true,//最大、小化是否显示
				scrollbar: false,//整体页面滚动条是否显示
				content: [url, 'yes'],//URL地址
				closeBtn: 0,//显示关闭按钮
				btn: ['关闭'],
				btn1: function(indexWin, layero){
					layer.confirm('确认关闭患者病历窗口，导医自行保存信息，否则信息将丢失？', {
						icon: 3,
						title: '关闭提示'
					}, function(index){
						if('history' == flag){
							openWin_history = false;
						}
						if('chatlog' == flag){
							openWin_chatLog = false;
						}
						layer.close(indexWin);
						layer.close(index);
					});
				}
			});
			return index;
		}
    </script>
	<!-- 消息组件 -->
	<script src="plugins/socketioMsg/socket.io/socket.io.js"></script>
	<!-- <script src="plugins/socketioMsg/message.js"></script> -->
</body>
</html>