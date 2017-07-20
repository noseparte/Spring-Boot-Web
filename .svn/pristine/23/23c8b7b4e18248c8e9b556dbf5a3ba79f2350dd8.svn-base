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
					            <tr>
					                <th>里程碑事件</th>
					                <th>完成时间</th>
					                <th>描述</th>
					            </tr>
					            
					            <c:forEach items="${data.rows }" var="level">
						            <tr>
						                <td data-valign="middle" data-align="center">${level.nmname }</td>
						                <td data-valign="middle" data-align="center">${level.time }</td>
						                <td data-valign="middle" data-align="center">${level.content }</td>
						            </tr>
					            </c:forEach>
					            
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
	</script>
</body>
</html>