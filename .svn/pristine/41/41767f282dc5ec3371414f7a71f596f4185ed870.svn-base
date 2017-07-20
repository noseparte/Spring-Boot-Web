<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link href="static/img/css.css" type="text/css" rel="stylesheet">
<system:header/> 
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
<body class="gray-bg">
	<div id="lg_bg3">
		<div class="main1175">
			<!--主体开始-->
			<div class="bg_sjfx">
				<div class="tit1"><a target="" title="" class="t_name">&gt;&gt;识别编审子系统</a><a class="t_more fr" href="javascript:history.back(-1);">返回</a></div>
				<div class="sj_icon">
					<div class="sj_icon1 ">
						<dl id="div_cgfx" lx="mklj" code="cgfx">
                            <a class="btn_blue">
                                <dt>
                                	<c:if test="${menuTmpList.AUDII_PROJECT_FIRST == 'true' }">
				    					<img src="static/img/xmcbs.png" id="classifyBtn" onclick="toProjectAudit('1');" />
				    				</c:if>
				    				<c:if test="${menuTmpList.AUDII_PROJECT_FIRST == 'false' }">
				    					<img src="static/img/xmcbs_1.png" id="classifyBtn" />
				    				</c:if>
                                </dt>
                                <dd>项目初审管理</dd>
                            </a>
                        </dl>
                        <dl id="div_cgfx" lx="mklj" code="cgfx">
                            <a class="btn_blue">
                                <dt>
                                	<c:if test="${menuTmpList.AUDIT_PROJECT_SECOND == 'true' }">
				    					<img src="static/img/xmebs.png" id="classifyBtn" onclick="toProjectAudit('2');" />
				    				</c:if>
				    				<c:if test="${menuTmpList.AUDIT_PROJECT_SECOND == 'false' }">
				    					<img src="static/img/xmebs_1.png" id="classifyBtn" />
				    				</c:if>
                                </dt>
                                <dd>项目二审管理</dd>
                            </a>
                        </dl>
					</div>
				</div>
			</div>
		</div>
	</div>
    <script type="text/javascript">
  		//跳转至项目管理初审或二审
		function toProjectAudit(flag) {
			if(flag=='1'){
				//window.location.href = "auditmanager/fristList?front=wanLink";
				window.open('auditmanager/fristList?front=wanLink', '_blank');
			}else if(flag=='2'){
				//window.location.href = "auditmanager/secondList?front=wanLink";
				window.open('auditmanager/secondList?front=wanLink', '_blank');
			}
		}
    </script>
</body>
</html>