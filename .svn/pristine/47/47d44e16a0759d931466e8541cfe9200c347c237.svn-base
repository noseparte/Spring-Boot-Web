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
						<h5>反馈信息管理</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
								<input type="text" class="bootstrapdatetimepicker form-control " name="BEGIN_TIME" id="BEGIN_TIME" placeholder="开始日期" value="${pd.BEGIN_TIME }" />
								<input type="text" class="bootstrapdatetimepicker form-control " name="END_TIME" id="END_TIME" placeholder="结束日期"  value="${pd.END_TIME }" />
								<input type="text" id="SF_CONTENT" name="SF_CONTENT" class="form-control" placeholder="反馈内容"/>
							    <input type="text" id="NAME" name="NAME" class="form-control" placeholder="反馈人姓名" />
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
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
			url: 'feedBack/pageSearch?tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'SF_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'SF_CONTENT',
		        title: '反馈内容',
		        align: 'center',
		        halign: 'center',
		        width: '50%',
		        formatter: formatCheckStatusFun 
		    }, {
		        field: 'CREATE_TIME',
		        title: '反馈时间',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    },  {
		    	field: 'NAME',
		    	title: '反馈人',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		        /* formatter: formatCheckStatusFun */ 
		    }, {
		        field: 'SF_PHONE',
		        title: '联系方式',
		        align: 'left',
		        halign: 'center',
		        width: '10%'
		        /* formatter: formatCheckStatusFun */
		    }, {
		        field: 'TYPE',
		        title: '反馈角色',
		        align: 'left',
		        halign: 'center',
		        width: '10%'
		        /* formatter: formatCheckStatusFun */
		    }]
		};
		$(document).ready(function (){
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
		//跳转到详情页面
		function formatCheckStatusFun(value, row, index){
			var format = "";
			if(row.SF_CONTENT != null && row.SF_CONTENT != ""){
				format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toPicView('" + row.SF_CONTENT + "','"+row.SF_ID+"');\">"+row.SF_CONTENT+"</button>";
			}
			return format;
		}
		//跳转到图片详情页面
		function toPicView(SF_CONTENT,SF_ID){
			
			layer.full(
					layer.open({
					    type: 2,
					    title: '反馈详情',//窗体标题
					    area: ['900px', '530px'],//整个窗体宽、高，单位：像素px
					    fix: false, //窗体位置不固定
					    maxmin: false,//最大、小化是否显示
					    scrollbar: false,//整个页面滚动条是否显示
		 			    content: ["feedBack/toPic?SF_ID=" + SF_ID+"&SF_CONTENT="+SF_CONTENT , "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
					    closeBtn: 1, //不显示关闭按钮
					    btn:['关闭']
					})
			)
		}
		//批量删除数据
		function toDel(){
			var ids = getBstCheckedId('SF_ID');
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
						url: '<%=basePath%>feedBack/toDelete?tm=' +  new Date().getTime(),
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
		
		
	</script>
</body>
</html>