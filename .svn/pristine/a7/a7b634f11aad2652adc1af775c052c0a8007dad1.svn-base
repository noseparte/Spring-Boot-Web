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
	                        <h5>敏感词管理
	                        <c:if test="${empty pd.SW_ID}">
	                        	<small id="pageTitle">新增</small>
	                        </c:if>
	                        <c:if test="${not empty pd.SW_ID}">
	                        	<small id="pageTitle">修改</small>
	                        </c:if>
	                        </h5>
	                        <div class="ibox-tools">
	                        </div>
	                    </div>
	                    <div class="ibox-content">
	                        <form id="filesuploadsForm" name="filesuploadsForm" 
	                        <c:if test="${empty pd.SW_ID}">
	                        	action="sensitiveWords/saveAdd"
	                        </c:if>
	                        <c:if test="${not empty pd.SW_ID}">
	                        	action="sensitiveWords/saveEdit"
	                        </c:if>action="sensitiveWords/saveEdit"   method="post" class="form-horizontal">
	                        		<input type="hidden" name="SW_ID" id="SW_ID" value="${pd.SW_ID}"/>
											<div class="form-group">
				                                <label class="col-sm-2 control-label">敏感词</label>
				                                <div class="col-sm-8">
				                                    <input type="text" class="form-control " name="SENSITIVE_WORD" id="SENSITIVE_WORD" value="${pd.SENSITIVE_WORD }">
				                                </div>
				                            </div>
	                            <div class="hr-line-dashed"></div>
	                            <div class="form-group">
	                                <div class="col-sm-4 col-sm-offset-2">
	                                    <button class="btn btn-primary" type="submit" id="submit">保存内容</button>
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
	    <script src="hplus/js/plugins/jeditable/jquery.jeditable.js"></script>
		
	    <!-- 自定义js -->
	    <script src="hplus/js/content.min.js"></script>
	    <script type="text/javascript">
	    $().ready(function(){
			$("#filesUploadsForm").validate();
		});
		function goBack(){
 			//this.location.href="<%=basePath%>filesUploads/list";
 			
 			history.go(-1);
		}
		
		//var swId=$("#SW_ID").val();
		//if(swId=="" || swId==null){
		//	$("#pageTitle").append("新增")
		//}else{
		//	$("#pageTitle").append("修改")
		//}
		
		//$("#submit").click(function(){
		//	var txt=$("#pageTitle").text()
		//	if(txt)
		//})
	</script>
		</body>
	</html>