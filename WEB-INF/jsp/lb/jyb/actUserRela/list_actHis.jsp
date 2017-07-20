﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="A_NAME" name="A_NAME" class="form-control" placeholder="活动名称" />
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
							</div>
						</div>
						<table id="queryTable" data-mobile-responsive="true"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="myModal" class="modal inmodal fade" tabindex="-1" role="dialog"  aria-hidden="true"></div>
	<!-- 全局js -->
	<system:jsFooter/>
	<script type="text/javascript">
		//表格ID
		var tableId = "#queryTable";
		//表格请求及数据
		var tableColumns = {
			url: 'actUserRela/pageSearchByActHis?A_ID=${pd.A_ID}&UI_ID=${pd.UI_ID}&tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'A_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'A_NAME',
		        title: '活动名称',
		        align: 'left',
		        halign: 'center',
		        width: '30%'
		    }, {
		        field: 'T_A_TYPE',
		        title: '活动类型',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'A_START_DATE',
		        title: '开始时间',
		        align: 'center',
		        halign: 'center',
		        width: '25%'
		    }, {
		        field: 'A_END_DATE',
		        title: '结束时间',
		        align: 'center',
		        halign: 'center',
		        width: '25%'
		    }]
		};
		$(document).ready(function (){
			//初始化下拉菜单
			//$("#M_TYPE_ID").createOption();
			//初始化及查询生成表格内容
			table = $(tableId).bootstrapTable(tableColumns);
		});
		//查询刷新表格
		function searchRefreshTable(){
			//销毁表格
			$(tableId).bootstrapTable('destroy');
			$(tableId).bootstrapTable(tableColumns);
		}
		//导出Excel
		function toExport(){
			$(tableId).bootstrapTable('exportTable', {
				type : 'excel'
			});
		}
	</script>
</body>
</html>