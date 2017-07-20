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
						<h5>陪诊信息查询</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
								<select class="form-control" name="SYS_UI_ID" id="SYS_UI_ID" value="${pd.SYS_UI_ID}"
                                    ajax--url="agent/getAllAgent" ajax--column="ID,TEXT" style="width:150px;">
                                    <option value="">--所属代理商--</option>
                     			</select>
							    <input type="text" id="AI_NAME" name="AI_NAME" class="form-control" placeholder="陪诊人员姓名" />
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
			url: 'accompanyInfos/pageSearch?tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'AI_ID',
		        visible: false,
		        halign: 'center'
		    },  {
		        field: 'AI_NAME',
		        title: '姓名',
		        align: 'left',
		        halign: 'center',
		        width: '10%',
		        formatter: formatNAMEFun
		    },  {
		        field: 'SP_NAME',
		        title: '所属代理商',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    },{
		        field: 'AI_SEX',
		        title: '性别',
		        align: 'center',
		        halign: 'center',
		        width: '8%'
		    }, {
		        field: 'AI_BIRTHDAY',
		        title: '出生日期',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'AI_IDCARD',
		        title: '身份证号',
		        align: 'center',
		        halign: 'center',
		        width: '20%'
		    }, {
		        field: 'AI_PHONE',
		        title: '联系手机',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'AI_START_LEVEL',
		        title: '星级',
		        align: 'left',
		        halign: 'center',
		        width: '25%',
		        formatter: starRating
		    }]
		};
		$(document).ready(function (){
			$("#SYS_UI_ID").createOption();
			var msg = "${pd.msg}";
			if(msg != null && msg != ""){
				if(msg == 'success'){
					layer.msg("成功添加陪诊信息！");
				}else if(msg == 'successEdit'){
					layer.msg("成功修改陪诊信息！");
				}else{
					layer.msg("编辑陪诊信息发生异常，请重试或与管理员联系！");
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
			window.location.href = "<%=basePath%>accompanyInfos/toAdd";
		}
		//跳转到编辑页面
		function toEdit(){
			var ids = getBstCheckedId('AI_ID');
			if(!(ids.length == 1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			window.location.href = "<%=basePath%>accompanyInfos/toEdit?AI_ID=" + ids[0];
		}
		//批量删除数据
		function toDel(){
			var ids = getBstCheckedId('AI_ID');
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
						url: '<%=basePath%>accompanyInfos/toDelete?tm=' +  new Date().getTime(),
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
		function toView(AI_ID){
			if(AI_ID != null && AI_ID != ""){
				layer.full(layer.open({
					type: 2,
					title: '信息浏览',//窗体标题
					area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/accompanyInfos/toView?AI_ID=' + AI_ID, 'no'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				}));
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//操作
		function formatNAMEFun(value, row, index){
			var format_v = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toView('"+row.AI_ID+"');\">" + row.AI_NAME + "</button>";
			return format_v;
		}
		
		//显示星级
		function starRating(value, row, index){
        	if(row.AI_START_LEVEL != null || row.AI_START_LEVEL != ''){
				var AI_START_LEVEL = row.AI_START_LEVEL/5*100+"%";
				var rest1 = "<div style=\"width: 100px;height: 30px;margin-top: -4px;margin: auto;\">";
				var rest2 = "<img src=\"images/wx_pj02.png\" width=\"100%\" height=\"30px;\"/>";
				var rest3 = "<div id=\"evaluation\" style=\"width:"+AI_START_LEVEL+";height: 20px;background:#fc8627;margin-top: -27px; \"></div>";
				var rest4 = "</div>";
				return rest1+rest2+rest3+rest4;
			}else{
				return "-";
			}
		}
	</script>
</body>
</html>