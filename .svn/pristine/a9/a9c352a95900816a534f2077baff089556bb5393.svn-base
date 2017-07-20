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
						<h5>重复医院专家</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
								<button type="button" class="btn btn-default btn-danger" onclick="toMerge();">
							       	对比合并
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toMergeEnd();">
							       	完成合并
							    </button>
							    <button type="button" class="btn btn-default" onclick="goBack();">
							       	返回
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
			url: 'hospExpLib/mergeViewPageSearch?HD_ID=${pd.HD_ID}&HEL_NAME=${pd.HEL_NAME}&HEL_SEX=${pd.HEL_SEX}&tm=' + new Date().getTime(),
			toolbar: '#toolbar',
			columns: [{
				field: 'CHECKBOX',
		        halign: 'center',
		        formatter: checkboxFormatter
			}, {
		        field: 'HEL_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'HEL_NAME',
		        title: '姓名',
		        align: 'center',
		        halign: 'center',
		        width: '8%',
		    }, {
		        field: 'HEL_SEX',
		        title: '性别',
		        align: 'center',
		        halign: 'center',
		        width: '5%'
		    }, {
		        field: 'HD_NAME',
		        title: '所属科室',
		        align: 'center',
		        halign: 'center',
		        width: '12%'
		    }, {
		        field: 'HE_HOSPITAL',
		        title: '所属医院',
		        align: 'left',
		        halign: 'center',
		        width: '12%'
		    }, {
		        field: 'HEL_DUTY',
		        title: '职称',
		        align: 'left',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'HE_BELONGAGENT',
		        title: '代理商',
		        align: 'left',
		        halign: 'center',
		        width: '23%'
		    }, {
		        field: 'HEL_PRICE',
		        title: '定价',
		        align: 'center',
		        halign: 'center',
		        width: '5%'
		    }, {
		        field: 'T_HE_TEMPLATE',
		        title: '模板状态',
		        align: 'center',
		        halign: 'center',
		        width: '5%'
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
		//操作
		function formatStatusFun(value, row, index){
			var btnState = " disable = false ";
			if(row.HE_TEMPLATE != 0){
				btnState = " disabled = true ";
			}
			var format_v1 = "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnState + " onclick=\"setTemplate('" + row.HEL_ID + "', '" + row.HEL_NAME + "');\">设为模板</button>";
			var format_v2 = "<button type=\"button\" class=\"btn btn-default btn-danger\" " + btnState + " onclick=\"toExpertTmp('" + row.HEL_ID + "');\">退回</button>";
			return format_v1 + "&nbsp;" + format_v2;
		}
		
		//设置专家为模板
		function setTemplate(HEL_ID, HEL_NAME){
			if(HEL_ID != null && HEL_ID != '' && HEL_NAME != null && HEL_NAME != ''){
				layer.confirm('确定将本专家设为模板吗？', {
					btn: ['确认','取消'],
					shade: false,
					yes: function(index, layero){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>hospExpLib/setTemplate?tm=' +  new Date().getTime(),
							data: {
								IDS: HEL_ID,
								HEL_NAME: HEL_NAME
							},
							dataType: 'json',
							cache: false,
							success: function(data) {
								if (data.msg == 'success') {
									layer.msg('设置专家模板成功！');
									bstQuery();
								} else {
									layer.msg('设置专家模板失败！');
								}
							}
						});
					}
				});
			}else{
				layer.msg('系统未获取数据主键，无法设置专家模板！');
			}
		}
		//对比合并
		function toMerge(){
			var ids = getBstCheckedId('HEL_ID');
			if((ids.length < 1)){
				layer.msg('请选中对比信息再进行合并。');
				return false;
			}
			if(!(ids.length == 1)){
				layer.msg('请只选中一条信息再进行合并。');
				return false;
			}
			$(tableId).bootstrapTable("getData").forEach(function(e){
				var HE_TEMPLATE = e['HE_TEMPLATE'];
				if(HE_TEMPLATE == 1){
					flag = true;
				}
			});
			if(!flag){
				layer.msg('请先设置专家模板！');
				return false;
			}else{
				var idsStr = ids.toString();
				layer.full(
					layer.open({
						type: 2,
						title: '专家对比合并',//窗体标题
						area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: false,//最大、小化是否显示
						scrollbar: true,//整体页面滚动条是否显示
						content: ['/hospExpLib/toMerge?HEL_ID=' + idsStr + '&HD_ID=${pd.HD_ID}&HEL_NAME=${pd.HEL_NAME}&HEL_SEX=${pd.HEL_SEX}', 'yes'],//URL地址
						closeBtn: 0,//显示关闭按钮
						btn: ['对比合并', '关闭'],
						btn1: function(index, layero){
							$(layero).find("iframe")[0].contentWindow.submitMergeData();
							bstQuery();
						}
					})
				);
			}
		}
		//合并结束
		function toMergeEnd(){
			var flag = false;
			var HEL_ID = '';
			var HEL_IDS = '';
			$(tableId).bootstrapTable("getData").forEach(function(e){
				var HE_TEMPLATE = e['HE_TEMPLATE'];
				
				if(HE_TEMPLATE == 1){
					flag = true;
					HEL_ID = e['HEL_ID'];
				}else{
					HEL_IDS += e['HEL_ID'] + ",";
				}
			});
			if(!flag){
				layer.msg('未完成首次合并，请先设置专家模板！');
				return false;
			}else{
				layer.confirm('确定专家已完成合并？', {
					btn: ['确认','取消'],
					shade: false,
					yes: function(index, layero){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>hospExpLib/toMergeEnd?tm=' +  new Date().getTime(),
							data: {
								IDS: HEL_ID,
								HEL_MERGE: '1',
								IDES:HEL_IDS
							},
							dataType: 'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data) {
								if (data.msg == 'success') {
									layer.msg('完成专家合并成功！');
									window.location.href = "<%=basePath%>hospExpLib/toLists";
									//bstQuery();
								} else {
									layer.msg('合并卖家专家失败！');
								}
							}
						});
					}
				});
			}
		}
		//退回到专家临时库
		function toExpertTmp(HEL_ID){
			if(HEL_ID != null && HEL_ID != ''){
				layer.confirm('确定退回已选临时专家信息吗？', {
					btn: ['确认','取消'],
					shade: false,
					yes: function(index, layero){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>hospitalExpertTmp/toSubmit?tm=' +  new Date().getTime(),
							data: {
								IDS: HEL_ID,
								HE_SUBMIT: "0"
							},
							dataType: 'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data) {
								if (data.msg == 'success') {
									layer.msg('临时专家退回成功！');
									bstQuery();
								} else {
									layer.msg('临时专家退回失败！');
								}
							}
						});
					}
				});
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//CheckBox处理方法
		function checkboxFormatter(value, row, index){
			if(row.HE_TEMPLATE == '1'){
				return {
					checked: false,
					disabled: true
				}
			}
		}
		//返回到列表页面 
		function goBack(){
			this.location.href="<%=basePath%>hospExpLib/toMergeLists";
		}
	</script>
</body>
</html>