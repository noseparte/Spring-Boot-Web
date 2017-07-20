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
						<h5>
							个人报名选取信息
							(${pd.A_NAME}&nbsp;总数：${pd.A_APPLY_NUM}&nbsp;已选：${pd.APPLE_NUM})
						</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="UI_NAME" name="UI_NAME" class="form-control" placeholder="用户姓名" />
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toSelect('1');">
							       	选取
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toSelect('0');">
							       	取消选取
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
			url: 'actUserRela/pageSearch?A_ID=${pd.A_ID}&tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'AUR_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'UI_NAME',
		        title: '用户姓名',
		        align: 'center',
		        halign: 'center',
		        width: '30%',
		        formatter: formatNameFun
		    }, {
		        field: 'T_UI_SEX',
		        title: '性别',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'UI_BIRTHDAY',
		        title: '出生日期',
		        align: 'center',
		        halign: 'center',
		        width: '20%'
		    }, {
		        field: 'T_AUR_SEL_STATE',
		        title: '状态',
		        align: 'center',
		        halign: 'center',
		        width: '20%'
		    }, {
		        field: 'STATUS',
		        title: '操作',
		        align: 'center',
		        halign: 'center',
		        width: '15%',
		        formatter: formatStatusFun
		    }]
		};
		$(document).ready(function (){
			var msg = "${pd.msg}";
			if(msg != null && msg != ""){
				if(msg == 'success'){
					layer.msg("成功维护选取个人信息！");
				}else{
					layer.msg("维护选取个人信息发生异常，请重试或与管理员联系！");
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
		//用户姓名
		function formatNameFun(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toView('" + row.UI_ID + "');\">" + row.UI_NAME + "</button>";
			return format;
		}
		//浏览
		function toView(UI_ID){
			if(UI_ID != null && UI_ID != ""){
				layer.open({
					type: 2,
					title: '信息浏览',//窗体标题
					area: ['600px', '300px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/jyb/user/toView?UI_ID=' + UI_ID, 'yes'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				});
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//选取
		function toSelect(State){
			var ids = getBstCheckedId('AUR_ID');
			if((ids.length < 1)){
				layer.msg('请选中信息再进行' + alertMsg + '。');
				return false;
			}
			var alertMsg = "";
			if(State == '0'){
				alertMsg = "取消选取";
			}else if(State == '1'){
				alertMsg = "选取";
			}
			var idsStr = ids.toString();
			layer.confirm('确定' + alertMsg + '已选信息吗？', {
				btn: ['确认','取消'],
				shade: false,
				yes: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>actUserRela/toSelect?tm=' +  new Date().getTime(),
						data: {
							IDS: idsStr,
							AUR_SEL_STATE: State
						},
						dataType: 'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data) {
							if (data.msg == 'success') {
								layer.msg(alertMsg + '信息成功');
								bstQuery();
							} else {
								layer.msg(alertMsg + '选取信息失败');
							}
						}
					});
				}
			});
		}
		//参与历史活动
		function toHistoryActive(A_ID, UI_ID){
			if(A_ID != null && A_ID != "" && UI_ID != null && UI_ID != ""){
				layer.open({
					type: 2,
					title: '参与历史活动',//窗体标题
					area: ['800px', '400px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: false,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/actUserRela/toActHisLists?A_ID=' + A_ID + '&UI_ID=' + UI_ID, 'yes'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				});
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//操作
		function formatStatusFun(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toHistoryActive('" + row.A_ID + "', '" + row.UI_ID + "');\">参与历史</button>";
			return format;
		}
	</script>
</body>
</html>