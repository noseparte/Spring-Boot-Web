﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <system:header/>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>系统常量管理</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
						        <input type="text" id="SC_NAME" name="SC_NAME"
									class="form-control" placeholder="系统常量名称、代码">
								<button type="button" class="btn btn-default btn-primary"
									onclick="bstQuery();">查询</button>
								<button type="button" class="btn btn-default btn-primary"
									onclick="toAdd();">新增</button>
								<button type="button" class="btn btn-default btn-primary"
									onclick="toEdit();">修改</button>
								<button type="button" class="btn btn-default btn-danger"
									onclick="toDel();">删除</button>	
							</div>

						</div>

						<table id="queryTable" data-mobile-responsive="true"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="myModal" class="modal inmodal fade" tabindex="-1"
		role="dialog" aria-hidden="true"></div>
	<!-- 全局js -->
	<system:jsFooter/>
	<script type="text/javascript">
		
		$(document).ready(function () {
		       table= $('#queryTable').bootstrapTable({
			    url: 'constant/pageSearch',
			    toolbar:'#toolbar' ,
			    columns: [{
			        field: 'SC_ID',
			        visible:false,
			        halign: 'center',
			    }, {
			        field: 'SC_CODE',
			        title: '系统常量代码',
			        align: 'right',
			        halign: 'center',
			    }, {
			        field: 'SC_NAME',
			        title: '系统常量名称',
			        align: 'right',
			        halign: 'center',
			    }, {
			        field: 'SC_VALUE',
			        title: '系统常量值',
			        align: 'right',
			        halign: 'center',
			    }, {
			        field: 'SC_REMARK',
			        title: '备注',
			        align: 'right',
			        halign: 'center',
			    }, {
			        field: 'SC_ORD_BY',
			        title: '排序',
			        align: 'right',
			        halign: 'center',
			    }] 
			});
		       
		       
		       
        });
		
	
	
		
		function toAdd(){
			window.location.href="<%=basePath%>constant/toAdd";
		}
		
		function toEdit(){
			var ids = getBstCheckedId('SC_ID');
			if(!(ids.length==1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			window.location.href="<%=basePath%>constant/toEdit?SC_ID="+ids[0];
		}
		
		function toDel(){
			var ids = getBstCheckedId('SC_ID');
			if((ids.length<1)){
				layer.msg('请选中信息再进行删除。');
				return false;
			}
			var idsStr = ids.toString();
			layer.confirm('确认删除已选系统常量吗？',{btn:['确认','取消'],shade:false},function(){
				$.ajax({
					type: "POST",
					url: 'constant/delete?tm='+ new Date().getTime(),
					data : {
						IDS : idsStr
					},
					dataType : 'json',
					//beforeSend: validateData,
					cache : false,
					success : function(data) {
						if (data.msg == 'ok') {
							layer.msg('删除信息成功');
							bstQuery();
						} else {
							layer.msg('删除信息失败');
						}

					}
				});

			}, function() {

			});

		}
	</script>

</body>
</html>

