<%@ page language="java" contentType="text/html; charset=UTF-8"
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
						<form id="HospitalExpertLibsForm" name="HospitalExpertLibsForm" class="form-horizontal" method="post">
							<div class="form-group">
								<input type="hidden" id="HEL_ID" name="HEL_ID" value="${pd.HEL_ID }"/>
							    <table id="queryTable" data-mobile-responsive="true"></table>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 全局js -->
    <system:jsFooter/>
	<!-- 自定义js -->
	<script type="text/javascript">
		var HEL_ID = "${pd.HEL_ID}";
		//表格ID
		var tableId = "#queryTable";
		//表格请求及数据
		var tableColumns = {
			url: 'hospExpLib/selectSP?HEL_ID=' + HEL_ID,
			toolbar: '#toolbar',
			columns: [{
		        field: 'SP_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'SP_NAME',
		        title: '姓名',
		        align: 'center',
		        halign: 'center',
		        width: '80%'
		    }]
		};
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