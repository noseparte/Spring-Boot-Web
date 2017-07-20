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
						<h5>用户信息</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="UI_NAME" name="UI_NAME" class="form-control" placeholder="用户姓名" />
							    <input type="text" id="UI_FAMILY" name="UI_FAMILY" class="form-control" placeholder="用户家庭" />
							    <select class="form-control" name="UI_FORBID_SPEAK" id="UI_FORBID_SPEAK" value="${pd.UI_FORBID_SPEAK}">
							    	<option value="">请选择禁言状态</option>
									<option value="0" <c:if test="${pd.UI_FORBID_SPEAK == 0}">selected="selected"</c:if>>未禁言</option>
									<option value="1" <c:if test="${pd.UI_FORBID_SPEAK == 1}">selected="selected"</c:if>>禁言中</option>
								</select>
								<%-- <select class="form-control" name="UI_FREEZE_FLAG" id="UI_FREEZE_FLAG" value="${pd.UI_FREEZE_FLAG}">
							    	<option value="">请选择冻结状态</option>
									<option value="0" <c:if test="${pd.UI_FREEZE_FLAG == 0}">selected="selected"</c:if>>未冻结</option>
									<option value="1" <c:if test="${pd.UI_FREEZE_FLAG == 1}">selected="selected"</c:if>>冻结中</option>
								</select> --%>
								<select class="form-control" name="RecordState" id="RecordState" value="${pd.RecordState}">
							    	<option value="">请选择档案状态</option>
									<option value="0" <c:if test="${pd.RecordState == '未录入'}">selected="selected"</c:if>>未录入</option>
									<option value="1" <c:if test="${pd.RecordState == '已录入'}">selected="selected"</c:if>>已录入</option>
								</select>
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
							    <!-- <button type="button" class="btn btn-default btn-danger" onclick="toDel();">
							       	 删除
							    </button> -->
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
			url: 'jyb/user/pageSearch?tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'UI_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'UI_NAME',
		        title: '姓名',
		        align: 'left',
		        halign: 'center',
		        width: '12%',
		        formatter: formatNameFun
		    }, {
		        field: 'F_NAME',
		        title: '家庭',
		        align: 'left',
		        halign: 'center',
		        width: '12%',
		       
		    }, {
		        field: 'T_UI_SEX',
		        title: '性别',
		        align: 'center',
		        halign: 'center',
		        width: '6%'
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
		        width: '15%'
		    }, {
		        field: 'UI_PHONE',
		        title: '联系手机',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, 
		   {
		        field: 'T_UI_FORBID_SPEAK',
		        title: '禁言',
		        align: 'center',
		        halign: 'center',
		        width: '8%'
		    },
		    {
		        field: 'T_UI_FREEZE_FLAG',
		        title: '冻结',
		        align: 'center',
		        visible: false,
		        halign: 'center',
		        width: '6%'
		    }, {
		        field: 'RecordState',
		        title: '档案',
		        align: 'center',
		        halign: 'center',
		        width: '8%'
		    }, {
		        field: 'STATUS',
		        title: '操作',
		        align: 'center',
		        halign: 'center',
		        width: '20%',
		        formatter: formatStatusFun
		    }]
		};
		$(document).ready(function (){
			var msg = "${pd.msg}";
			if(msg != null && msg != ""){
				if(msg == 'success'){
					layer.msg("成功维护用户信息！");
				}else{
					layer.msg("维护用户信息发生异常，请重试或与管理员联系！");
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
		//批量删除数据
		function toDel(){
			var ids = getBstCheckedId('UI_ID');
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
						url: '<%=basePath%>jyb/user/toDelete?tm=' +  new Date().getTime(),
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
		//冻结
		function toFreeze(UI_ID, UI_FREEZE_FLAG){
			if(UI_ID != null && UI_ID != "" && UI_FREEZE_FLAG != null && UI_FREEZE_FLAG != ""){
				var alertMsg = "";
				var freezeFlag = "";
				if(UI_FREEZE_FLAG == '1'){
					alertMsg = "取消冻结";
					freezeFlag = "0";
				}else if(UI_FREEZE_FLAG == '0'){
					alertMsg = "冻结";
					freezeFlag = "1";
				}
				layer.confirm('确定' + alertMsg + '已选信息吗？', {
					btn: ['确认','取消'],
					shade: false,
					yes: function(index, layero){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>jyb/user/toFreeze?tm=' +  new Date().getTime(),
							data: {
								UI_ID: UI_ID,
								UI_FREEZE_FLAG: freezeFlag
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
		//禁言
		function toForbidSpeak(UI_ID, UI_FORBID_SPEAK, SYS_UI_ID){
			if(UI_ID != null && UI_ID != "" && UI_FORBID_SPEAK != null && UI_FORBID_SPEAK != "" && SYS_UI_ID != null && SYS_UI_ID != ""){
				var alertMsg = "";
				var forbidSpeakFlag = "";
				if(UI_FORBID_SPEAK == '1'){
					alertMsg = "取消禁言";
					forbidSpeakFlag = "0";
				}else if(UI_FORBID_SPEAK == '0'){
					alertMsg = "禁言";
					forbidSpeakFlag = "1";
				}
				layer.open({
					type: 2,
					title: '用户禁言',//窗体标题
					area: ['500px', '280px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: false,//最大、小化是否显示
					scrollbar: false,//整体页面滚动条是否显示
					content: ['/jyb/user/toForbidSpeakReason?SYS_UI_ID=' + SYS_UI_ID, 'no'],//URL地址
					closeBtn: 0,//不显示关闭按钮
					btn: [alertMsg, '取消'],
					btn1: function(index, layero){
						var days = $(layero).find("iframe")[0].contentWindow.formData();
						if(forbidSpeakFlag == 0){
							days = 10000;
						}
						if(days != null && days != ''){
							layer.confirm('确定' + alertMsg + '已选信息吗？', {
								btn: ['确认','取消'],
								shade: false,
								yes: function(index, layero){
									$.ajax({
										type: "POST",
										url: '<%=basePath%>jyb/user/toForbidSpeak?tm=' +  new Date().getTime(),
										data: {
											UI_ID: UI_ID,
											SYS_UI_ID: SYS_UI_ID,
											FS_DAYS: days,
											UI_FORBID_SPEAK: forbidSpeakFlag
										},
										dataType: 'json',
										//beforeSend: validateData,
										cache: false,
										success: function(data) {
											if (data.msg == 'success') {
												layer.msg(alertMsg + '信息成功！');
												layer.close(index);
												searchRefreshTable();
											} else {
												layer.msg(alertMsg + '信息失败！');
											}
										}
									});
								}
							});
						}
					}
				});
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//浏览
		function toView(UI_ID){
			if(UI_ID != null && UI_ID != ""){
				layer.full(
					layer.open({
						type: 2,
						title: '信息浏览',//窗体标题
						area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: true,//最大、小化是否显示
						scrollbar: true,//整体页面滚动条是否显示
						content: ['/jyb/user/toView?UI_ID=' + UI_ID, 'no'],//URL地址
						closeBtn: 1,//显示关闭按钮
						btn: ['关闭']
					})
				);
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//档案
		function toRecord(UI_ID){
			if(UI_ID != null && UI_ID != ""){
				layer.full(
					layer.open({
						type: 2,
						title: '查看用户档案信息',//窗体标题
						area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: true,//最大、小化是否显示
						scrollbar: true,//整体页面滚动条是否显示
						content: ['/caseHist/toView?UI_ID=' + UI_ID, 'yes'],//URL地址
						closeBtn: 1,//显示关闭按钮
						btn: ['关闭'],
						btn1: function(index, layero){
							searchRefreshTable();
						}
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
		//操作
		function formatStatusFun(value, row, index){
			var freeze = "";
			var forbidSpeak = "";
			if(row.UI_FORBID_SPEAK == '1'){
				forbidSpeak = "取消";
			}else if(row.UI_FORBID_SPEAK == '0'){
				forbidSpeak = "";
			}
			if(row.UI_FREEZE_FLAG == '1'){
				freeze = "取消";
			}else if(row.UI_FREEZE_FLAG == '0'){
				freeze = "";
			}
			var format_v1 = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toRecord('" + row.UI_ID + "');\">档案</button>";
			var format_v2 = "";//"<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toFreeze('" + row.UI_ID + "', '" + row.UI_FREEZE_FLAG + "');\">" + freeze + "冻结</button>";
			var format_v3 = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toForbidSpeak('" + row.UI_ID + "', '" + row.UI_FORBID_SPEAK + "', '" + row.SYS_UI_ID +"');\">" + forbidSpeak + "禁言</button>";
			return format_v1 + "&nbsp;" + format_v2 + "&nbsp;" + format_v3;
		}
	</script>
</body>
</html>