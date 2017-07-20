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
						<h5>代理商绑定专家申请</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="HEL_NAME" name="HEL_NAME" class="form-control" placeholder="专家姓名" />
							    <select class="form-control" name="HD_ID" id="HD_ID" value="${pd.HD_ID}"
                                    ajax--url="hospDept/getHospDeptForSelect" ajax--column="ID,TEXT" style="width:150px;">
                                    <option value="">--所属科室--</option>
                     			</select>
                     			<select class="form-control required" name="HE_AREA" id="HE_AREA" value="${pd.HE_AREA}"
                                    	ajax--url="dic/getDicAreaForSelect" ajax--column="ID,TEXT">
                                    	<option value="">--所属区域--</option>
                     			</select>
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="bund();">
							       	绑定
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
			url: 'jyb/bundling/search?tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'HEL_ID',
		        visible:false,
		        halign: 'center',
		    }, {
		        field: 'ELR_ID',
		        title: '姓名',
		        visible:false,
		        halign: 'center',
		        width: '10%',
		    }, {
		        field: 'HEL_NAME',
		        title: '姓名',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		        formatter: formatNameFun
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
		        width: '10%'
		    }, {
		    	field: 'HE_AREA',
		        title: '所属地区',
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
		        width: '32%'
		    }, {
		        field: 'HEL_PRICE',
		        title: '定价',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'DEL_BIND',
		        title: '状态',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		        formatter: formatState
		    }]
		};
		$(document).ready(function (){
			//初始化下拉菜单
			$("#HD_ID").createOption();
			$("#HE_AREA").createOption();
			//初始化及查询生成表格内容
			table = $(tableId).bootstrapTable(tableColumns);
		});
		//批量绑定专家
		function bund(){
			var ids = getBstCheckedId('HEL_ID');
			if((ids.length < 1)){
				layer.msg('请选中信息再进行绑定。');
				return false;
			}
			var idsStr = ids.toString();
			layer.confirm('确定绑定已选专家吗？', {
				btn: ['确认','取消'],
				shade: false,
				yes: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>jyb/bundling/saveBing?tm=' +  new Date().getTime(),
						data: {
							IDS: idsStr
						},
						dataType: 'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data) {
							if (data.msg == 'success') {
								layer.msg('申请成功，请等待审批结果。');
								bstQuery();
							} else {
								layer.msg('申请失败');
							}
						}
					});
				}
			});
		}
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
		//浏览
		function toView(HEL_ID,ELR_ID){
			if(HEL_ID != null && HEL_ID != ""){
				layer.full(
					layer.open({
						type: 2,
						title: '专家浏览',//窗体标题
						area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: false,//最大、小化是否显示
						scrollbar: true,//整体页面滚动条是否显示
						content: ['/jyb/bundling/toView?HEL_ID=' + HEL_ID + '&' + 'ELR_ID=' + ELR_ID, 'yes'],//URL地址
						closeBtn: 1,//显示关闭按钮
						btn: ['关闭']
					})
				);
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//专家姓名
		function formatNameFun(value, row, index){
			var DEL_BIND = row.DEL_BIND; 
			console.log(DEL_BIND);
			if(DEL_BIND == 0){
				var format = "<button type=\"button\" class=\"btn btn-link\" style=\"color:red\" onclick=\"toView('" + row.HEL_ID + '\',\'' + row.ELR_ID +"');\">" + row.HEL_NAME + "</button>";
			}else if(DEL_BIND == 1){
				var format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toView('" + row.HEL_ID + '\',\'' + row.ELR_ID +"');\">" + row.HEL_NAME + "</button>";
			}else if(DEL_BIND == 2){
				var format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toView('" + row.HEL_ID + '\',\'' + row.ELR_ID +"');\">" + row.HEL_NAME + "</button>";
			}
			return format;
		}
		//专家绑定状态
		function formatState(value, row, index){
			var DEL_BIND = row.DEL_BIND; 
			console.log(DEL_BIND);
			if(DEL_BIND == 0){
				var format = "<span>" + '退回' + "</span>";
			}else if(DEL_BIND == 1){
				var format = "<span>" + '可绑定' + "</span>";
			}else if(DEL_BIND == 2){
				var format = "<span>" + '审核中' + "</span>";
			}
			return format;
		}
	</script>
</body>
</html>