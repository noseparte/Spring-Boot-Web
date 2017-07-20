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
					<!-- <div class="ibox-title">
						<h5>专家库信息</h5>
					</div> -->
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
							</div>
						</div>
						
						<table id="queryTable" data-mobile-responsive="true" cellpadding="0" cellspacing="0" class="table table-hover table-bordered">
							 <thead>
					            <tr height="5%">
					                <th width="15%" >姓名</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].helname }
					                </td>
					            </tr>
					            <tr height="5%">
					                <th width="15%" data-valign="middle" data-align="center">性别</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].helsex }
					                </td>
					            </tr>
					            <tr>
					                <th width="15%" data-valign="middle" data-align="center">出生日期</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].helbirthday }
					                </td>
					            </tr>
					            <tr>
					                <th width="15%" data-valign="middle" data-align="center">职务</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].helduty }
					                </td>
					            </tr>
					            <tr>
					                <th width="15%" data-valign="middle" data-align="center">擅长专业</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].helgoodpro }
					                </td>
					            </tr>
					            <tr>
					                <th width="15%" data-valign="middle" data-align="center">教学背景</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].heledu }
					                </td>
					            </tr>
					            <tr>
					                <th width="15%" data-valign="middle" data-align="center">定价</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].helprice }
					                </td>
					            </tr>
					            <tr>
					                <th width="15%" data-valign="middle" data-align="center">照片</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].helphoto }
					                </td>
					            </tr>
					            <tr>
					                <th width="15%" data-valign="middle" data-align="center">相关荣耀</th>
					                <td width="30%" data-valign="middle" data-align="center">
					                	${data.rows[0].helhonor }
					                </td>
					            </tr>
					        </thead>
						</table>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="myModal" class="modal inmodal fade" tabindex="-1" role="dialog"  aria-hidden="true">
	<!-- 全局js -->
	<system:jsFooter/>
	<script type="text/javascript">
		//表格ID
		var tableId = "#queryTable";
		//表格请求及数据
		var tableColumns = {
			url: 'hospitalGuide/expertLibsDesc?O_ID=${pd.O_ID}&tm=' + new Date().getTime(),
			toolbar:'#toolbar' ,
			columns: [{
		        field: 'oid',
		        visible:false,
		        halign: 'center',
		    }, {
		        field: 'helname',
		        title: '专家姓名',
		        align: 'left',
		        halign: 'center'
		    }, {
		        field: 'helsex',
		        title: '性别',
		        align: 'left',
		        halign: 'center'
		    }, {
		        field: 'helbirthday',
		        title: '出生日期',
		        align: 'center',
		        halign: 'center'
		    }, {
		        field: 'helduty',
		        title: '职务',
		        align: 'left',
		        halign: 'center'
		    }, {
		        field: 'helgoodpro',
		        title: '擅长专业',
		        align: 'left',
		        halign: 'center'
		    }, {
		        field: 'heledu',
		        title: '教学背景',
		        align: 'center',
		        halign: 'center'
		    }, {
		        field: 'helprice',
		        title: '定价',
		        align: 'center',
		        halign: 'center'
		    }, {
		        field: 'helphoto',
		        title: '照片',
		        align: 'center',
		        halign: 'center'
		    }, {
		        field: 'helhonor',
		        title: '相关荣耀',
		        align: 'center',
		        halign: 'center'
		    }]
		};
		
		$(document).ready(function (){
			//初始化及查询生成表格内容
			//table = $(tableId).bootstrapTable(tableColumns);
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