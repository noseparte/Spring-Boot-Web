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
						<h5>代理商绑定专家申请审核</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="SP_NAME" name="SP_NAME" class="form-control" placeholder="代理商名称" />
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
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
			url: 'agent/pageSearch?tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'SP_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'SP_NAME',
		        title: '公司名称',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		    }, {
		        field: 'CAA_NAME',
		        title: '服务范围',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		        formatter:function(value,row,index){
		        	if(row.SP_REGISTER_ADDR == 'country'){
			        	return "全国";
		        	}else{
		        		return row.CAA_NAME;
		        	}
		        } 
		    }, {
		        field: 'SP_REGITER_TIME',
		        title: '注册时间',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'SP_SERVICE_RANGE',
		        title: '业务范围',
		        align: 'left',
		        halign: 'center',
		        width: '30%'
		    }, {
		        field: 'SP_LICENCE',
		        title: '营业执照扫描件地址',
		        visible: false,
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'SP_LEGAL_PERSON',
		        title: '负责人',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'SP_PHONE',
		        title: '联系方式',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'SP_PHONE',
		        title: '合同电子版地址',
		        visible: false,
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		        formatter: formatFromSP
		    }]
		};
		$(document).ready(function (){
			var msg = "${pd.msg}";
			if(msg != null && msg != ""){
				if(msg == 'success'){
					layer.msg("成功编辑代理商信息", {time:3000});
				} else if(msg == 'successEdit'){
					layer.msg("成功编辑代理商信息");
				}else{
					layer.msg("代理商信息编辑失败！");
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
		//详情
		function  formatFromSP(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toView('" + row.SP_ID + "');\">查看详情</button>";
			return format;
		}
		//浏览
		function toView(SP_ID){
			if(SP_ID != null && SP_ID != ""){
				layer.full(
					layer.open({
						type: 2,
						title: '代理商绑定专家申请表',//窗体标题
						area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: false,//最大、小化是否显示
						scrollbar: true,//整体页面滚动条是否显示
						content: ['/jyb/audit/toView?SP_ID=' + SP_ID, 'yes'],//URL地址
						closeBtn: 1,//显示关闭按钮
						btn: ['关闭']
						})
					);
 			}
		}
	</script>
</body>
</html>