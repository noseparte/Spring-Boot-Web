<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10">
<system:header/> 
<link href="static/img/css.css" type="text/css" rel="stylesheet">
	<style type="text/css">
		.bg_sjfx {
		    background: url("static/img/sjfx_main_bg.png") no-repeat center top;
		    width: 100%;
		    height: 100%;
		    margin: 0 auto;
		    max-height: 600px;
		    overflow-x: hidden;
		    overflow-y: hidden;
		}
	    .sj_icon1 dl {
	        display: inline-block;
	        background: url("static/img/icon_bg.png") no-repeat center top;
	        height: 160px;
	        width: 160px;
	        margin-right: 15px;
	        margin-left: 15px;
	        text-align: center;
	        vertical-align: top;
	    }
	</style>
</head>
<body class="gray-bg" >
	<div id="lg_bg3">
		<div class="main1175">
			<!--主体开始-->
			<div class="bg_sjfx">
				<div class="tit1"><a target="" title="" class="t_name">&gt;&gt;识别编审子系统</a><a class="t_more fr"></a></div>
				<div class="sj_icon">
					<div class="sj_icon1 ">
						<dl id="div_cgfx" lx="mklj" code="cgfx">
                            <a class="btn_blue">
                                <dt>
                                	<c:if test="${menuTmpList.AUDII_PROJECT_FIRST == 'true' || menuTmpList.AUDIT_PROJECT_SECOND == 'true' }">
				    					<img src="static/img/xmbsgl.png" id="classifyBtn" onclick="toProjectAudit();" />
				    				</c:if>
				    				<c:if test="${menuTmpList.AUDII_PROJECT_FIRST == 'false' && menuTmpList.AUDIT_PROJECT_SECOND == 'false' }">
				    					<img src="static/img/xmbsgl_1.png" id="classifyBtn" />
				    				</c:if>
                                </dt>
                                <dd>项目编审管理</dd>
                            </a>
                        </dl>
                        <dl id="div_cgfx" lx="mklj" code="cgfx">
                            <a class="btn_blue">
                                <dt>
                                	<c:if test="${menuTmpList.AUDIT_VOICE_FIRST == 'true' }">
				    					<img src="static/img/yycbs.png" id="classifyBtn" onclick="toVoiceAudit('1');" />
				    				</c:if>
				    				<c:if test="${menuTmpList.AUDIT_VOICE_FIRST == 'false' }">
				    					<img src="static/img/yycbs_1.png" id="classifyBtn" />
				    				</c:if>
                                </dt>
                                <dd>初次识别编审</dd>
                            </a>
                        </dl>
                        <dl id="div_cgfx" lx="mklj" code="cgfx">
                            <a class="btn_blue">
                                <dt>
                                	<c:if test="${menuTmpList.AUDIT_VOICE_SECOND == 'true' }">
				    					<img src="static/img/yyebs.png" id="classifyBtn" onclick="toVoiceAudit('2');" />
				    				</c:if>
				    				<c:if test="${menuTmpList.AUDIT_VOICE_SECOND == 'false' }">
				    					<img src="static/img/yyebs_1.png" id="classifyBtn" />
				    				</c:if>
                                </dt>
                                <dd>二次识别编审</dd>
                            </a>
                        </dl>
					</div>
				</div>
			</div>
		</div>
	</div>
    <script type="text/javascript">
  		//跳转至语音初审或二审
		function toVoiceAudit(flag) {
			if(flag=='1'){
				//window.location.href = "audit/fristList?front=wanLink";
				window.open('audit/fristList?front=wanLink', '_blank');
			}else if(flag=='2'){
				//window.location.href = "audit/secondList?front=wanLink";
				window.open('audit/secondList?front=wanLink', '_blank');
			}
		}
		//跳转至项目管理
		function toProjectAudit() {
			window.location.href = "toProjectHomePage?userId=${userId}";
		}
    </script>
</body>
</html>