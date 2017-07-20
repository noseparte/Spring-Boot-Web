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
					<div class="ibox-title">
						<h5>用户：${pd.UI_NAME}</h5>
					</div>
					<div class="ibox-content">
						<form id="CaseHistoryForm" name="CaseHistoryForm" class="form-horizontal" method="post">
							<div class="form-group">
								<label class="col-sm-2 control-label">性别：</label>
							    <div class="col-sm-4">
									${pd.UI_SEX}
								</div>
								<label class="col-sm-2 control-label">出生日期：</label>
							    <div class="col-sm-4">
									${pd.UI_BIRTHDAY}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">身份证号：</label>
							    <div class="col-sm-4">
									${pd.UI_IDCARD}
								</div>
								<label class="col-sm-2 control-label">联系手机：</label>
							    <div class="col-sm-4">
									${pd.UI_PHONE}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">病情描述：</label>
							    <div class="col-sm-10" style="word-break:break-all;">
									${pd.CH_ILL_DESC}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">就医历史：</label>
							    <div class="col-sm-10" style="word-break:break-all;">
									${pd.CH_MEDIA_HIS}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">过敏史：</label>
							    <div class="col-sm-10" style="word-break:break-all;">
									${pd.CH_ALLERGY}
								</div>
							</div>
						</form>
						<table id="queryTable" data-mobile-responsive="true"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 全局js -->
    <system:jsFooter/>
	<!-- 自定义js -->
	<script type="text/javascript">
		//表格ID
		var tableId = "#queryTable";
		//表格请求及数据
		var tableColumns = {
			url: 'commMemo/pageSearch?UI_ID=${pd.UI_ID}&tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'CH_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'CH_MEMO',
		        title: '沟通备忘录',
		        align: 'left',
		        halign: 'center',
		        width: '90%'
		    }]
		};
		$(document).ready(function(){
			//初始化及查询生成表格内容
			table = $(tableId).bootstrapTable(tableColumns);
		});
		//查询刷新表格
		function searchRefreshTable(){
			//销毁表格
			$(tableId).bootstrapTable('destroy');
			$(tableId).bootstrapTable(tableColumns);
		}
	</script>
</body>
</html>