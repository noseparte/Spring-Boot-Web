<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <system:header/>
</head> 
<body class="gray-bg">
	<div class="wrapper wrapper-content">
        <div class="row animated fadeInRight">
            <div class="col-sm-3">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>平台</h5>
                        <div class="ibox-tools">
                        </div>
                    </div>
                    <div class="ibox-content">
                        <table class="table table-hover">
                            <tr onclick="getData('${platform.id}')" style="cursor:pointer;">
                                 <td>1</td>
                                 <td>${platform.description }</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>应用信息</h5>
                        <div class="ibox-tools">
                        </div>
                    </div>
                    <div class="ibox-content">

                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>应用名称</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="server" items="${serverList}" varStatus="i">
                            	<tr onclick="getData('${server.id}')" style="cursor:pointer;">
                                    <td>${i.index+1 }</td>
                                    <td>${server.name }</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>服务信息</h5>
                        <div class="ibox-tools">
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="dd" id="nestable">
                            <ol class="dd-list">
                                <c:forEach var="group" items="${serviceList}" varStatus="i">
                                	<li class="dd-item" data-id="${i.index+1}">
                                    <div class="dd-handle">
                                        <span class="label label-info"> <i class="fa fa-users"></i> </span>
                                        ${group.group}
                                    </div>
                                    <ol class="dd-list">
                                        <c:forEach var="service" items="${group.service}" varStatus="j">
                                        	<li class="dd-item" data-id="${service.id}" onclick="getData('${service.id}')">
                                            <div class="dd-handle">
                                                <span class="pull-right label label-info"><i class="fa fa-cog"></i></span>
                                                ${service.sort_name}
                                            </div>
                                        	</li>
                                        </c:forEach>
                                    </ol>
                                	</li>
                                </c:forEach>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-9">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>运行情况</h5>
                        <div class="ibox-tools">
                        </div>
                    </div>
                    <div class="ibox-content" style="padding-top:1px;">
						<div class="clients-list">
                            <ul class="nav nav-tabs">
                                <li class="active"><a data-toggle="tab" href="#tab-1"><i class="fa fa-sitemap"></i>实时监控数据</a>
                                </li>
                                <li class=""><a data-toggle="tab" href="#tab-2"><i class="fa fa-cube"></i>报警数据</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane active" style="height:280px;">
                                    <div class="full-height-scroll">
                                        <div class="table-responsive">
                                            <table class="table table-hover">
					                            <thead>
					                                <tr>
					                                    <th width="40%">指标</th>
					                                    <th width="10%">最小值</th>
					                                    <th width="10%">平均值</th>
					                                    <th width="10%">最大值</th>
					                                    <th width="10%">最新</th>
					                                    <th width="20%">收集时间间隔(s)</th>
					                                </tr>
					                            </thead>
					                            <tbody id="dataTable">
					                            
					                            </tbody>
					                        </table>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-2" class="tab-pane" style="height:280px;">
                                    <div class="full-height-scroll">
                                        <div id="toolbar" class="btn-group">
				                        <div class="pull-left form-inline form-group">
				                       		<input type="hidden" id="insid" name="insid" value="">
				                       		<select class="form-control" name="meaid" id="meaid">
								            	<option value="">--监控参数--</option>
								            </select>
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
                </div>

            </div>
        </div>
    </div>
	<!-- 全局js -->
	<system:jsFooter/>
	<script src="hplus/js/plugins/nestable/jquery.nestable.nodrag.js"></script>
	<!-- 自定义js -->
	<script type="text/javascript">
		$(document).ready(function(){
			$("#nestable").nestable();
			$(".dd").nestable("collapseAll");
			$('#queryTable').bootstrapTable({
			    url: 'monitor/pageSearch',
			    toolbar:'#toolbar' ,
			    columns: [
			    {
			        field: 'measurement_id',
			        visible:false,
			        halign: 'center',
			    }, {
			        field: 'measurement_name',
			        title: '参数名称',
			        align: 'left',
			        halign: 'center',
			    }, {
			        field: 'alert_name',
			        title: '报警名称',
			        align: 'left',
			        halign: 'center',
			    }, {
			        field: 'ctime',
			        title: '报警时间',
			        align: 'center',
			        halign: 'center'
			    },{
			    	field: 'value',
			        title: '报警值',
			        align: 'center',
			        halign: 'center',
			    } ] 
			});
		});
		
		function getData(serviceid){
			$.ajax({
				type: "POST",
				url: 'monitor/getMeasurementData.do',
				data : {
					id : serviceid
				},
				dataType : 'json',
				//beforeSend: validateData,
				cache : false,
				success : function(data) {
					$("#dataTable").html('');
					$("#dataTable").html(data);
				}
			});
		   $("#insid").val(serviceid);
		   bstQuery();
		   $.ajax({
				type: "POST",
				url: 'monitor/getMeasurementSelect.do',
				data : {
					id : serviceid
				},
				dataType : 'json',
				//beforeSend: validateData,
				cache : false,
				success : function(data) {
					$("#meaid").html('');
					$("#meaid").html(data);
				}
			});
		}
		
	</script>

</body>


</html>