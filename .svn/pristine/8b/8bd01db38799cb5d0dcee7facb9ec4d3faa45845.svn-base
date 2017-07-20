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
						<h5>IPTV组件管理</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
								<select class="form-control" name="IL_STATUS" id="IL_STATUS" value="${pd.IL_STATUS}">
										<option value="">--选择状态--</option>
										<option value="1">保存</option>
										<option value="2">发布</option>
								</select>
							    <input type="text" id="IL_NAME" name="IL_NAME" class="form-control" placeholder="输入布局名称" />
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toAdd();">
							       	新增
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toEdit();">
									修改
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
			url: 'iptvLayout/pageSearch?tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'IL_ID',
		        visible: false,
		        halign: 'center'
		    },  {
		        field: 'IL_NAME',
		        title: '布局名称',
		        align: 'left',
		        halign: 'center',
		        width: '20%'
		    }, {
		        field: 'STATUS',
		        title: '状态',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'IL_TERMINAL_VERSION',
		        title: '终端版本',
		        align: 'center',
		        halign: 'center',
		        width: '20%'
		    }, {
		        field: 'IL_VERSION',
		        title: '布局版本',
		        align: 'center',
		        halign: 'center',
		        width: '20%'
		    }, {
		        field: 'IL_STATUS',
		        title: '操作',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		        formatter:function(value,row,index){
		        	var formate = "";
		        	if(row.IL_STATUS == '2'){
		        		formate="<a href=\"javascript:void(0)\" class=\"btn btn-default btn-primary\" onclick=\"editSave('"+row.IL_ID+"');\">保存</a>";
		        	}else{
		        		formate="<a href=\"javascript:void(0)\" class=\"btn btn-default btn-primary\" onclick=\"release('"+row.IL_ID+"');\">发布</a>";
		        	}
		        	return formate;
		        }
		    }]
		};
		$(document).ready(function (){
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
		//跳转到新增页面
		function toAdd(){
			window.location.href = "<%=basePath%>iptvLayout/toAdd";
		}
		//跳转到编辑页面
		function toEdit(){
			var ids = getBstCheckedId('IL_ID');
			if(!(ids.length == 1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			window.location.href = "<%=basePath%>iptvLayout/toEdit?IL_ID=" + ids[0];
		}
		//批量删除数据
		function toDel(){
			var ids = getBstCheckedId('IL_ID');
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
						url: '<%=basePath%>iptvLayout/toDelete?tm=' +  new Date().getTime(),
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
		
		//改状态为发布
		function release(IL_ID){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>iptvLayout/updateState?tm=' +  new Date().getTime(),
				data: {
					IL_ID: IL_ID,
					IL_STATUS:"2"
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if (data.msg == 'success') {
						layer.msg('修改状态成功');
						bstQuery();
					} else {
						layer.msg('修改状态失败');
					}
				}
			});
		}
		//改状态为保存
		function editSave(IL_ID){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>iptvLayout/updateState?tm=' +  new Date().getTime(),
				data: {
					IL_ID: IL_ID,
					IL_STATUS:"1"
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if (data.msg == 'success') {
						layer.msg('修改状态成功');
						bstQuery();
					} else {
						layer.msg('修改状态失败');
					}
				}
			});
		}
		
	</script>
</body>
</html>