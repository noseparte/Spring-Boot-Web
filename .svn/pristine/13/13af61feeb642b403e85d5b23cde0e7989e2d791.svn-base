<%@ page language="java" contentType="text/html; charset=UTF-8"
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
						<h5>服务器运行信息监控</h5>
					</div>
					<div class="ibox-content">
						<span class="text-muted small pull-right">最后更新：<i class="fa fa-clock-o"></i> 2016-05-01 12:00</span>
                        <p>
                            部署的服务器及光电设备的运行监控
                        </p>
                        <div class="clients-list">
                            <ul class="nav nav-tabs">
                                <li class="active"><a data-toggle="tab" href="#tab-1"><i class="fa fa-sitemap"></i>服务器</a>
                                </li>
                                <li class=""><a data-toggle="tab" href="#tab-2"><i class="fa fa-cube"></i>光电设备</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane active" style="height:280px;">
                                    <div class="full-height-scroll">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover">
                                                <tbody>
                                                  <tr>
                                                        <td class="client-avatar"></td>
                                                        <td>IP</td>
                                                        <td>操作系统</td>
                                                        <td>CPU数量</td>
                                                        <td>系统类型</td>
                                                        <td>别称</td>
                                                        <td>运行状态</td>
                                                    </tr>
                                                   <c:forEach items="${list}" var="platform">
												   <tr>
                                                        <td class="client-avatar"><img alt="image" src="hplus/img/Server.png"> </td>
                                                        <td><a href="javascript:openPlatform('${platform.id}')" class="client-link">${platform.address }</a>
                                                        </td>
                                                        <td>${platform.description }</td>
                                                        <td>${platform.cpu_count }</td>
                                                        <td>${platform.ptype }</td>
                                                        <td>${platform.rname }</td>
                                                        <td>运行</td>
                                                    </tr>
												   
												   </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-2" class="tab-pane" style="height:280px;">
                                    <div class="full-height-scroll">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover">
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
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

	<!-- 自定义js -->
	<script type="text/javascript">
		function openPlatform(platform){
			window.location="${basePath}monitor/listServerAndService?id="+platform;
		}
	
	</script>

</body>


</html>