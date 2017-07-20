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
			<div class="col-sm-6">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>专家分派详情</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbarExpert" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" style="width:120px;" id="HEL_NAME" name="HEL_NAME" value="${pd.HEL_NAME}" class="form-control" placeholder="用户姓名" />
								<button type="button" class="btn btn-default btn-primary" onclick="bstQueryExpert();">
							       	查询
							    </button>
								<button type="button" class="btn btn-default btn-primary" onclick="assignExpert();">
							       	分派专家
							    </button>
							</div>
						</div>
						<table id="queryTableExpert" data-mobile-responsive="true"></table>
					</div>
				</div>
			</div>
			
			<!-- -------------------------------分割线------------------------------------ -->
			
			<div class="col-sm-6">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>陪诊人员分派详情</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbarAccompany" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" style="width:120px;" id="AI_NAME" name="AI_NAME" value="${pd.AI_NAME}" class="form-control" placeholder="用户姓名" />
								<button type="button" class="btn btn-default btn-primary" onclick="bstQueryAccompany();">
							       	查询
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="assignAccompany();">
							       	分派陪诊人员
							    </button>
							</div>
						</div>
						<table id="queryTableAccompany" data-mobile-responsive="true"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="accompanyOID" value="${pd.O_ID }"/>
	<div id="myModal" class="modal inmodal fade" tabindex="-1" role="dialog"  aria-hidden="true"></div>
	<!-- 全局js -->
	<system:jsFooter/>
	<script type="text/javascript">
		//表格ID
		var tableIdExpert = "#queryTableExpert";
		var tableIdAccompany = "#queryTableAccompany";
		//表格请求及数据--专家
		var tableColumns_expert = {
			url: 'agency/orderManagement/pageSearchAssign_expert?O_ID=${pd.O_ID }&tm=' + new Date().getTime(),
			toolbar: '#toolbarExpert',
			singleSelect: true,
			columns: [{
				field: 'CHECKBOX',
		        halign: 'center',
		        formatter: checkboxFormatter_expert
			}, {
		        field: 'helid',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'helname',
		        title: '姓名',
		        align: 'left',
		        halign: 'center'
		    }, {
		        field: 'hdname',
		        title: '科室',
		        align: 'left',
		        halign: 'center'
		    }, {
		        field: 'hehospital',
		        title: '医院',
		        align: 'left',
		        halign: 'center'
		    }]
		};
		
		//表格请求及数据--陪诊人员
		var tableColumns_accompany = {
			url: 'agency/orderManagement/pageSearchAssign_accompany?O_ID=${pd.O_ID }&tm=' + new Date().getTime(),
			toolbar:'#toolbarAccompany' ,
			singleSelect:true,
			columns: [{
				field: 'CHECKBOX',
		        halign: 'center',
		        formatter: checkboxFormatter_accompany
			}, {
		        field: 'aiid',
		        visible:false,
		        halign: 'center',
		    }, {
		        field: 'ainame',
		        title: '姓名',
		        align: 'left',
		        halign: 'center'
		    }, {
		        field: 'aisex',
		        title: '性别',
		        align: 'left',
		        halign: 'center'
		    }, {
		        field: 'aistartlevel',
		        title: '星级',
		        align: 'left',
		        halign: 'center'
		    }]
		};
		$(document).ready(function (){
			//初始化及查询生成表格内容
			table1 = $(tableIdExpert).bootstrapTable(tableColumns_expert);
			table2= $(tableIdAccompany).bootstrapTable(tableColumns_accompany);
		});
		//页面多表刷新
		function bstQueryExpert(){
			$(tableIdExpert).bootstrapTable('refresh');
		}
		//页面多表刷新
		function bstQueryAccompany(){
			$(tableIdAccompany).bootstrapTable('refresh');
		}
		//查询刷新表格
		function searchRefreshTable(){
			//销毁表格
			$(tableIdExpert).bootstrapTable('destroy');
			$(tableIdExpert).bootstrapTable(tableColumns);
			//销毁表格
			$(tableIdAccompany).bootstrapTable('destroy');
			$(tableIdAccompany).bootstrapTable(tableColumns);
		}
		//分单操作--专家
		function assignExpert(){
			//var ids = getBstCheckedId('helid');
			var ids=$(tableIdExpert).bootstrapTable('getSelections');
			if((ids.length != 1)){
				layer.msg('请选中信息再进行分派操作。');
				return false;
			}
			var idsStr = ids[0].helid;
			var accompanyOID=$("#accompanyOID").val();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>agency/orderManagement/selectExpertOrders?tm=' +  new Date().getTime(),
				data: {
					HEL_ID: idsStr,
					O_ID:accompanyOID
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if (data.msg == 'success') {
						layer.confirm('确定分派此专家吗？', {
							btn: ['确认','取消'],
							shade: false,
							yes: function(index, layero){
								$.ajax({
									type: "POST",
									url: '<%=basePath%>agency/orderManagement/assign_expertSure?tm=' +  new Date().getTime(),
									data: {
										HEL_ID: idsStr,
										O_ID:accompanyOID
									},
									dataType: 'json',
									//beforeSend: validateData,
									cache: false,
									success: function(data) {
										if (data.msg == 'success') {
											layer.msg('分派成功');
											bstQuery();
										} else {
											layer.msg('分派失败');
										}
									}
								});
							}
					});
					} else {
						layer.msg('该专家已接单，不可重新分配专家！');
					}
				}
			});
			
	}
	//分单操作--陪诊人员
	function assignAccompany(){
			var ids = getBstCheckedId('aiid');
			//var ids=$(tableIdExpert).bootstrapTable('getSelections');
			if((ids.length != 1)){
				layer.msg('请选中信息再进行分派操作。');
				return false;
			}
			var idsStr = ids.toString();
			var accompanyOID=$("#accompanyOID").val();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>agency/orderManagement/selectAccompantOrders?tm=' +  new Date().getTime(),
				data: {
					AI_ID: idsStr,
					O_ID:accompanyOID
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if (data.msg == 'success') {
						layer.confirm('确定分派此陪诊人员吗？', {
							btn: ['确认','取消'],
							shade: false,
							yes: function(index, layero){
								$.ajax({
									type: "POST",
									url: '<%=basePath%>agency/orderManagement/assign_accompanySure?tm=' +  new Date().getTime(),
									data: {
										AI_ID: idsStr,
										O_ID:accompanyOID
									},
									dataType: 'json',
									//beforeSend: validateData,
									cache: false,
									success: function(data) {
										if (data.msg == 'success') {
											layer.msg('分派成功');
											bstQuery();
										} else {
											layer.msg('分派失败');
										}
									}
								});
							}
					});
					} else {
						layer.msg('该陪诊人员已接单，不可重新分配！');
					}
				}
			});
			
	}
	//CheckBox处理方法
	function checkboxFormatter_expert(value, row, index){
		if(row.helid != null && row.HEL_ID == row.helid){
			return {
				checked: true,
				disabled: false
			}
		}
	}
	//CheckBox处理方法
	function checkboxFormatter_accompany(value, row, index){
		if(row.aiid != null && row.AI_ID == row.aiid){
			return {
				checked: true,
				disabled: false
			}
		}
	}
	</script>
</body>
</html>