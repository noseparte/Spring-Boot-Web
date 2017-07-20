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
					            <tr height="15%">
					                <td width="30%" data-valign="middle" data-align="center">
					                	评价内容：<br/>
					                	${data.rows[0].evacontent }
					                </td>
					            </tr>
					            <tr height="15%">
					                <td width="30%" data-valign="middle" data-align="center">
					                	图片：<br/>
					                	<c:forEach items="${data.rows }" var="level" varStatus="vs">
					                			地址${vs.count }:${level.imageaddr }&nbsp;&nbsp;&nbsp;
					                	</c:forEach>
					                </td>
					            </tr>
					            <tr height="5%">
					                <td width="30%" data-valign="middle" data-align="center">
					                	综合评分:<br/>
					                	专家：
					                	<c:forEach items="${datalevel.rows }" var="level">
					                		<c:if test="${level.type==1 }">
					                			${level.starlevel }
					                		</c:if>
					                	</c:forEach>
					                </td>
					            </tr>
					            <tr>
					                <td width="30%" data-valign="middle" data-align="center">
					                	代理商：
					                	<c:forEach items="${datalevel.rows }" var="level">
					                		<c:if test="${level.type==2 }">
					                			${level.starlevel }
					                		</c:if>
					                	</c:forEach>
					                </td>
					            </tr>
					            <tr>
					                <td width="30%" data-valign="middle" data-align="center">
					                	陪诊：
					                	<c:forEach items="${datalevel.rows }" var="level">
					                		<c:if test="${level.type==3 }">
					                			${level.starlevel }
					                		</c:if>
					                	</c:forEach>
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
	</script>
</body>
</html>