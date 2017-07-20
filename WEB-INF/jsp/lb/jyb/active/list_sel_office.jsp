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
							    <input type="text" id="V_NAME" name="V_NAME" class="form-control" placeholder="视频名称" />
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
			url: 'video/pageSearch?A_ID=${pd.A_ID}&V_TYPE=${pd.V_TYPE}&tm=' + new Date().getTime(),
			toolbar: '#toolbar',
			columns: [{
				field: 'CHECKBOX',
		        halign: 'center',
		        formatter: checkboxFormatter
			}, {
		        field: 'OMS_RES_CODE',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'V_NAME',
		        title: '活动名称',
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
			if(row.RELATE_ID != null && row.RELATE_ID != '' && row.RELATE_ID == '${pd.A_ID}'){
				return {
					checked: true,
					disabled: false
				}
			}
		}
		//操作
		function formatStatusFun(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toPlay('" + row.V_ID + "');\">播放</button>";
			return format;
		}
		//父页面获取选取视频数据
		function formData(){
			var ids = getBstCheckedId('OMS_RES_CODE');
			return ids.toString();
		}
	</script>
</body>
</html>