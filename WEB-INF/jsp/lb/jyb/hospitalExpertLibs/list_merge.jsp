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
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
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
			url: 'hospExpLib/mergePageSearch?tm=' + new Date().getTime(),
			toolbar: '#toolbar',
			clickToSelect: false,//单击不选中行
			showCheckbox: false,//不显示复选框列
			columns: [{
		        field: 'HEL_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'HEL_NAME',
		        title: '姓名',
		        align: 'center',
		        halign: 'center',
		        width: '7%',
		        formatter: formatNameFun
		    }, {
		        field: 'T_HEL_SEX',
		        title: '性别',
		        align: 'center',
		        halign: 'center',
		        width: '5%'
		    }, {
		        field: 'HD_NAME',
		        title: '所属科室',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'HE_BELONGAGENT',
		        title: '代理商',
		        align: 'left',
		        halign: 'center',
		        width: '30%'
		    }, {
		        field: 'HE_HOSPITAL',
		        title: '所属医院',
		        align: 'left',
		        halign: 'center',
		        width: '30%'
		    }, {
		        field: 'STATUS',
		        title: '操作',
		        align: 'center',
		        halign: 'center',
		        width: '12%',
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
			var format_v1;
			var format_v2;
			if(row.mergeSize == 1){
				if(row.HEL_MERGE != null){
					format_v1 = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toMergeView('" + row.HD_ID + "','" + row.HEL_NAME + "','" + row.HEL_SEX + "');\">详情</button>";
					return format_v1;
				}else{
					if(row.NAM != null){
						format_v1 = '';
					}else{
						format_v1 = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toExpertLibs('" + row.HEL_ID + "','" + row.HEL_NAME + "');\">入库</button>";
					}
					format_v2 = "<button type=\"button\" class=\"btn btn-default btn-danger\" onclick=\"toExpertTmp('" + row.HEL_ID + "');\">退回</button>";
					return format_v1 + "&nbsp;" + format_v2;
				}
			}else if(row.mergeSize > 1){
				format_v1 = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toMergeView('" + row.HD_ID + "','" + row.HEL_NAME + "','" + row.HEL_SEX + "');\">详情</button>";
				return format_v1;
			}
		}
		//专家姓名预览资料
		function formatNameFun(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toView('" + row.HEL_ID + "');\">" + row.HEL_NAME + "</button>";
			return format;
		}
		function toView(HEL_ID){
			if(HEL_ID != null && HEL_ID != ""){
				layer.full(layer.open({
					type: 2,
					title: '信息浏览',//窗体标题
					area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ["hospitalExpertTmp/toMergeLists?HEL_ID=" + HEL_ID , "yes"],//URL地址,yes或者or是表示是否允许出现滚动条
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				}));
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		
		//合并专家详情
		function toMergeView(HD_ID, HEL_NAME, HEL_SEX){
			this.location.href="<%=basePath%>hospExpLib/toMergeViewLists?HD_ID=" + HD_ID + "&HEL_NAME=" + HEL_NAME + "&HEL_SEX=" + HEL_SEX;
		}
		//入库
		function toExpertLibs(HEL_ID, HEL_NAME){
			if(HEL_ID != null && HEL_ID != '' && HEL_NAME != null && HEL_NAME != ''){
				layer.confirm('确定已选专家导入专家库吗？', {
					btn: ['确认','取消'],
					shade: false,
					yes: function(index, layero){
						$.ajax({
							type: "POST",
							url: '<%=basePath%>hospExpLib/setTemplate?tm=' +  new Date().getTime(),
							data: {
								IDS: HEL_ID,
								HEL_NAME: HEL_NAME,
								HEL_MERGE: '1'
							},
							dataType: 'json',
							cache: false,
							success: function(data) {
								if (data.msg == 'success') {
									layer.msg('导入专家库成功！');
									bstQuery();
								} else {
									layer.msg('导入专家库失败！');
								}
							}
						});
					}
				});
			}else{
				layer.msg('系统未获取数据主键，请重新选择数据！');
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
		//返回到列表页面 
		function goBack(){
			this.location.href="<%=basePath%>hospExpLib/toLists";
		}
	</script>
</body>
</html>