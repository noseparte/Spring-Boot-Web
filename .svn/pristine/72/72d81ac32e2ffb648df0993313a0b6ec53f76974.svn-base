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
					<div class="ibox-title">
						<h5>用户病历档案管理</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="UI_NAME" name="UI_NAME" class="form-control" placeholder="用户姓名" />
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
			url: 'caseHist/pageSearch?tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'CH_ID',
		        visible: false
		    }, {
		        field: 'UI_NAME',
		        title: '用户姓名',
		        align: 'center',
		        halign: 'center',
		        width: '15%',
		        formatter: formatNameFun
		    }, {
		        field: 'UI_SEX',
		        title: '性别',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'UI_BIRTHDAY',
		        title: '出生日期',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'UI_IDCARD',
		        title: '身份证号',
		        align: 'center',
		        halign: 'center',
		        width: '30%'
		    }, {
		        field: 'UI_PHONE',
		        title: '联系手机',
		        align: 'center',
		        halign: 'center',
		        width: '20%'
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
		//浏览
		function toView(UI_ID){
			if(UI_ID != null && UI_ID != ""){
				layer.full(
					layer.open({
						type: 2,
						title: '病历档案详情',//窗体标题
						area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: false,//最大、小化是否显示
						scrollbar: true,//整体页面滚动条是否显示
						content: ['/caseHist/toView?UI_ID=' + UI_ID, 'yes'],//URL地址
						closeBtn: 1,//显示关闭按钮
						btn: ['关闭']
					})
				);
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//用户姓名
		function formatNameFun(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toView('" + row.UI_ID + "');\">" + row.UI_NAME + "</button>";
			return format;
		}
	</script>
</body>
</html>