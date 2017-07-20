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
								<select class="form-control" name="ILD_TYPE" id="ILD_TYPE" value="${pd.ILD_TYPE}">
										<option value="">--选择订单状态--</option>
										<option value="1">activity</option>
										<option value="2">action</option>
										<option value="3">广播</option>
										<option value="4">网页</option>
										<option value="5">点播</option>
								</select>
							    <input type="text" id="Title" name="Title" class="form-control" placeholder="输入组件名称或标题" />
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
			url: 'iptvModule/pageSearch?tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'IM_ID',
		        visible: false,
		        halign: 'center'
		    },  {
		        field: 'IM_NAME',
		        title: '组件名称',
		        align: 'left',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'ILD_TIITLE',
		        title: '标题',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'TYPE',
		        title: '类型',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'ILD_MODULE_PARAM',
		        title: '功能参数',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'ILD_BG_COLOR',
		        title: '背景颜色',
		        align: 'center',
		        halign: 'center',
		        width: '30%'
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
			window.location.href = "<%=basePath%>iptvModule/toAdd";
		}
		//跳转到编辑页面
		function toEdit(){
			var ids = getBstCheckedId('IM_ID');
			if(!(ids.length == 1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			window.location.href = "<%=basePath%>iptvModule/toEdit?IM_ID=" + ids[0];
		}
		//批量删除数据
		function toDel(){
			var ids = getBstCheckedId('IM_ID');
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
						url: '<%=basePath%>iptvModule/toDelete?tm=' +  new Date().getTime(),
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
		
		
	</script>
</body>
</html>