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
						<h5>代理商与医院专家绑定</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="SP_NAME" name="SP_NAME" class="form-control" placeholder="代理商名称" />
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
							    <button type="button" class="btn btn-default btn-danger" onclick="toDel();">
							       	 删除
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
			url: 'hospExpLibRela/pageSearch?tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'SP_ID',
		        visible:false,
		        halign: 'center',
		    }, {
		        field: 'SP_NAME',
		        title: '代理商名称',
		        align: 'left',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'SP_PHONE',
		        title: '联系电话',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'SP_STAR_LEVEL',
		        title: '星级',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'EXPERTS',
		        title: '绑定专家',
		        align: 'left',
		        halign: 'center',
		        width: '45%'
		    }, {
		        field: 'STATUS',
		        title: '操作',
		        align: 'center',
		        halign: 'center',
		        width: '12%',
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
		//批量删除数据
		function toDel(){
			var ids = getBstCheckedId('HEL_ID');
			if((ids.length < 1)){
				layer.msg('请选中信息再进行删除。');
				return false;
			}
			var idsStr = ids.toString();
			layer.confirm('确定删除已选信息吗？', {
				btn: ['确认','取消'],
				shade: false,
				yes: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>hospExpLibRela/toDelete?tm=' +  new Date().getTime(),
						data: {
							IDS: idsStr
						},
						dataType: 'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data) {
							if (data.msg == 'success') {
								layer.msg('删除信息成功');
								bstQuery();
							} else {
								layer.msg('删除信息失败');
							}
						}
					});
				}
			});
		}
		//绑定
		function toBing(SP_ID){
			if(SP_ID != null && SP_ID != ""){
				layer.full(
					layer.open({
						type: 2,
						title: '绑定医院专家',//窗体标题
						area: ['750px', '600px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: false,//最大、小化是否显示
						scrollbar: false,//整体页面滚动条是否显示
						content: ['/hospExpLibRela/toBingLists?SP_ID=' + SP_ID, 'yes'],//URL地址
						closeBtn: 0,//显示关闭按钮
						btn: ['绑定', '关闭'],
						btn1: function(index, layero){
							var bingExperts = $(layero).find("iframe")[0].contentWindow.formBingData();
							if(bingExperts != null){
								layer.confirm('确定将已选专家绑定到代理商吗？', {
									btn: ['确认','取消'],
									shade: false,
									yes: function(index, layero){
										$.ajax({
											type: "POST",
											url: '<%=basePath%>hospExpLibRela/saveBing?tm=' +  new Date().getTime(),
											data: {
												IDS: bingExperts,
												SP_ID: SP_ID
											},
											dataType: 'json',
											//beforeSend: validateData,
											cache: false,
											success: function(data) {
												if (data.msg == 'success') {
													layer.msg('代理商与医院专家绑定成功！');
													searchRefreshTable();
												}else if(data.msg == 'error') {
													layer.msg('代理商已经绑定全部专家，无需重复绑定！');
												} else {
													layer.msg('代理商与医院专家绑定失败！');
												}
											}
										});
									}
								});
							}
						}
					})
				);
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//取消绑定
		function toCancelBing(SP_ID){
			if(SP_ID != null && SP_ID != ""){
				layer.full(
					layer.open({
						type: 2,
						title: '取消绑定医院专家',//窗体标题
						area: ['750px', '600px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: false,//最大、小化是否显示
						scrollbar: false,//整体页面滚动条是否显示
						content: ['/hospExpLibRela/toCancelBingLists?SP_ID=' + SP_ID, 'yes'],//URL地址
						closeBtn: 0,//显示关闭按钮
						btn: ['取消绑定', '关闭'],
						btn1: function(index, layero){
							var cancelBingExperts = $(layero).find("iframe")[0].contentWindow.formUnbingData();
							if(cancelBingExperts != null){
								layer.confirm('确定将已选专家取消绑定到代理商吗？', {
									btn: ['确认','取消'],
									shade: false,
									yes: function(index, layero){
										$.ajax({
											type: "POST",
											url: '<%=basePath%>hospExpLibRela/saveCancelBing?tm=' +  new Date().getTime(),
											data: {
												IDS: cancelBingExperts
											},
											dataType: 'json',
											//beforeSend: validateData,
											cache: false,
											success: function(data) {
												if (data.msg == 'success') {
													layer.msg('代理商与医院专家成功取消绑定！');
													searchRefreshTable();
												} else {
													layer.msg('代理商与医院专家取消绑定失败！');
												}
											}
										});
									}
								});
							}
						}
					})
				);
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//操作
		function formatStatusFun(value, row, index){
			var format_v1 = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toBing('"+row.SP_ID+"');\">绑定</button>";
			var format_v2 = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toCancelBing('"+row.SP_ID+"');\">解绑</button>";
			return format_v1 + "&nbsp;" + format_v2;
		}
	</script>
</body>
</html>