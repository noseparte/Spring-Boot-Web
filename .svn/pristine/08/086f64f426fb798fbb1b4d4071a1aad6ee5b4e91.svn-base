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
						<h5>运营人员订单管理</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="O_NUM" name="O_NUM" value="${pd.O_NUM}" class="form-control" placeholder="订单号" />
							    <%-- <input type="text" id="O_TIME" name="O_TIME" value="${pd.O_TIME }" class="bootstrapdatetimepicker form-control" placeholder="下订单时间" /> --%>
							    <input type="text" id="BEGIN_TIME" name="BEGIN_TIME" value="${pd.BEGIN_TIME }" class="bootstrapdatetimepicker form-control" placeholder="开始时间" />
							    <input type="text" id="END_TIME" name="END_TIME" value="${pd.END_TIME }" class="bootstrapdatetimepicker form-control" placeholder="结束时间" />
							    <input type="text" id="REMIT_ID" name="REMIT_ID" value="${pd.REMIT_ID }" class="form-control" placeholder="汇付识别码" />
							    <select class="form-control" name="O_STATUS" id="O_STATUS" value="${pd.O_STATUS}">
									<option value="">--选择订单状态--</option>
									<option value="0">待付款</option>
									<option value="1">待就诊</option>
									<option value="2">待评价</option>
									<option value="3">已评价</option>
									<option value="4">申请退款</option>
									<option value="5">已退款</option>
									<option value="6">已付款</option>
									<option value="7">未付款取消订单</option>
									<option value="8">申请完结</option>
								</select>
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
								<!-- <button type="button" class="btn btn-default btn-primary" onclick="toExport();">
							       	导出
							    </button> -->
							</div>
						</div>
						<font color="red" size="2">注：如果代理商.专家.陪诊拒单，则拒单的代理商.专家.陪诊名称为红色，点击可查看拒单理由</font>
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
			url: 'operator/orderManagement/pageSearch?tm=' + new Date().getTime(),
			toolbar:'#toolbar' ,
			columns: [{
		        field: 'oid',
		        visible:false,
		        halign: 'center',
		    }, {
		        field: 'uiname',
		        title: '姓名',
		        align: 'center',
		        halign: 'center',
		        width: '5%',
		        formatter:function(value,row,index){
		        	return "<button type=\"button\" class=\"btn btn-link\" onclick=\"uinameDesc('" + row.uiid + "','" + row.oid + "');\">" + row.uiname + "</button>";
		        } 
		    }, {
		        field: 'onum',
		        title: '订单编号',
		        align: 'center',
		        halign: 'center',
		        width: '8%',
		        formatter:function(value,row,index){
		        	return "<button type=\"button\" class=\"btn btn-link\" onclick=\"onumDesc('" + row.oid + "','" + row.spinfoOID + "','" + row.expertlibsOID + "','" + row.accompanyinfoOID + "','" + row.keynodeOID + "','" + row.evaluateOID + "');\">" + row.onum + "</button>";
		        } 
		    }, {
		        field: 'otime',
		        title: '下单时间',
		        align: 'center',
		        halign: 'center',
		        width: '13%'
		    }, {
		        field: 'REMIT_ID',
		        title: '汇付识别码',
		        align: 'center',
		        halign: 'center',
		        width: '8%'
		    },{
		        field: 'otype',
		        title: '订单类型',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		        visible: false
		    }, {
		        field: 'ostatus',
		        title: '订单状态',
		        align: 'center',
		        halign: 'center',
		        width: '8%',
		        formatter:function(value,row,index){
		        	var btnState = " disable = false ";
					if(row.ostatus_code != 0){
						btnState = " disabled = true ";
					}
		        	return "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnState + " onclick=\"changeOrderStatus('"+row.oid+"','"+row.ostatus_code+"');\">"+row.ostatus+"</button>";
		        } 
		    }, {
		        field: 'payway',
		        title: '支付方式',
		        align: 'center',
		        halign: 'center',
		        visible: false
		    }, {
		        field: 'paymoney',
		        title: '支付金额',
		        align: 'center',
		        halign: 'center',
		        visible: false
		    }, {
		        field: 'HEL_NAME',
		        title: '专家',
		        align: 'center',
		        halign: 'center',
		        width: '5%',
		        formatter:function(value,row,index){
		        	if(row.HEL_NAME != null && row.HEL_NAME != '' ){
		        		if(row.OS_STATUS == '2'){
		        			return "<button type=\"button\" class=\"btn btn-link\" onclick=\"expertLibsDesc('" + row.expertlibsOID + "');\"><font color = \"red\">" + row.HEL_NAME + "</font></button>";
		        		}else{
		        			return "<button type=\"button\" class=\"btn btn-link\" onclick=\"expertLibsDesc('" + row.expertlibsOID + "');\">" + row.HEL_NAME + "</button>";
		        		}
		        	}else{
		        		return "-";
		        	}
		        	
		        } 
		    }, {
		        field: 'AI_NAME',
		        title: '陪诊',
		        align: 'center',
		        halign: 'center',
		        width: '5%',
		        formatter:function(value,row,index){
		        	if(row.AI_NAME != null && row.AI_NAME != ''){
		        		if(row.OSHA_STATUS == '2'){
		        			return "<button type=\"button\" class=\"btn btn-link\" onclick=\"accompanyDesc('" + row.accompanyinfoOID + "');\"><font color = \"red\">" + row.AI_NAME + "</font></button>";
		        		}else{
		        			return "<button type=\"button\" class=\"btn btn-link\" onclick=\"accompanyDesc('" + row.accompanyinfoOID + "');\">" + row.AI_NAME + "</button>";
		        		}
		        	}else{
		        		return "-";
		        	}
		        } 
		    }, {
		        field: 'SP_NAME',
		        title: '代理商',
		        align: 'center',
		        halign: 'center',
		        width: '32px',
		        formatter:function(value,row,index){
		        	if(row.SP_NAME != null && row.SP_NAME != ''){
		        		if(row.ogsstatus == '2'){
		        			return "<button type=\"button\" class=\"btn btn-link\" onclick=\"spDesc('" + row.spinfoOID + "','"+row.oid+"');\"><font color = \"red\">" + row.SP_NAME + "</font></button>";
		        		}else{
		        			return "<button type=\"button\" class=\"btn btn-link\" onclick=\"spDesc('" + row.spinfoOID + "','"+row.oid+"');\">" + row.SP_NAME + "</button>";
		        		}
		        	}else{
		        		return "-";
		        	}
		        	
		        } 
		    }, {
		        field: 'STATUS',
		        title: '相关信息',
		        align: 'center',
		        halign: 'center',
		        width: '20%',
		        formatter: formatStatusFun
		    }]
		};
		//浏览用户档案信息
		function uinameDesc(UI_ID,O_ID){
			layer.open({
			    type: 2,
			    title: '用户档案',//窗体标题
			    area: ['100%', '100%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: false,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["operator/orderManagement/toLists_uinameDesc?UI_ID=" + UI_ID + "&O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1, //不显示关闭按钮
			    btn: ['关闭']
			});
		}
		//浏览订单详情
		function onumDesc(O_ID,spinfoOID,expertlibsOID,accompanyinfoOID,keynodeOID,evaluateOID){
			layer.open({
			    type: 2,
			    title: '订单详情',//窗体标题
			    area: ['100%', '100%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: false,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["operator/orderManagement/toLists_onumDesc?O_ID=" + O_ID + "&spinfoOID=" + spinfoOID + "&expertlibsOID=" + expertlibsOID + "&accompanyinfoOID=" + accompanyinfoOID + "&keynodeOID=" + keynodeOID + "&evaluateOID=" + evaluateOID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1, //不显示关闭按钮
			    btn: ['关闭']
			});
		}
		//浏览专家
		function expertLibsDesc(expertlibsOID){
			if(expertlibsOID != null && expertlibsOID != ""){
				layer.full(
					layer.open({
						type: 2,
						title: '专家浏览',//窗体标题
						area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: false,//最大、小化是否显示
						scrollbar: true,//整体页面滚动条是否显示
						content: ['/hospExpLib/toView?HEL_ID=' + expertlibsOID, 'yes'],//URL地址
						closeBtn: 1,//显示关闭按钮
						btn: ['关闭']
					})
				);
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
			/*layer.open({
			    type: 2,
			    title: '专家库信息',//窗体标题
			    area: ['30%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["operator/orderManagement/toLists_expertLibs?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});*/
		}
		//浏览代理商
		function spDesc(spinfoOID){
			if(spinfoOID != null && spinfoOID != ""){
				layer.full(layer.open({
					type: 2,
					title: '代理商浏览',//窗体标题
					area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/agent/toView?SP_ID=' + spinfoOID, 'yes'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				}));
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
			/*layer.open({
			    type: 2,
			    title: '代理商信息',//窗体标题
			    area: ['30%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["operator/orderManagement/toLists_sp?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});*/
		}
		//浏览陪诊人员
		function accompanyDesc(accompanyinfoOID){
			if(accompanyinfoOID != null && accompanyinfoOID != ""){
				layer.full(layer.open({
					type: 2,
					title: '陪诊浏览',//窗体标题
					area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/accompanyInfo/toView?AI_ID=' + accompanyinfoOID, 'yes'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				}));
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
			/*layer.open({
			    type: 2,
			    title: '陪诊人员信息',//窗体标题
			    area: ['30%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["operator/orderManagement/toLists_accompany?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});*/
		}
		//浏览就诊信息
		function keyNodeDesc(O_ID){
			layer.open({
			    type: 2,
			    title: '就诊过程记录',//窗体标题
			    area: ['80%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["operator/orderManagement/toLists_keyNode?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1, //不显示关闭按钮
			    btn: ['关闭']
			});
		}
		//浏览评价信息
		function orderEvalDesc(evaluateOID){
			if(evaluateOID != null && evaluateOID != ""){
				layer.open({
					type: 2,
					title: '订单评价详情',//窗体标题
					area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: false,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/evaluate/toView?EVA_ID=' + evaluateOID, 'yes'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				});
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
			/*layer.open({
			    type: 2,
			    title: '评价信息',//窗体标题
			    area: ['30%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["operator/orderManagement/toLists_eval?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});*/
		}
		//修改订单状态
		function changeOrderStatus(O_ID,O_STATUS){
			layer.confirm('确定修改订单的状态为付款吗？修改之后无法再修改！！', {
				btn: ['确认','取消'],
				shade: false,
				yes: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>operator/orderManagement/changeOrderStatus?tm=' +  new Date().getTime(),
						data: {
							oid: O_ID,
							ostatus:O_STATUS
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
				}
			});
		}
		//操作
		function formatStatusFun(value, row, index){
        	btnState = " disable = false ";
			if(row.keynodeOID == null || row.keynodeOID == ''){
				btnState = " disabled = true ";
			}
        	var format_v4 = "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnState + " onclick=\"keyNodeDesc('" + row.oid + "');\">就诊</button>";
        	btnState = " disable = false ";
			if(row.evaluateOID == null || row.evaluateOID == ''){
				btnState = " disabled = true ";
			}
        	var format_v5 = "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnState + " onclick=\"orderEvalDesc('" + row.evaluateOID + "');\">评价</button>";
        	return  format_v4 + "&nbsp;" + format_v5; 
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
	</script>
</body>
</html>