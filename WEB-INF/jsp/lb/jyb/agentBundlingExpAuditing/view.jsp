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
						<form id="agentBundExpAuditForm" name="agentBundExpAuditForm" class="form-horizontal" method="post">
							<div class="form-group">
								<input type="hidden" id="SP_ID" name="SP_ID" value="${pd.SP_ID }"/>
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
		var SP_ID = "${pd.SP_ID}";
		//表格ID
		var tableId = "#queryTable";
		//表格请求及数据
		var tableColumns = {
			url: 'jyb/audit/saveView?SP_ID=' + SP_ID,
			toolbar: '#toolbar',
			columns: [{
		        field: 'HEL_ID',
		        visible:false,
		        halign: 'center',
		    }, {
		        field: 'ELR_ID',
		        title: '编号',
		        align: 'center',
		        visible:false,
		        halign: 'center',
		        width: '10%',
		    }, {
		        field: 'HEL_NAME',
		        title: '姓名',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		        //formatter: formatNameFun
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
		    	field: 'CAA_NAME',
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
		        field: 'HEL_PRICE',
		        title: '操作',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		        formatter: fromatAccess
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
		//是否通过
		function  fromatAccess(value, row, index){
			var format = "<button type=\"button\" class=\"btn btn-default btn-primary\" onclick=\"toAccess('" + row.HEL_ID + "','" + row.ELR_ID + "');\">审核</button>";
			return format;
		}
		//审核
		function toAccess(HEL_ID,ELR_ID){
			layer.confirm('信息审核', {
				btn: ['通过','不通过','取消'],
				shade: false,
				btn1: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>jyb/audit/toCheck?DEL_BIND=1 & tm=' +  new Date().getTime(),
						data: {
							HEL_ID: HEL_ID,
							ELR_ID: ELR_ID
						},
						dataType: 'json',
						cache: false,
						success: function(data) {
							if (data.msg == 'success') {
								layer.msg('信息审核成功！');
								bstQuery();
								layer.close(index);
							}   else {
								layer.msg('信息审核失败！');
							}
						}
					});
				},btn2: function(index, layero){
				    //按钮【按钮二】的回调
				    
					layer.open({
						type: 2,
						title: '信息审核',//窗体标题
						area: ['500px', '360px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: false,//最大、小化是否显示
						scrollbar: false,//整体页面滚动条是否显示
						content: ['/jyb/audit/toBackReason', 'no'],//URL地址
						closeBtn: 0,//不显示关闭按钮
						btn: ['确认', '取消'],
						btn1: function(index, layero){
							var reanson = $(layero).find("iframe")[0].contentWindow.formData();
							if(reanson != null){
								$.ajax({
									type: "POST",
									url: '<%=basePath%>jyb/audit/toCheck?DEL_BIND=0&tm=' +  new Date().getTime(),
									data: {
										HEL_ID: HEL_ID,
										ELR_ID: ELR_ID,
										ReturnReason: reanson
									},
									dataType: 'json',
									cache: false,
									success: function(data) {
										if (data.msg == 'success') {
											layer.msg('信息未通过，退回成功！');
											bstQuery();
										} else {
											layer.msg('信息未通过，退回失败！');
										}
									}
								});
							}else{
								layer.msg('未通过需填写退回原因！');
							}
						},
					});
				    
					
				  },btn3: function(index, layero){
				    //按钮【按钮三】的回调
				    layer.closeAll('dialog');//关闭按钮
				  }
			});
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