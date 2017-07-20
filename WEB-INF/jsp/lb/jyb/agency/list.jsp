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
						<h5>未处理订单详情</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="O_NUM" name="O_NUM" value="${pd.O_NUM}" class="form-control" placeholder="订单号" />
							    <input type="text" id="UI_NAME" name="UI_NAME" value="${pd.UI_NAME}" class="form-control" placeholder="用户姓名" />
							    <input type="text" id="O_TIME" name="O_TIME" value="${pd.O_TIME }" class="bootstrapdatetimepicker form-control" placeholder="下订单时间" />
							    <%-- <select class="form-control required" name="O_STATUS"
									id="O_STATUS" value="${pd.O_STATUS}"
									onchange="">
									<option value="">--选择订单状态--</option>
									<option value="1">待就诊</option>
									<option value="2">待评价</option>
									<option value="3">已评价</option>
									<option value="4">申请退款</option>
									<option value="5">已退款</option>
								</select>&nbsp;&nbsp;
								<select class="form-control required" name="OGS_STATUS"
									id="OGS_STATUS" value="${pd.OGS_STATUS}"
									onchange="">
									<option value="">--选择接单状态--</option>
									<option value="0">未处理</option>
									<option value="1">接受订单</option>
									<option value="2">拒绝接单</option>
								</select> --%>
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="allorder();">
							       	全部
							    </button>
								<!-- <button type="button" class="btn btn-default btn-primary" onclick="toExport();">
							       	导出
							    </button> -->
								<!-- <button type="button" class="btn btn-default btn-primary" onclick="allorder();">
							       	全部订单
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
			url: 'agency/orderManagement/pageSearch?tm=' + new Date().getTime(),
			toolbar:'#toolbar' ,
			columns: [{
		        field: 'oid',
		        visible:false,
		        halign: 'center',
		    }, {
		        field: 'uiname',
		        title: '姓名',
		        align: 'left',
		        halign: 'center',
		        width:'8%',
		        formatter:function(value,row,index){
		        	var formate="<a href=\"javascript:void(0)\" style=\"text-decoration:underline;\" onclick=\"uinameDesc('"+row.uiid+"','"+row.oid+"');\">"+row.uiname+"</a>";
		        	return formate;
		        } 
		    }, {
		        field: 'onum',
		        title: '订单编号',
		        align: 'left',
		        halign: 'center',
		        width:'8%',
		        formatter:function(value,row,index){
			        	var formate="<a href=\"javascript:void(0)\" style=\"text-decoration:underline;\" onclick=\"onumDesc('"+row.oid+"','"+row.spinfoOID+"','"+row.expertlibsOID+"','"+row.accompanyinfoOID+"','"+row.keynodeOID+"','"+row.evaluateOID+"');\">"+row.onum+"</a>";
			        	return formate;
			        } 
		    }, {
		        field: 'otime',
		        title: '下单时间',
		        align: 'left',
		        width:'15%',
		        halign: 'center'
		    }, {
		        field: 'ocontent',
		        title: '注意事项',
		        align: 'left',
		        width:'50%',
		        halign: 'center'
		    },{
		        field: 'ogsstatus',
		        title: '接单状态',
		        align: 'center',
		        halign: 'center',
		        width:'8%',
		        formatter:function(value,row,index){
		        	var formate="<a href=\"javascript:void(0)\" class=\"btn btn-default btn-primary\" onclick=\"changeSpStatus('"+row.OGS_ID+"','"+row.oid+"');\">"+row.ogsstatus+"</a>";
		        	return formate;
		        }
		    }]
		};
		
		function uinameDesc(UI_ID,O_ID){
			layer.open({
			    type: 2,
			    title: '用户档案',//窗体标题
			    area: ['100%', '100%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: false,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["agency/orderManagement/toLists_uinameDesc?UI_ID=" + UI_ID+"&O_ID="+O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});
		}
		function onumDesc(O_ID,spinfoOID,expertlibsOID,accompanyinfoOID,keynodeOID,evaluateOID){
			layer.open({
			    type: 2,
			    title: '订单详情',//窗体标题
			    area: ['100%', '100%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: false,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["agency/orderManagement/toLists_onumDesc?O_ID=" + O_ID+"&spinfoOID="+spinfoOID+"&expertlibsOID="+expertlibsOID+"&accompanyinfoOID="+accompanyinfoOID+"&keynodeOID="+keynodeOID+"&evaluateOID="+evaluateOID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});
		}
		function expertLibsDesc(O_ID){
			layer.open({
			    type: 2,
			    title: '专家库信息',//窗体标题
			    area: ['30%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["agency/orderManagement/toLists_expertLibs?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});
		}
		function spDesc(O_ID){
			layer.open({
			    type: 2,
			    title: '代理商信息',//窗体标题
			    area: ['30%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["agency/orderManagement/toLists_sp?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});
		}
		function accompanyDesc(O_ID){
			layer.open({
			    type: 2,
			    title: '陪诊人员信息',//窗体标题
			    area: ['30%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["agency/orderManagement/toLists_accompany?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});
		}
		function keyNodeDesc(O_ID){
			layer.open({
			    type: 2,
			    title: '就诊过程记录',//窗体标题
			    area: ['40%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["agency/orderManagement/toLists_keyNode?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});
		}
		function orderEvalDesc(O_ID){
			layer.open({
			    type: 2,
			    title: '评价信息',//窗体标题
			    area: ['30%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["agency/orderManagement/toLists_eval?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});
		}
		
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
		//导出Excel
		function toExport(){
			$(tableId).bootstrapTable('exportTable', {
				type : 'excel'
			});
		}
		
		//显示全部订单
		function allorder(){
			window.location.href = "<%=basePath%>agency/orderManagement/toLists_all";
		}
		
		//退款
		function refund(){
			var ids = getBstCheckedId('oid');
			if((ids.length < 1)){
				layer.msg('请选中信息再进行退款。');
				return false;
			}
			var idsStr = ids.toString();
			
			$.ajax({
				type: "POST",
				url: '<%=basePath%>agency/orderManagement/prrefund?O_STATUS=4&tm=' +  new Date().getTime(),
				data: {
					IDS: idsStr
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data1) {
					if(data1.msg == 'error'){
						layer.msg('请只选择申请退款的选项！');
						return false;
					}else{
						
							layer.confirm('确定退款吗？', {
								btn: ['确认','取消'],
								shade: false,
								yes: function(index, layero){
									$.ajax({
										type: "POST",
										url: '<%=basePath%>agency/orderManagement/refund?O_STATUS=4&tm=' +  new Date().getTime(),
										data: {
											IDS: idsStr
										},
										dataType: 'json',
										//beforeSend: validateData,
										cache: false,
										success: function(data) {
											if (data.msg == 'success') {
												layer.msg('退款成功！');
												bstQuery();
											}else{
												layer.msg('退款失败！');
											}
										}
									});
								}
							});
						
					}
				}
			});			
		}
		
		//修改接单状态
		function changeSpStatus(OGS_ID,O_ID){
			layer.open({
				type: 2,
				title: '信息审核',//窗体标题
				area: ['350px', '300px'],//整个窗体宽、高，单位：像素px
				fix: false,//窗体位置不固定
				maxmin: false,//最大、小化是否显示
				scrollbar: false,//整体页面滚动条是否显示
				content: ['/active/toBackReason', 'no'],//URL地址
				closeBtn: 0,//不显示关闭按钮
				btn: ['接单', '不接单', '取消'],
				btn1: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>agency/orderManagement/changeSpStatus?tm=' +  new Date().getTime(),
						data: {
							"OGS_ID": OGS_ID,
							"ogsstatus": 1,
							"O_ID":O_ID
						},
						dataType: 'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data) {
							if (data.msg == 'success') {
								layer.msg('状态修改成功！');
								bstQuery();
							} else {
								layer.msg('状态修改失败！');
							}
						}
					});
				},btn2: function(index, layero){
					var backReason = $(layero).find("iframe")[0].contentWindow.formData();
					if(backReason != null){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>agency/orderManagement/notPass?tm=' +  new Date().getTime(),
							data: {
								"OGS_ID": OGS_ID,
								"ogsstatus":"2",
								"O_ID":O_ID,
								"backReason":backReason								
							},
							dataType: 'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data) {
								if (data.msg == 'success') {
									layer.msg('状态修改成功！');
									bstQuery();
								} else {
									layer.msg('状态修改失败！');
								}
							}
						});
					}else{
						layer.msg('未通过需填写退回原因！');
					}
				  }
			});
		}
	</script>
</body>
</html>