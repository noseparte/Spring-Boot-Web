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
					<div class="ibox-title">
						<h5>朋友圈信息详情</h5>
					</div>
					<div class="ibox-content">
						<form id="GuideForm" name="GuideForm" class="form-horizontal" method="post">
							<div class="form-group">
								<label class="col-sm-4 control-label">文字信息：</label>
							    <div class="col-sm-8">
							    	<input type="hidden" value="${pd.SHARE_ID }" name="SHARE_ID" id="SHARE_ID">
									${pd.SHARE_COMMENT }
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">图片信息：</label>
							    <div id="links" class="col-sm-4">
								    <c:forEach items="${pd.lists }" var="pd" varStatus="status">
									    <a href="<%=basePath %>${pd.PIC_URL}" data-fancybox="group${item.PATH}" data-caption="">
											 <img src="<%=basePath %>${pd.PIC_URL}" width='100px' height='100px' />
										</a>
								    </c:forEach>
								</div>
							</div>
							<!-- <div class="form-group">
								<table id="queryTable" data-mobile-responsive="true"></table>
							</div> -->
							<div class="form-group" >
								<div class="col-sm-11" align="center">
									<button type="button" class="btn btn-default btn-primary" onclick="like();">
							       		点赞信息
							    	</button>
							    	<button type="button" class="btn btn-default btn-primary" onclick="comment();">
								       	评论信息
								    </button>
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
	<!-- 自定义js -->
	<script type="text/javascript">
		
	$('[data-fancybox]').fancybox({
		image : {
			protect: true
		}
	});
		
		//表格请求及数据
		var SHARE_ID = $("#SHARE_ID").val();
		$(document).ready(function (){
			
		});
		
		function like(){
			if(SHARE_ID != null && SHARE_ID != ""){
				layer.open({
					type: 2,
					title: '点赞信息',//窗体标题
					area: ['80%', '80%'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/share/toLike?SHARE_ID=' + SHARE_ID, 'no'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				});
			}else{
				layer.msg("系统获取信息失败，请重新操作！");
			}
		}
		function comment(){
			if(SHARE_ID != null && SHARE_ID != ""){
				layer.open({
					type: 2,
					title: '评论信息',//窗体标题
					area: ['80%', '80%'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/share/toComment?SHARE_ID=' + SHARE_ID, 'no'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				});
			}else{
				layer.msg("系统获取信息失败，请重新操作！");
			}
		}
		
	</script>
</body>
</html>