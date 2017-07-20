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
						<h5>用户信息管理</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
								<input type="text" id="USERNAME" name="USERNAME"
									class="form-control" placeholder="用户名称">
								<button type="button" class="btn btn-default btn-primary"
									onclick="bstQuery();">查询</button>
								<shiro:hasPermission name="user:add">
									<a href="javascript:toAdd()" class="btn btn-default btn-primary"
										id="addFun">新增</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="user:edit">
									<a href="javascript:toEdit()" class="btn btn-default btn-primary"
										id="editFun">修改</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="user:exp">
									<a href="javascript:toExport()" class="btn btn-default btn-primary"
										id="expFun">导出</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="user:delete">
									<a href="javascript:toDel()" class="btn btn-default btn-danger"
										id="deleteFun">删除</a>
								</shiro:hasPermission>
								<button type="button" class="btn btn-default btn-primary"
									onclick="showRP();">查看授权</button>
							</div>
						</div>

					<table id="queryTable" data-mobile-responsive="true"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="myModal" class="modal inmodal fade" tabindex="-1" role="dialog"  aria-hidden="true">
		                        	 
	</div>
	<!-- 全局js -->
	<system:jsFooter/>

	<!-- 自定义js -->
	<script type="text/javascript">

$(document).ready(function () {
    table= $('#queryTable').bootstrapTable({
	    url: 'user/pageSearch.do',
	    toolbar:'#toolbar' ,
	    columns: [
	    {
	        field: 'USER_ID',
	        visible:false,
	        halign: 'center',
	    }, {
	        field: 'USERNAME',
	        title: '用户名',
	        align: 'right',
	        halign: 'center',
	    }, {
	        field: 'NAME',
	        title: '姓名',
	        align: 'right',
	        halign: 'center',
	    },{
	    	field: 'LAST_LOGIN',
	        title: '最近登录',
	        align: 'center',
	        halign: 'center',
	    },{
	    	field: 'IP',
	        title: '上次登录IP',
	        align: 'center',
	        halign: 'center',
	    }
	    ] 
	});
});
		
		function toAdd(){
			window.location.href="<%=basePath%>user/toAdd";
		}
		
		function toEdit(){
			var ids = getBstCheckedId('USER_ID');
			if(!(ids.length==1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			window.location.href="<%=basePath%>user/toEdit?USER_ID="+ids[0];
		}
		
		function toExport(){
			window.open('user/export');
		}
		
		function toDel(){
			var ids = getBstCheckedId('USER_ID');
			if((ids.length<1)){
				layer.msg('请选中信息再进行删除。');
				return false;
			}
			var idsStr = ids.toString();
			layer.confirm('确认删除这些信息吗？',{
				btn:['确认','取消'],
				shade:false
			},function(){
				$.ajax({
					type: "POST",
					url: 'user/delete.do?tm='+ new Date().getTime(),
					data : {
						IDS : idsStr
					},
					dataType : 'json',
					//beforeSend: validateData,
					cache : false,
					success : function(data) {
						bstQuery();
						if (data.msg == 'ok') {
							layer.msg('删除信息成功');
						} else {
							layer.msg('删除信息失败');
						}

					}
				});

			}, function() {

			});

		}
		
		function showRP(){
			var ids = getBstCheckedId('USER_ID');
			if(!(ids.length==1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			$("#myModal").html('');
			$("#myModal").load("user/showRP?USER_ID="+ids[0],function(){
				$("#myModal").modal();
			})
		}
	</script>

</body>
</html>

