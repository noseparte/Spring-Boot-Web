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
							    <input type="text" id="SHARE_COMMENT" name="SHARE_COMMENT" class="form-control" placeholder="描述" />
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
			url: 'userShare/pageSearch?ACTIVE_ID=${pd.A_ID}&SHARE_TYPE=${pd.V_TYPE}&tm=' + new Date().getTime(),
			toolbar: '#toolbar',
			columns: [{
				field: 'CHECKBOX',
		        halign: 'center',
		        formatter: checkboxFormatter
			}, {
		        field: 'SHARE_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'SHARE_COMMENT',
		        title: '信息描述',
		        align: 'left',
		        halign: 'center',
		        width: '80%'
		    }, {
		        field: 'STATUS',
		        title: '视频预览',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		        formatter: formatStatusFun
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
		//CheckBox处理方法
		function checkboxFormatter(value, row, index){
			if(row.RECOMMEND_STATE != null && row.RECOMMEND_STATE != '' && row.RECOMMEND_STATE == '1'){
				return {
					checked: true,
					disabled: false
				}
			}
		}
		//操作
		function formatStatusFun(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toPlay('" + row.SHARE_ID + "');\">播放</button>";
			return format;
		}
		//父页面获取选取视频数据
		function formData(){
			var ids = getBstCheckedId('SHARE_ID');
			return ids.toString();
		}
	</script>
</body>
</html>