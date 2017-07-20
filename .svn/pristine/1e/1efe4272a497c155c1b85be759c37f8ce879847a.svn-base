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
						<h5>导医信息</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="GI_NAME" name="GI_NAME" class="form-control" placeholder="导医姓名" />
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toAdd();">
							       	新增
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toEdit();">
									修改
							    </button>
							    <button type="button" class="btn btn-default btn-danger" onclick="toDel();">
							       	 删除
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
			url: 'guide/pageSearch?tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'GI_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'GI_EMP_NUM',
		        title: '工号',
		        align: 'center',
		        halign: 'center',
		        width: '17%'
		    }, {
		        field: 'GI_NAME',
		        title: '姓名',
		        align: 'center',
		        halign: 'center',
		        width: '15%',
		        formatter: formatNameFun
		    }, {
		        field: 'GI_SEX',
		        title: '性别',
		        align: 'center',
		        halign: 'center',
		        width: '5%'
		    }, {
		        field: 'GI_BIRTHDAY',
		        title: '出生日期',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'GI_IDCARD',
		        title: '身份证号',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'GI_PHONE',
		        title: '联系手机',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'GI_EDU_LEVEL',
		        title: '学历',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'GI_SCORE',
		        title: '评分',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }]
		};
		$(document).ready(function (){
			var msg = "${pd.msg}";
			if(msg != null && msg != ""){
				if(msg == 'success'){
					layer.msg("成功维护导医信息！");
				}else if(msg == 'failed'){
					layer.msg("工号已被注册，请更换新工号重试！");
				}else{
					layer.msg("维护导医信息发生异常，请重试或与管理员联系！");
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
		//跳转到新增页面
		function toAdd(){
			window.location.href = "<%=basePath%>guide/toAdd";
		}
		//跳转到编辑页面
		function toEdit(){
			var ids = getBstCheckedId('GI_ID');
			if(!(ids.length == 1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			window.location.href = "<%=basePath%>guide/toEdit?GI_ID=" + ids[0];
		}
		//批量删除数据
		function toDel(){
			var ids = getBstCheckedId('GI_ID');
			if((ids.length < 1)){
				layer.msg('请选中信息再进行删除。');
				return false;
			}
			var idsStr = ids.toString();
			layer.confirm('确定删除已选信息吗？', {
				btn: ['确认','取消'],
				shade: false,
				yes: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>guide/toDelete?tm=' +  new Date().getTime(),
						data: {
							IDS: idsStr
						},
						dataType: 'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data) {
							if (data.msg == 'success') {
								layer.msg('删除信息成功');
								bstQuery();
							} else {
								layer.msg('删除信息失败');
							}
						}
					});
				}
			});
		}
		//浏览
		function toView(GI_ID){
			if(GI_ID != null && GI_ID != ""){
				layer.full(layer.open({
					type: 2,
					title: '信息浏览',//窗体标题
					area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/guide/toView?GI_ID=' + GI_ID, 'no'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				}));
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//导医姓名
		function formatNameFun(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toView('" + row.GI_ID + "');\">" + row.GI_NAME + "</button>";
			return format;
		}
	</script>
</body>
</html>