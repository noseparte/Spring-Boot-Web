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
						<h5>地图初始位置管理</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							    <input type="text" id="HL_CODE" name="HL_CODE"
									class="form-control" placeholder="地图初始位置代码">
								<button type="button" class="btn btn-default btn-primary"
									onclick="bstQuery();">查询</button>
								<button type="button" class="btn btn-default btn-primary"
									onclick="toEdit();">修改</button>
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
			    url: 'homeLocation/pageSearch',
			    toolbar:'#toolbar' ,
			    columns: [{
			        field: 'HL_ID',
			        visible:false,
			        halign: 'center',
			    }, {
			        field: 'HL_CODE',
			        title: '地图初始位置代码',
			        align: 'right',
			        halign: 'center',
			    }, {
			        field: 'HL_LT_LNG',
			        title: '左上经度',
			        align: 'right',
			        halign: 'center',
			    }, {
			        field: 'HL_LT_LAT',
			        title: '左上纬度',
			        align: 'right',
			        halign: 'center',
			    }, {
			        field: 'HL_RB_LNG',
			        title: '右下经度',
			        align: 'right',
			        halign: 'center',
			    }, {
			        field: 'HL_RB_LAT',
			        title: '右下纬度',
			        align: 'right',
			        halign: 'center',
			    }, {
			        field: 'HL_LEVEL',
			        title: '层级',
			        align: 'right',
			        halign: 'center',
			    }, {
			        field: 'HL_REMARK',
			        title: '备注',
			        align: 'right',
			        halign: 'center',
			    }] 
			});
		       
        });
		

		function toEdit(){
			var ids = getBstCheckedId('HL_ID');
			if(!(ids.length==1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			window.location.href="<%=basePath%>homeLocation/toEdit?HL_ID="+ids[0];
		}
		
	</script>

</body>
</html>

