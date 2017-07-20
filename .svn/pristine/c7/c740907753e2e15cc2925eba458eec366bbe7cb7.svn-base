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
						<h5>好友圈信息管理</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							<select class="form-control" name="RECOMMEND_STATE"
									id="RECOMMEND_STATE" value="${pd.RECOMMEND_STATE}"
									onchange="" style="width:135px;">
									<option value="">--推荐状态--</option>
									<option value="1">推荐</option>
									<option value="0">不推荐</option>
								</select>
								<select class="form-control" name="SHARE_TYPE"
									id="SHARE_TYPE" value="${pd.SHARE_TYPE}"
									onchange="" style="width:135px;">
									<option value="">--信息类别--</option>
									<option value="1">视频</option>
									<option value="2">图片</option>
								</select>
								<select class="form-control" name="CHECK_STATE"
									id="CHECK_STATE" value="${pd.CHECK_STATE}"
									onchange="" style="width:135px;">
									<option value="">--审核状态--</option>
									<option value="0">未审核</option>
									<option value="1">已通过</option>
									<option value="2">未通过</option>
								</select>
								<input type="text" class="bootstrapdatetimepicker form-control " name="BEGIN_TIME" id="BEGIN_TIME" placeholder="开始日期" value="${pd.BEGIN_TIME }" style="width:110px;"/>
								<input type="text" class="bootstrapdatetimepicker form-control " name="END_TIME" id="END_TIME" placeholder="结束日期"  value="${pd.END_TIME }" style="width:110px;"/>
							    <input type="text" id="UI_NAME" name="UI_NAME" class="form-control" placeholder="发布人姓名" style="width:110px;"/>
							    
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toRec();">
							       	更改推荐
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
			url: 'share/pageSearch?tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'SHARE_ID',
		        visible: false,
		        halign: 'center'
		    },  {
		    	field: 'SHARE_TYPES',
		    	title: '信息类别',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
		        formatter: formatCheckStatusFun 
		    }, {
		        field: 'UI_NAME',
		        title: '发布人',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'PUBLISH_TIME',
		        title: '发布时间',
		        align: 'center',
		        halign: 'center',
		        width: '18%'
		    }, {
		        field: 'SHARE_COMMENT',
		        title: '信息描述',
		        align: 'left',
		        halign: 'center',
		        width: '40%',
		        /* formatter: formatCheckStatusFun */
		    }, {
		        field: 'CHECK_STATE',
		        title: '审核状态',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'RECOMMEND_STATE',
		        title: '推荐状态',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }  ]
		};
		$(document).ready(function (){
			/* var msg = "${pd.msg}";
			if(msg != null && msg != ""){
				if(msg == 'success'){
					layer.msg("成功维护导医信息！");
				}else if(msg == 'failed'){
					layer.msg("工号已被注册，请更换新工号重试！");
				}else{
					layer.msg("维护导医信息发生异常，请重试或与管理员联系！");
				}
			} */
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
		//跳转到详情页面
		function formatCheckStatusFun(value, row, index){
			var format = "";
			if(row.SHARE_TYPE == 1){
				format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toVideoView('" + row.SHARE_ID + "','"+row.SHARE_COMMENT+"');\">视频</button>";
			}else if(row.SHARE_TYPE == 2){
				format = "<button type=\"button\" class=\"btn btn-link\" onclick=\"toPicView('" + row.SHARE_ID + "','"+row.SHARE_COMMENT+"');\">图片</button>";
			}
			return format;
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
		//跳转到视频详情页面
		function toVideoView(SHARE_ID,SHARE_COMMENT){
			<%-- window.location.href = "<%=basePath%>share/toVideo?SHARE_ID=" + SHARE_ID+"&SHARE_COMMENT="+SHARE_COMMENT; --%>
			layer.full(
					layer.open({
					    type: 2,
					    title: '修改专家',//窗体标题
					    area: ['900px', '430px'],//整个窗体宽、高，单位：像素px
					    fix: false, //窗体位置不固定
					    maxmin: false,//最大、小化是否显示
					    scrollbar: false,//整个页面滚动条是否显示
		 			    content: ["share/toVideo?SHARE_ID=" + SHARE_ID+"&SHARE_COMMENT="+SHARE_COMMENT , "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
					    closeBtn: 1, //不显示关闭按钮
					    btn:['关闭']
					})
				);
		}
		//跳转到视频详情页面
		function toPicView(SHARE_ID,SHARE_COMMENT){
			<%-- window.location.href = "<%=basePath%>share/toPic?SHARE_ID=" + SHARE_ID+"&SHARE_COMMENT="+SHARE_COMMENT; --%>
			layer.full(
					layer.open({
					    type: 2,
					    title: '修改专家',//窗体标题
					    area: ['900px', '430px'],//整个窗体宽、高，单位：像素px
					    fix: false, //窗体位置不固定
					    maxmin: false,//最大、小化是否显示
					    scrollbar: false,//整个页面滚动条是否显示
		 			    content: ["share/toPic?SHARE_ID=" + SHARE_ID+"&SHARE_COMMENT="+SHARE_COMMENT , "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
					    closeBtn: 1, //不显示关闭按钮
					    btn:['关闭']
					})
				);
		}
		//批量删除数据
		function toDel(){
			var ids = getBstCheckedId('SHARE_ID');
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
						url: '<%=basePath%>share/toDelete?tm=' +  new Date().getTime(),
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
		//浏览toRecommend
		function toRec(){
			var ids = getBstCheckedId('SHARE_ID');
			if((ids.length < 1)){
				layer.msg('请选中信息再进行操作');
				return false;
			}
			var idsStr = ids.toString();
			layer.confirm('确定更改推荐状态吗？', {
				btn: ['确认','取消'],
				shade: false,
				yes: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>share/recommend?tm=' +  new Date().getTime(),
						data: {
							IDS: idsStr
						},
						dataType: 'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data) {
							if (data.msg == 'success') {
								layer.msg('更改状态成功');
								bstQuery();
							} else {
								layer.msg('更改状态失败');
							}
						}
					});
				}
			});
		}
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
		
	</script>
</body>
</html>