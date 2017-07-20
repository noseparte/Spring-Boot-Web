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
						<h5>医院专家库</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="HEL_NAME" name="HEL_NAME" class="form-control" placeholder="专家姓名" />
							    <select class="form-control" name="HD_ID" id="HD_ID" value="${pd.HD_ID}"
                                    ajax--url="hospDept/getHospDeptForSelect" ajax--column="ID,TEXT" style="width:150px;">
                                    <option value="">--所属科室--</option>
                     			</select>
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toEdit();">
							       	修改
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toMerge();">
							       	专家入库
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toCheck();">
									送审
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toSyncVideo();">
									同步视频
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toSetOrder();">
									设置排序
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
			url: 'hospExpLib/pageSearch?tm=' + new Date().getTime(),
			toolbar: '#toolbar',
			columns: [{
		        field: 'HEL_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'HEL_NAME',
		        title: '姓名',
		        align: 'center',
		        halign: 'center',
		        width: '8%',
		        formatter: formatNameFun
		    }, {
		        field: 'OMS_ID',
		        title: '关键字',
		        align: 'center',
		        halign: 'center',
		        width: '4%'
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
		        width: '8%'
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
		        width: '22%'
		    }, {
		        field: 'HEL_PRICE',
		        title: '定价',
		        align: 'center',
		        halign: 'center',
		        width: '8%'
		    }, {
		        title: '所属代理商',
		        align: 'center',
		        halign: 'center',
		        width: '8%',
		        formatter: formatFromSP
		    }, {
		        field: 'T_HEL_AUDIT',
		        title: '状态',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		        formatter: formatCheckStatusFun
		    }]
		};
		$(document).ready(function (){
			//初始化下拉菜单
			$("#HD_ID").createOption();
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
		//合并专家
		function toMerge(){
			this.location.href="<%=basePath%>hospExpLib/toMergeLists";
		}
		//送审
		function toCheck(){
			var ids = getBstCheckedId('HEL_ID');
			if((ids.length < 1)){
				layer.msg('请选中信息再进行送审。');
				return false;
			}
			var flag = true;
			$(tableId).bootstrapTable('getSelections').forEach(function(e){
				var HEL_AUDIT = e['HEL_AUDIT'];
				if(HEL_AUDIT != 0 && HEL_AUDIT != 6){
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
							url: '<%=basePath%>hospExpLib/toCheck?HEL_AUDIT=1&tm=' +  new Date().getTime(),
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
								} else if (data.msg == 'hasUser') {
									layer.msg('选中专家部分已分配帐号，无法进行审核！');
								}  else {
									layer.msg('信息送审失败！');
								}
							}
						});
					}
				});
			}
		}
		//浏览
		function toView(HEL_ID){
			if(HEL_ID != null && HEL_ID != ""){
				layer.full(
					layer.open({
						type: 2,
						title: '专家浏览',//窗体标题
						area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: false,//最大、小化是否显示
						scrollbar: true,//整体页面滚动条是否显示
						content: ['/hospExpLib/toView?HEL_ID=' + HEL_ID, 'yes'],//URL地址
						closeBtn: 1,//显示关闭按钮
						btn: ['关闭']
					})
				);
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//浏览退回原因
		function toViewBackReason(HEL_ID){
			if(HEL_ID != null && HEL_ID != ""){
				layer.open({
					type: 2,
					title: '审核退回原因',//窗体标题
					area: ['600px', '400px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: false,//最大、小化是否显示
					scrollbar: false,//整体页面滚动条是否显示
					content: ['/hospExpLib/toBackReason?HEL_ID=' + HEL_ID + "&CL_TYPE=3&CL_LEVEL=6", 'no'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				});
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//专家姓名
		function formatNameFun(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toView('" + row.HEL_ID + "');\">" + row.HEL_NAME + "</button>";
			return format;
		}
		//状态
		function formatCheckStatusFun(value, row, index){
			var format = "";
			if(row.HEL_AUDIT != 6){
				format = row.T_HEL_AUDIT;
			}else{
				format = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toViewBackReason('" + row.HEL_ID + "');\">退回状态</button>";
			}
			format += "<br /><button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toShow('" + row.HEL_ID + "', '" + Math.abs(row.HEL_SHOW - 1) + "');\">" + row.T_HEL_SHOW + "</button";
			return format;
		}
		//所属代理商
		function  formatFromSP(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toShowSP('" + row.HEL_ID + "');\">详情</button>";
			return format;
		}
		//跳转到显示sp页面
		function toShowSP(HEL_ID){
			layer.open({
				type: 2,
				title: '绑定',//窗体标题
				area: ['50%', '50%'],//整个窗体宽、高，单位：像素px
				fix: false,//窗体位置不固定
				maxmin: true,//最大、小化是否显示
				scrollbar: true,//整体页面滚动条是否显示
				content: ['/hospExpLib/to_editsp?HEL_ID=' + HEL_ID, 'yes'],//URL地址
				closeBtn: 1,//显示关闭按钮
				btn: ['关闭']
			});
		}
		//显示状态 
		function toShow(HEL_ID, HEL_SHOW){
			if(HEL_ID != null && HEL_ID != '' && HEL_SHOW != null && HEL_SHOW != ''){
				layer.confirm('确定修改已选专家显示状态吗？', {
					btn: ['确认','取消'],
					shade: false,
					yes: function(index, layero){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>hospExpLib/toShow?tm=' +  new Date().getTime(),
							data: {
								IDS: HEL_ID,
								HEL_SHOW: HEL_SHOW
							},
							dataType: 'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data) {
								if (data.msg == 'success') {
									layer.msg('专家显示状态修改成功！');
									bstQuery();
								} else {
									layer.msg('专家显示状态修改失败！');
								}
							}
						});
					}
				});
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//同步视频
		function toSyncVideo(){
			var ids = getBstCheckedId('HEL_ID');
			if((ids.length < 1)){
				layer.confirm('未选择专家信息，确认要同步所有专家视频信息吗？', {
					btn: ['确认','取消'],
					shade: false,
					yes: function(index, layero){
						toSyncVideos("");
					}
				});
			}else{
				var idsStr = ids.toString();
				layer.confirm('确认要同步已选专家视频信息吗？', {
					btn: ['确认','取消'],
					shade: false,
					yes: function(index, layero){
						toSyncVideos(idsStr);
					}
				});
			}
		}
		//跳转修啊该信息
		function toEdit(){
			var ids = getBstCheckedId('HEL_ID');
			if(!(ids.length==1)) {
				layer.msg("请只选中一条信息进行编辑");
				return false;
			}
 			else
			{
 				window.location.href ="<%=basePath%>hospExpLib/findByIdForEdit?HEL_ID="+ids;
			} 
		}
		//同步专家视频信息
		function toSyncVideos(HEL_IDS){
			var index = layer.load(1, {
				  shade: [0.6, '#DEDEDE'] //60%透明度的灰色背景
			});
			$.ajax({
				type: "POST",
				url: '<%=basePath%>video/toSyncVideo?tm=' +  new Date().getTime(),
				data: {
					IDS: HEL_IDS,
					SyncType: 'hospExpert'
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if (data.msg == 'success') {
						layer.msg('同步专家视频成功，共同步' + data.size + '条视频记录！');
					} else if (data.msg == 'failed') {
						layer.msg('未找到专家库相匹配的视频信息，共同步' + data.size + '条视频记录！');
					} else {
						layer.msg('同步专家视频失败！');
					}
					layer.close(index);
				}
			});
		}
		//设置排序
		function toSetOrder(){
			var ids = getBstCheckedId('HEL_ID');
			if(!(ids.length == 1)){
				layer.msg('请只选中一条信息再进行排序。');
				return false;
			}
			$(tableId).bootstrapTable('getSelections').forEach(function(e){
				var HEL_AUDIT = e['HEL_AUDIT'];
				if(HEL_AUDIT != 4){
					layer.msg('未通过最终审核，无法进行排序！');
				}else{
					layer.open({
						type: 2,
						title: '医院专家库排序',//窗体标题
						area: ['300px', '200px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: false,//最大、小化是否显示
						scrollbar: false,//整体页面滚动条是否显示
						content: ['/hospExpLib/toSetOrder?HEL_ID=' + ids.toString() + "&HEL_ORDER=" + e['HEL_ORDER'], 'no'],//URL地址
						closeBtn: 1,//显示关闭按钮
						btn: ['设置', '关闭'],
						btn1: function(index, layero){
							var order = $(layero).find("iframe")[0].contentWindow.formData();
							if(order != null && order != ''){
								layer.confirm('确定排序已选专家吗？', {
									btn: ['确认','取消'],
									shade: false,
									yes: function(index, layero){
										$.ajax({
											type: "POST",
											url: '<%=basePath%>hospExpLib/saveSetOrder?tm=' +  new Date().getTime(),
											data: {
												HEL_ID: ids.toString(),
												HEL_ORDER: order
											},
											dataType: 'json',
											//beforeSend: validateData,
											cache: false,
											success: function(data) {
												if (data.msg == 'success') {
													layer.msg('设置排序成功！');
													layer.close(index);
													searchRefreshTable();
												} else {
													layer.msg('设置排序失败！');
												}
											}
										});
									}
								});
							}
						}
					});
				}
			});
		}
	</script>
</body>
</html>