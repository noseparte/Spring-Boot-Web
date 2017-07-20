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
	                        <h5>文件上传 <small>新增</small></h5>
	                        <div class="ibox-tools">
	                        </div>
	                    </div>
	                    <div class="ibox-content">
	                        <form id="filesuploadsForm" name="filesuploadsForm" action="filesUploads/saveAdd"  method="post" class="form-horizontal">
	                        		<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
	                        	
											<div class="form-group">
				                                <label class="col-sm-2 control-label">文件名</label>
				                                <div class="col-sm-8">
				                                    <input type="text" class="form-control " name="FILE_NAME" id="FILENAME" value="${pd.FILENAME }">
				                                </div>
				                            </div>
											<div class="form-group">
				                                <label class="col-sm-2 control-label">basepath</label>
				                                <div class="col-sm-8">
				                                    <input type="text" class="form-control " name="BASE_PATH" id="BASEPATH" value="${pd.BASEPATH }">
				                                </div>
				                            </div>
											<div class="form-group">
				                                <label class="col-sm-2 control-label">路径</label>
				                                <div class="col-sm-8">
				                                    <input type="text" class="form-control " name="PATH" id="PATH" value="${pd.PATH }">
				                                </div>
				                            </div>
											<div class="form-group">
				                                <label class="col-sm-2 control-label">文件大小</label>
				                                <div class="col-sm-8">
				                                    <input type="text" class="form-control " name="FILE_SIZE" id="FILE_SIZE" value="${pd.FILE_SIZE }">
				                                </div>
				                            </div>
											<div class="form-group">
				                                <label class="col-sm-2 control-label">文件类型</label>
				                                <div class="col-sm-8">
				                                    <input type="text" class="form-control " name="FILE_TYPE" id="FILE_TYPE" value="${pd.FILE_TYPE }">
				                                </div>
				                            </div>
											<div class="form-group">
				                                <label class="col-sm-2 control-label">主键ID</label>
				                                <div class="col-sm-8">
				                                    <input type="text" class="form-control " name="MASTER_ID" id="MASTER_ID" value="${pd.MASTER_ID }">
				                                </div>
				                            </div>
											<div class="form-group">
				                                <label class="col-sm-2 control-label">状态（0有效 1无效）</label>
				                                <div class="col-sm-8">
				                                    <input type="text" class="form-control " name="STATUS" id="STATUS" value="${pd.STATUS }">
				                                </div>
				                            </div>
											<div class="form-group">
				                                <label class="col-sm-2 control-label">上传人ID</label>
				                                <div class="col-sm-8">
				                                    <input type="text" class="form-control " name="CREATE_ID" id="CREATE_ID" value="${pd.CREATE_ID }">
				                                </div>
				                            </div>
											<div class="form-group">
				                                <label class="col-sm-2 control-label">上传时间</label>
				                                <div class="col-sm-8">
				                                    <input type="text" class="form-control " name="CREATE_TIME" id="CREATE_TIME" value="${pd.CREATE_TIME }">
				                                </div>
				                            </div>
	                        	
	                            <div class="hr-line-dashed"></div>
	                            <div class="form-group">
	                                <div class="col-sm-4 col-sm-offset-2">
	                                    <button class="btn btn-primary" type="submit">保存内容</button>
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
			this.location.href="<%=basePath%>filesUploads/list";
		}
		
	</script>
		</body>
	</html>