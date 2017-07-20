﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- 全局css -->
<system:header />
<!-- jsp文件头和头部 -->
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>用户管理</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
								<!-- 查询条件 开始 -->
								<select class="form-control" name="M_TYPE_ID" id="M_TYPE_ID"
									value="${pd.M_TYPE_ID}"
									ajax--url="marker/getDicForSelect?param=type"
									ajax--column="ID,TEXT">
									<option value="">--标识物类型--</option>
								</select>
								<input type="text" class="form-control" name="username" id="username" />
								<!-- 查询条件 结束 -->
								<!-- 功能按钮 开始 -->
								<button type="button" class="btn btn-default btn-primary"
									onclick="searchRefreshTable();">查询</button>
								<button type="button" class="btn btn-default btn-primary"
									onclick="toAdd();">新增</button>
								<button type="button" class="btn btn-default btn-primary"
									onclick="toEdit();">修改</button>
								<button type="button" class="btn btn-default btn-danger"
									onclick="toDel();">删除</button>
								<button type="button" class="btn btn-default btn-primary"
									onclick="toExport()">导出</button>
								<!-- 功能按钮 结束 -->
							</div>
						</div>
						<!-- 表格内容 开始 -->
						<table id="queryTable" data-mobile-responsive="true"></table>
						<!-- 表格内容 结束 -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 全局js -->
	<system:jsFooter />
	<!-- 自定义js -->
	<script type="text/javascript">
		//表格ID
		var tableId = "#queryTable";
		//表格请求及数据
		var tableColumns = {
			url: 'users/pageSearchByMap?tm=' +  new Date().getTime(),
			toolbar:'#toolbar' ,
			columns: [{
				field: 'id',
				visible: false,
				halign: 'center'
			}, {
				field: 'username',
				title: '类型',
				align: 'right',
				halign: 'center'
			}, {
				field: 'realname',
				title: '名称',
				align: 'right',
				halign: 'center'
			}]
		};
		$(document).ready(function (){
			//初始化下拉菜单
			$("#M_TYPE_ID").createOption();
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
		//跳转到新增页面
		function toAdd(){
			window.location.href = "<%=basePath%>users/toAdd";
		}
		//跳转到编辑页面
		function toEdit(){
			var ids = getBstCheckedId('id');
			if(!(ids.length == 1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			window.location.href = "<%=basePath%>users/toEdit?Id=" + ids[0];
		}
		//批量删除数据
		function toDel(){
			var ids = getBstCheckedId('id');
			if((ids.length < 1)){
				layer.msg('请选中信息再进行删除。');
				return false;
			}
			var idsStr = ids.toString();
			layer.confirm('确定删除已选内容吗？', {
				btn: ['确认','取消'],
				shade: false,
				yes: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>users/toDel?tm=' + new Date().getTime(),
						data: {
							IDS : idsStr
						},
						dataType: 'json',
						cache: false,
						success: function(data) {
							if (data.msg == 'ok') {
								layer.msg('删除信息成功！');
								searchRefreshTable();
							} else {
								layer.msg('删除信息失败，请与管理员联系！');
							}
						}
					});
				}
			});
		}
	</script>
</body>
</html>