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
						<h5>科室信息</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="HD_NAME" name="HD_NAME" class="form-control" placeholder="科室名称" />
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toAdd();">
							       	添加
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toEdit();">
							       	修改
							    </button>
							    <button type="button" class="btn btn-default btn-danger" onclick="toDel();">
							       	删除
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="synchronize();">
							       	同步 
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
			url: 'hospDept/listPage?tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'HD_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'HD_NAME',
		        title: '科室名称',
		        align: 'center',
		        halign: 'center',
		        width: '45%'
		    }, {
		        field: 'OMS_ID',
		        title: 'OMS系统ID',
		        align: 'center',
		        halign: 'center',
		        width: '20%'
		    }, {
		        field: 'OMS_CODE',
		        title: 'OMS系统CODE',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    },  {
		    	title: '管理图标',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		        formatter:function(value,row,index){
					return "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toView('" + row.HD_ID + "','" + row.OMS_ID + "');\">编辑</button>";
				}
		    }]
		};
		$(document).ready(function (){
			//初始化及查询生成表格内容
			table = $(tableId).bootstrapTable(tableColumns);
		}); 
		//查询刷新表格
		function searchRefreshTable(){
			//销毁表格
			$(tableId).bootstrapTable('destroy');
			$(tableId).bootstrapTable(tableColumns);
		}
		//同步数据
		function synchronize(){
			layer.confirm('确定同步信息吗？', {
				btn: ['确认','取消'],
				shade: false,
				yes: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>hospDept/toSyncHospDept?tm=' +  new Date().getTime(),
						dataType: 'json',
						async:false,
						//beforeSend: validateData,
						cache: false,
						success: function(data) {
							bstQuery();
							layer.closeAll();
						}
					});
				}
			});
			
		}
		//导出Excel
		function toExport(){
			$(tableId).bootstrapTable('exportTable', {
				type : 'excel'
			});
		}
		//浏览
		function toView(HD_ID,OMS_ID){
			if(OMS_ID != null && OMS_ID != ""){
				layer.open({
					type: 2,
					title: '编辑图标',//窗体标题
					area: ['600px', '550px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/hospDept/toEdit?HD_ID=' + HD_ID+'&OMS_ID='+OMS_ID, 'no'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				});
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		} 
		function toAdd(){
			layer.open({
				type: 2,
				title: '编辑图标',//窗体标题
				area: ['600px', '550px'],//整个窗体宽、高，单位：像素px
				fix: false,//窗体位置不固定
				maxmin: true,//最大、小化是否显示
				scrollbar: true,//整体页面滚动条是否显示
				content: ['/hospDept/toSaveEdit', 'no'],//URL地址
				closeBtn: 1,//显示关闭按钮
				btn: ['关闭']
			});
		}
		function toEdit(){
			var ids = getBstCheckedId('HD_ID');
			if(!(ids.length == 1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			var idsStr = ids.toString();
			layer.open({
				type: 2,
				title: '编辑图标',//窗体标题
				area: ['600px', '550px'],//整个窗体宽、高，单位：像素px
				fix: false,//窗体位置不固定
				maxmin: true,//最大、小化是否显示
				scrollbar: true,//整体页面滚动条是否显示
				content: ['/hospDept/toSaveEdits?HD_ID=' + idsStr, 'no'],//URL地址
				closeBtn: 1,//显示关闭按钮
				btn: ['关闭']
			});
		}
		function toDel(){
			var ids = getBstCheckedId('HD_ID');
			if((ids.length < 1)){
				layer.msg('请选中信息信息再进行删除。');
				return false;
			}
			var idsStr = ids.toString();
			
			layer.confirm('确定删除已选信息吗？', {
				btn: ['确认','取消'],
				shade: false,
				yes: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>hospDept/deleteMany?tm=' +  new Date().getTime(),
						dataType: 'json',
						data: {
							HD_ID: idsStr
						},
						async:false,
						//beforeSend: validateData,
						cache: false,
						success: function(data) {
							if(data.msg == "success"){
								layer.msg("删除成功");
								bstQuery();
							}else{
								layer.msg("删除失败");
							}
						}
					});
				}
			});
			
		}
		//更改图片按钮
		/* function formatNameFun(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toView('" + row.HD_ID + "',"+row.OMS_ID");\">" + "编辑" + "</button>";
			return format;
		}
		 */
	</script>
</body>
</html>