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
						<h5>健康教育</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="ARTICLE_TITLE" name="ARTICLE_TITLE" class="form-control" placeholder="标题" />
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
							    <button type="button" class="btn btn-default btn-primary" onclick="toCheck();">
									送审
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
			url: 'articleHealth/pageSearch?tm=' + new Date().getTime(),
			toolbar: '#toolbar',
			columns: [{
		        field: 'ARTICLE_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'ARTICLE_TITLE',
		        title: '标题',
		        align: 'left',
		        halign: 'center',
		        width: '45%',
		        formatter: formatNameFun
		    }, {
		        field: 'ARTICLE_TYPE',
		        title: '类型',
		        align: 'center',
		        halign: 'center',
		        width: '8%'
		    }, {
		        field: 'PUBLISH_NAME',
		        title: '发表人',
		        align: 'left',
		        halign: 'center',
		        width: '8%'
		    }, {
		        field: 'PUBLISH_DEPT',
		        title: '发表单位',
		        align: 'left',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'T_CHECK_STATE',
		        title: '状态',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		        formatter: formatCheckStatusFun
		    }, {
		        field: 'STATUS',
		        title: '操作',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		        formatter: formatStatusFun
		    }]
		};
		$(document).ready(function (){
			var msg = "${pd.msg}";
			if(msg != null && msg != ""){
				if(msg == 'success'){
					layer.msg("成功维护健康教育信息！");
				}else{
					layer.msg("维护健康教育信息发生异常，请重试或与管理员联系！");
				}
			}
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
		//跳转到新增页面
		function toAdd(){
			window.location.href = "<%=basePath%>articleHealth/toAdd";
		}
		//跳转到编辑页面
		function toEdit(){
			var ids = getBstCheckedId('ARTICLE_ID');
			if(!(ids.length == 1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			window.location.href = "<%=basePath%>articleHealth/toEdit?ARTICLE_ID=" + ids[0];
		}
		//批量删除数据
		function toDel(){
			var ids = getBstCheckedId('ARTICLE_ID');
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
						url: '<%=basePath%>articleHealth/toDelete?tm=' +  new Date().getTime(),
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
		//送审
		function toCheck(){
			var ids = getBstCheckedId('ARTICLE_ID');
			if((ids.length < 1)){
				layer.msg('请选中信息再进行送审。');
				return false;
			}
			var flag = true;
			$(tableId).bootstrapTable('getSelections').forEach(function(e){
				var CHECK_STATE = e['CHECK_STATE'];
				if(CHECK_STATE != 0 && CHECK_STATE != 6){
					flag = false;
				}
			});
			if(!flag){
				layer.msg('选取信息包括正在进行审核或已审核通过信息，请重新选取！');
				return false;
			}else{
				var idsStr = ids.toString();
				layer.confirm('确定送审已选信息吗？', {
					btn: ['确认','取消'],
					shade: false,
					yes: function(index, layero){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>articleHealth/toCheck?CHECK_STATE=1&tm=' +  new Date().getTime(),
							data: {
								IDS: idsStr
							},
							dataType: 'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data) {
								if (data.msg == 'success') {
									layer.msg('信息送审成功！');
									bstQuery();
								} else {
									layer.msg('信息送审失败！');
								}
							}
						});
					}
				});
			}
		}
		//浏览
		function toView(ARTICLE_ID){
			if(ARTICLE_ID != null && ARTICLE_ID != ""){
				layer.full(layer.open({
					type: 2,
					title: '信息浏览',//窗体标题
					area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/articleHealth/toView?ARTICLE_ID=' + ARTICLE_ID, 'yes'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				}));
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//浏览退回原因
		function toViewBackReason(ARTICLE_ID){
			if(ARTICLE_ID != null && ARTICLE_ID != ""){
				layer.open({
					type: 2,
					title: '审核退回原因',//窗体标题
					area: ['600px', '400px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: false,//最大、小化是否显示
					scrollbar: false,//整体页面滚动条是否显示
					content: ['/articleHealth/toBackReason?ARTICLE_ID=' + ARTICLE_ID + "&CL_TYPE=1&CL_LEVEL=6", 'no'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				});
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//发布、取消发布
		function toPublish(ARTICLE_ID, PUBLISH_STATE){
			if(ARTICLE_ID != null && ARTICLE_ID != "" && PUBLISH_STATE != null && PUBLISH_STATE != ""){
				var alertMsg = "";
				var publishFlag = "";
				if(PUBLISH_STATE == '1'){
					alertMsg = "取消发布";
					publishFlag = "0";
				}else if(PUBLISH_STATE == '0'){
					alertMsg = "发布";
					publishFlag = "1";
				}
				layer.confirm('确定' + alertMsg + '已选信息吗？', {
					btn: ['确认','取消'],
					shade: false,
					yes: function(index, layero){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>articleHealth/toPublish?tm=' +  new Date().getTime(),
							data: {
								ARTICLE_ID: ARTICLE_ID,
								PUBLISH_STATE: publishFlag
							},
							dataType: 'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data) {
								if (data.msg == 'success') {
									layer.msg(alertMsg + '信息成功！');
									bstQuery();
								} else {
									layer.msg(alertMsg + '信息失败！');
								}
							}
						});
					}
				});
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//健康教育
		function formatNameFun(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toView('" + row.ARTICLE_ID + "');\">" + row.ARTICLE_TITLE + "</button>";
			return format;
		}
		//状态
		function formatCheckStatusFun(value, row, index){
			var format = "";
			if(row.CHECK_STATE != 6){
				format = row.T_CHECK_STATE;
			}else{
				format = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toViewBackReason('" + row.ARTICLE_ID + "');\">退回状态</button>";
			}
			return format;
		}
		//操作
		function formatStatusFun(value, row, index){
			//发布按钮操作状态
			var btnPublishState = "  ";
			if(row.CHECK_STATE == '4'){
				btnPublishState = "  ";
			}else{
				btnPublishState = " disabled = 'disabled' ";
			}
			//发布按钮文字
			var textPublishState = "";
			if(row.PUBLISH_STATE == '0'){
				textPublishState = "发布";
			}else if(row.PUBLISH_STATE == '1'){
				textPublishState = "取消发布";
			}
			var format = "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnPublishState + " onclick=\"toPublish('"+row.ARTICLE_ID+"', '" + row.PUBLISH_STATE + "');\">" + textPublishState + "</button>";
			return format;
		}
	</script>
</body>
</html>