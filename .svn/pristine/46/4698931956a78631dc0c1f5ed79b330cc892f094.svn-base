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
                        <h5>消息通道管理</h5>
                    </div>
                    <div class="ibox-content">
                        <div id="toolbar" class="btn-group">
                        <div class="pull-left form-inline form-group">
						    <shiro:hasPermission name="msgTopic:config">
						    <button type="button" class="btn btn-default btn-primary" onclick="toUser();">
						       	用户管理
						    </button>
						    </shiro:hasPermission>
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
		<script type="text/javascript">
		$(document).ready(function () {
			$('#queryTable').bootstrapTable({
			    url: 'msgTopic/pageSearch',
			    toolbar:'#toolbar' ,
			    columns: [
			    {
			        field: 'TOPIC_ID',
			        visible:false,
			        halign: 'center',
			    }, {
			        field: 'TOPIC_NAME',
			        title: '通道名称',
			        align: 'right',
			        halign: 'center',
			    }, {
			        field: 'TOPIC_CODE',
			        title: '通道代码',
			        align: 'right',
			        halign: 'center',
			    }, {
			        field: 'TOPIC_DESC',
			        title: '通道描述',
			        align: 'right',
			        halign: 'center',
			    }, {
			    	field: 'TOPIC_ORDER',
			        title: '排序',
			        align: 'center',
			        halign: 'center',
			    } ] 
			});
        });
		
		
		function toUser(){
			var ids = getBstCheckedId('TOPIC_ID');
			if(!(ids.length==1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			
			$("#myModal").load("msgTopic/toUser?TOPICID="+ids[0],function(){
				$("#myModal").modal();
			})
		}
		
		</script>
		
	</body>
</html>

