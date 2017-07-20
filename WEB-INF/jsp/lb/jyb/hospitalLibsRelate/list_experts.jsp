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
							    <input type="text" id="HEL_NAME" name="HEL_NAME" class="form-control" placeholder="专家姓名" />
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
			url: 'hospExpLibRela/expertsPageSearch?HEL_AUDIT=4&SP_ID=${pd.SP_ID}&bingState=${pd.bingState}&tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
				field: 'CHECKBOX',
				halign: 'center',
				formatter: checkboxFormatter
			}, {
		        field: 'HEL_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'ELR_ID',
		        title: '代理商、专家对应关系表主键',
		        visible: false
		    }, {
		        field: 'HEL_NAME',
		        title: '姓名',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'HEL_SEX',
		        title: '性别',
		        align: 'center',
		        halign: 'center',
		        width: '5%'
		    }, {
		        field: 'HEL_BIRTHDAY',
		        title: '出生日期',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'HD_NAME',
		        title: '所属科室',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'HEL_DUTY',
		        title: '职务',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'HEL_GOODPRO',
		        title: '擅长专业',
		        align: 'left',
		        halign: 'center',
		        width: '35%'
		    }, {
		        field: 'HEL_PRICE',
		        title: '定价',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
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
		//返回选中绑定专家列表
		function formBingData(){
			var ids = getBstCheckedId('HEL_ID');
			if((ids.length < 1)){
				parent.layer.msg('未选中需要绑定的专家，无法进行绑定。');
				return null;
			}
			var idsStr = ids.toString();
			if(idsStr == null || idsStr == ''){
				return null;
			}
			return idsStr;
		}
		//返回选中取消绑定专家列表
		function formUnbingData(){
			var ids = getBstCheckedId('ELR_ID');
			if((ids.length < 1)){
				parent.layer.msg('未选中需要取消绑定的专家，无法进行绑定。');
				return null;
			}
			var idsStr = ids.toString();
			if(idsStr == null || idsStr == ''){
				return null;
			}
			return idsStr;
		}
		//操作
		function checkboxFormatter(value, row, index){
			if(row.HEL_FLAG == row.expertNameTmp){
				return {
					disabled: false,//设置Checkbox是否可用-true:不可用;false:可用
					checked: true  //设置Checkbox是否选中-true:选中;false:不选中
				}
			}
			return value;
		}
	</script>
</body>
</html>