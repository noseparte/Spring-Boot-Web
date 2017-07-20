 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>
<link rel="stylesheet" href="plugins/Gallery/css/blueimp-gallery.min.css">
<script src="plugins/Gallery/js/blueimp-gallery.min.js"></script>
<!-- jsp文件头和头部 -->
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
					</div>
					<div class="ibox-content">
						<form id="GuideForm" name="GuideForm" class="form-horizontal" method="post">
							<div class="form-group">
							 	<input type="hidden" value="${pd.SHARE_ID }" name="SHARE_ID" id="SHARE_ID">
								<table id="queryTable" data-mobile-responsive="true"></table>
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
		//表格ID
		var tableId = "#queryTable";
		//表格请求及数据
		var SHARE_ID = $("#SHARE_ID").val();
		var tableColumns = {
			url: 'share/selectLike?SHARE_ID=' + SHARE_ID,
			toolbar:'#toolbar',
			columns: [{
		        field: 'LIKE_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'UI_NAME',
		        title: '点赞人',
		        align: 'center',
		        halign: 'center',
		        width: '30%'
		    }, {
		        field: 'READED',
		        title: '阅读状态',
		        align: 'left',
		        halign: 'center',
		        width: '25%',
		        /* formatter: formatNameFun */
		    }, {
		        field: 'LIKE_TIME',
		        title: '点赞时间',
		        align: 'center',
		        halign: 'center',
		        width: '30%'
		    }]
		};
		$(document).ready(function (){
			table = $(tableId).bootstrapTable(tableColumns);
		});
		function searchRefreshTable(){
			//销毁表格
			$(tableId).bootstrapTable('destroy');
			$(tableId).bootstrapTable(tableColumns);
		}
		
	</script>
</body>
</html>