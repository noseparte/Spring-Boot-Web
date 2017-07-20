 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>


<!-- jsp文件头和头部 -->
</head>
<style>
.col-sm-8{margin-top: 7px !important;}
</style>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<!-- <div class="ibox-title">
						<h5>反馈信息详情</h5>
					</div> -->
					<div class="ibox-content">
						<div id="GuideForm" name="GuideForm" class="form-horizontal" >
							<div class="form-group">
								<label class="col-sm-4 control-label">文字信息：</label>
							    <div class="col-sm-8">
							    	<input type="hidden" value="${pd.SF_ID }" name="SF_ID" id="SF_ID">
									${pd.SF_CONTENT }
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">图片信息：</label>
							    <div id="links" class="col-sm-4">
								    <c:forEach items="${pd.lists }" var="item" varStatus="status">
									    <a href="${pd.PASTHS }${item.PATH}" data-fancybox="group${item.PATH}" data-caption="">
											<img src="${pd.PASTHS }${item.PATH}" alt="" width='100px' height='100px'/>
										</a>
								    </c:forEach>
									
								</div>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 全局js -->
    <system:jsFooter/>
  
	<!-- 自定义js -->
	<script type="text/javascript">
		
		
		//表格请求及数据
		
		var SHARE_ID = $("#SHARE_ID").val();
		$(document).ready(function (){
			
		});
		$('[data-fancybox]').fancybox({
			image : {
				protect: true
			}
		});
	</script>
		
	</script>
</body>
</html>