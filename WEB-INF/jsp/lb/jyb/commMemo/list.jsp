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
							</div>
						</div>
						<table id="queryTable" data-mobile-responsive="false"></table>
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
			url: 'commMemo/pageSearch?UI_ID=${pd.UI_ID}&tm=' + new Date().getTime(),//&TITLE_ID=${pd.TITLE_ID}
			toolbar:'#toolbar',
			showCheckbox: false,
			showSeqColumn: false,
			cardView: false,
			detailView: true,
			detailFormatter: detaiFormatMemoFun,
			columns: [{
		        field: 'CH_ID',
		        visible: false
		    }, {
		        field: 'UI_ID',
		        visible: false
		    }, {
		        field: 'TITLE_ID',
		        visible: false
		    }, {
		        field: 'CHANGE_TIME',
		        title: '维护日期',
		        align: 'center',
		        halign: 'center',
		        width: '30%'
		    }, {
		        field: 'CH_MEMO',
		        title: '摘要',
		        align: 'left',
		        halign: 'center',
		        width: '62%',
		        formatter: formatMemoFun
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
		//摘要
		function formatMemoFun(value, row, index){
			var format;
			if(row.CH_MEMO.length <= 20){
				format = row.CH_MEMO;
			}else{
				format = row.CH_MEMO.substring(0, 20) + "…";
			}
			return format;
		}
		//摘要详情
		function detaiFormatMemoFun(index, row){
			return "<span style='word-break: break-all;'>" + row.CH_MEMO + "</span>";
		}
	</script>
</body>
</html>