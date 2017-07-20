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
					<div class="ibox-content">
						<form id="ArticleHealthForm" name="ArticleHealthForm" class="form-horizontal" method="post">
							<div class="form-group">
								<label class="col-sm-1 control-label">姓名：</label>
							    <div class="col-sm-2">
									${data.rows[0].uiname}
								</div>
								<label class="col-sm-1 control-label">性别：</label>
							    <div class="col-sm-1">
									${data.rows[0].uisex}
								</div>
								<label class="col-sm-2 control-label">出生日期：</label>
							    <div class="col-sm-2">
									${data.rows[0].uibirthday}
								</div>
								<label class="col-sm-1 control-label">手机：</label>
							    <div class="col-sm-2">
									${data.rows[0].phone}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">地址：</label>
							    <div class="col-sm-11">
									${data.rows[0].address}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">病情描述</label>
								<label class="col-sm-4 control-label">就医历史</label>
								<label class="col-sm-4 control-label">过敏史</label>
							</div>
							<div class="form-group">
							    <div class="col-sm-4" style="word-break:break-all;">
									${data.rows[0].illdesc} 
								</div>
							    <div class="col-sm-4" style="word-break:break-all;">
									${data.rows[0].mediahis} 
								</div>
							    <div class="col-sm-4" style="word-break:break-all;">
									${data.rows[0].allergy} 
								</div>
							</div>
						</form>
						
						<div class="ibox-title">
							<h5>沟通备忘录</h5>
						</div>
						<table id="queryTableMEMO" data-mobile-responsive="true"></table>
						
						<div class="ibox-title">
							<h5>订单详情</h5>
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
		url: 'hospitalGuide/pageSearch_historyorder?UI_ID=${pd.UI_ID}&tm=' + new Date().getTime(),
		toolbar:'#toolbar' ,
		showCheckbox:false,
		columns: [{
	        field: 'oid',
	        visible:false,
	        halign: 'center',
	    }, {
	        field: 'onum',
	        title: '订单编号',
	        align: 'center',
	        halign: 'center'
	    }, {
	        field: 'otime',
	        title: '下单时间',
	        align: 'center',
	        halign: 'center'
	    }, {
	        field: 'otype',
	        title: '订单类型',
	        align: 'center',
	        halign: 'center'
	    }, {
	        field: 'ostatus',
	        title: '订单状态',
	        align: 'center',
	        halign: 'center'
	    }, {
	        field: 'STATUS',
	        title: '相关信息',
	        align: 'center',
	        halign: 'center',
	        formatter: formatStatusFun
	    }]
	};
	//用户沟通备忘录
	var tableColumnsMEMO = {
		url: 'hospitalGuide/pageSearch_MEMO?UI_ID=${pd.UI_ID}&tm=' + new Date().getTime(),
		toolbar:'#toolbar' ,
		showCheckbox:false,
		columns: [{
	        field: 'uiid',
	        visible:false,
	        halign: 'center',
	    }, {
	        field: 'uiname',
	        title: '姓名',
	        align: 'center',
	        width:'10%',
	        halign: 'center'
	    }, {
	        field: 'chmemo',
	        title: '沟通备忘录',
	        align: 'left',
	        width: '80%',
	        halign: 'center'
	    }]
	};
	
	function expertLibsDesc(O_ID){
		layer.open({
		    type: 2,
		    title: '专家库信息',//窗体标题
		    area: ['30%', '80%'],//整个窗体宽、高，单位：像素px
		    fix: false, //窗体位置不固定
		    maxmin: true,//最大、小化是否显示
		    scrollbar: false,//整个页面滚动条是否显示
			content: ["hospitalGuide/toLists_expertLibs?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
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
			    content: ["hospitalGuide/toLists_sp?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
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
			    content: ["hospitalGuide/toLists_accompany?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
		    closeBtn: 1 //不显示关闭按钮
		});
	}
	function keyNodeDesc(O_ID){
		layer.open({
		    type: 2,
		    title: '就诊过程记录',//窗体标题
		    area: ['30%', '80%'],//整个窗体宽、高，单位：像素px
		    fix: false, //窗体位置不固定
		    maxmin: true,//最大、小化是否显示
		    scrollbar: false,//整个页面滚动条是否显示
			    content: ["hospitalGuide/toLists_keyNode?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
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
			    content: ["hospitalGuide/toLists_eval?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
		    closeBtn: 1 //不显示关闭按钮
		});
	}
	//操作
	function formatStatusFun(value, row, index){
		var btnState = " disable = false ";
		if(row.spinfoOID == null||row.spinfoOID==''){
			btnState = " disabled = true ";
		}
    	var format_v1 = "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnState + " onclick=\"spDesc('"+row.oid+"');\">代理商</button>";
    	btnState = " disable = false ";
		if(row.expertlibsOID == null||row.expertlibsOID==''){
			btnState = " disabled = true ";
		}
    	var format_v2 = "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnState + " onclick=\"expertLibsDesc('"+row.oid+"');\">专家</button>";
    	btnState = " disable = false ";
		if(row.accompanyinfoOID == null||row.accompanyinfoOID==''){
			btnState = " disabled = true ";
		}
    	var format_v3 = "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnState + " onclick=\"accompanyDesc('"+row.oid+"');\">陪诊</button>";
    	btnState = " disable = false ";
		if(row.keynodeOID == null||row.keynodeOID==''){
			btnState = " disabled = true ";
		}
    	var format_v4 = "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnState + " onclick=\"keyNodeDesc('"+row.oid+"');\">就诊</button>";
    	btnState = " disable = false ";
		if(row.evaluateOID == null||row.evaluateOID==''){
			btnState = " disabled = true ";
		}
    	var format_v5 = "<button type=\"button\" class=\"btn btn-default btn-primary\" " + btnState + " onclick=\"orderEvalDesc('"+row.oid+"');\">评价</button>";
    	return format_v1 + "&nbsp;" + format_v2 + "&nbsp;" + format_v3 + "&nbsp;" + format_v4 + "&nbsp;" + format_v5; 
	}
	$(document).ready(function (){
		//初始化下拉菜单
		//$("#M_TYPE_ID").createOption();
		//初始化及查询生成表格内容
		table = $(tableId).bootstrapTable(tableColumns);
		table = $("#queryTableMEMO").bootstrapTable(tableColumnsMEMO);
	});
	</script>
</body>
</html>