<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en" style="height:90%">
<head>
<system:header />
<link rel="stylesheet" type="text/css" href="hplus/css/style.min.operation.css"></link>
<!-- jsp文件头和头部 -->
<style type="text/css">
body {
	margin: 2%;
}
</style>
</head>
<body class="gray-bg" style="height:100%">
	<div class="wrapper wrapper-content" style="height:100%">
		<div class="row" style="height:25%">
			<div class="col-sm-3" style="height:100%">
				<div class="ibox float-e-margins" style="height:80%">
					<div class="ibox-title" style="height:40%">
						<h5>收入</h5>
					</div>
					<div class="ibox-content" style="height:60%">
						<h1 class="no-margins"><font style="font-family:'华文细黑';">${pd.TotalIncome}</font></h1>
					</div>
				</div>
			</div>
			<div class="col-sm-3" style="height:100%">
				<div class="ibox float-e-margins" style="height:80%">
					<div class="ibox-title" style="height:40%">
						<h5>本月收入</h5>
					</div>
					<div class="ibox-content" style="height:60%">
						<h1 class="no-margins"><font style="font-family:'华文细黑';">${pd.TotalMonthlyIncome}</font></h1>
					</div>
				</div>
			</div>
			<div class="col-sm-3" style="height:100%">
				<div class="ibox float-e-margins" style="height:80%">
					<div class="ibox-title" style="height:40%">
						<h5>本日收入</h5>
					</div>
					<div class="ibox-content" style="height:60%">
						<h1 class="no-margins"><font style="font-weight:100;font-size:100%;font-family:'华文细黑';">${pd.TotalDailyIncome}</font></h1>
					</div>
				</div>
			</div>
			<div class="col-sm-3" style="height:100%">
				<div class="ibox float-e-margins" style="height:80%">
					<div class="ibox-title" style="height:40%">
						<h5>本日订单</h5>
					</div>
					<div class="ibox-content" style="height:60%">
						<h1 class="no-margins"><font style="font-weight:100;font-size:100%;font-family:'华文细黑';">${pd.TotalDailyOrder}</font></h1>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="height:50%">
			<div class="col-sm-12" style="height:100%">
				<div class="ibox float-e-margins" style="height:100%">
					<div class="ibox-title" style="height:12%">
						<h5>订单（年）</h5>
						<div class="pull-right"></div>
					</div>
					<div class="ibox-content" style="height:88%">
						<div class="row" style="height:100%">
							<div class="col-sm-10" style="height:100%">
								<div class="flot-chart" style="height:100%">
									<div class="flot-chart-content" id="flot-dashboard-chart" style="height:100%"></div>
								</div>
							</div>
							<div class="col-sm-2" style="height:100%">
								<ul class="stat-list" style="height:80%; margin-top: 8%;">
									<li>
										<h2 class="no-margins">${pd.TotalOrder }</h2> <big>订单总数</big>
										<div class="stat-percent">
											&nbsp;
										</div>
										<div class="progress-mini">
											&nbsp;
										</div>
									</li>
									<li>
										<h2 class="no-margins">${pd.OneMonthOrder }</h2> <big>最近一个月订单</big>
										<div class="stat-percent">
											&nbsp;
										</div>
										<div class="progress-mini">
											&nbsp;
										</div>
									</li>
									<li>
										<h2 class="no-margins">${pd.OneMonthMoney }</h2> <big>最近一个月付款额</big>
										<div class="stat-percent">
											&nbsp;
										</div>
										<div class="progress-mini">
											&nbsp;
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="row" style="height:25%">
			<div class="col-sm-3" style="height:100%">
				<div class="ibox float-e-margins" style="height:80%;margin-top: 13%;">
					<div class="ibox-title" style="height:40%">
						<h5>总用户</h5>
					</div>
					<div class="ibox-content"  style="height:60%">
						<div>
							<h1 class="no-margins"><font style="font-family:'华文细黑';">${pd.TotalUser}</font></h1>
							<small>&nbsp;</small>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-3" style="height:100%">
				<div class="ibox float-e-margins" style="height:80%;margin-top: 13%;">
					<div class="ibox-title" style="height:40%">
						<h5>注册新用户</h5>
					</div>
					<div class="ibox-content"  style="height:60%">
						<div id="sparkline_newRegUser" style="height:60%;margin-top: -20px;">
							<canvas width="100%" height="5%" style="display: inline-block; width: 100%; height: 5%; vertical-align: middle;"></canvas>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-3" style="height:100%">
				<div class="ibox float-e-margins" style="height:80%;margin-top: 13%;">
					<div class="ibox-title" style="height:40%">
						<h5>运动用户(绑定手环)</h5>
					</div>
					<div class="ibox-content"  style="height:60%">
						<div id="sparkline_sportUser" style="margin-top: -20px;">
							<canvas width="100%" height="55" style="display: inline-block; width: 100%; height: 55px; vertical-align: top;"></canvas>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-3" style="height:100%">
				<div class="ibox float-e-margins" style="height:80%;margin-top: 13%;">
					<div class="ibox-title" style="height:40%">
						<h5>就医宝用户(下单用户)</h5>
					</div>
					<div class="ibox-content"  style="height:60%;">
						<div id="sparkline_JiuYiBaoUser" style="margin-top: -20px;">
							<canvas width="100%" height="55" style="display: inline-block; width: 100%; height: 55px; vertical-align: top;"></canvas>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 全局js -->
	<system:jsFooter />
	<script type="text/javascript">
		$(document).ready(function() {
			//注册新用户
			$.ajax({
				type: "POST",
				url: '<%=basePath%>operation/main/getSixMonthNewRegUser?tm=' +  new Date().getTime(),
				dataType: 'json',
				async: false,
				cache: false,
				success: function(data) {
					if(null != data && data.length > 0){
						var array_datas = new Array(data.length);
						for(var i_tmp = 0; i_tmp < data.length; i_tmp++){
							array_datas[i_tmp] = data[i_tmp].monthNewRegUser;
						}
						$("#sparkline_newRegUser").sparkline(array_datas, {
							type : "line",
							width : "100%",
							height : "55",
							lineColor : "#1ab394",
							fillColor : "#ffffff"
						});
					}
				}
			});
			//运动用户
			$.ajax({
				type: "POST",
				url: '<%=basePath%>operation/main/getSixMonthSportUser?tm=' +  new Date().getTime(),
				dataType: 'json',
				async: false,
				cache: false,
				success: function(data) {
					if(null != data && data.length > 0){
						var array_datas = new Array(data.length);
						for(var i_tmp = 0; i_tmp < data.length; i_tmp++){
							array_datas[i_tmp] = data[i_tmp].monthSportUser;
						}
						$("#sparkline_sportUser").sparkline(array_datas, {
							type : "line",
							width : "100%",
							height : "55",
							lineColor : "#1ab394",
							fillColor : "#ffffff"
						});
					}
				}
			});
			//就医宝用户
			$.ajax({
				type: "POST",
				url: '<%=basePath%>operation/main/getSixMonthJiuYiBaoUser?tm=' +  new Date().getTime(),
				dataType: 'json',
				async: false,
				cache: false,
				success: function(data) {
					if(null != data && data.length > 0){
						var array_datas = new Array(data.length);
						for(var i_tmp = 0; i_tmp < data.length; i_tmp++){
							array_datas[i_tmp] = data[i_tmp].monthJiuYiBaoUser;
						}
						$("#sparkline_JiuYiBaoUser").sparkline(array_datas, {
							type : "line",
							width : "100%",
							height : "55",
							lineColor : "#ed5565",
							fillColor : "#ffffff"
						});
					}
				}
			});
			//获取订单数
			function getOrderData(){
				var res;
				$.ajax({
					type: "POST",
					url: '<%=basePath%>operation/main/getOneYearOrderForMonth?tm=' +  new Date().getTime(),
					async: false,
					dataType: 'json',
					cache: false,
					success: function(data) {
						if(null != data && data.length > 0){
							var array_datas = new Array(data.length);
							for(var i_tmp = 0; i_tmp < data.length; i_tmp++){
								var array_item = new Array(2);
								array_item[0] = gd(data[i_tmp].date_year, data[i_tmp].date_month, 1);
								array_item[1] = data[i_tmp].monthOrder;
								array_datas[i_tmp] = array_item;
							}
							res = array_datas;
						}
					}
				});
				return res;
			}
			//获取付款额
			function getMoneyData(){
				var res;
				$.ajax({
					type: "POST",
					url: '<%=basePath%>operation/main/getOneYearMoneyForMonth?tm=' +  new Date().getTime(),
					async: false,
					dataType: 'json',
					cache: false,
					success: function(data) {
						if(null != data && data.length > 0){
							var array_datas = new Array(data.length);
							for(var i_tmp = 0; i_tmp < data.length; i_tmp++){
								var array_item = new Array(2);
								array_item[0] = gd(data[i_tmp].date_year, data[i_tmp].date_month, 1);
								array_item[1] = data[i_tmp].monthMoney;
								array_datas[i_tmp] = array_item;
							}
							res = array_datas;
						}
					}
				});
				return res;
			}
			var dataset = [ {
				label : "订单数",
				data : getOrderData(),
				color : "#1ab394",
				bars : {
					show : true,
					align : "center",
					barWidth : 24 * 60 * 60 * 600 * 30,
					lineWidth : 0
				}
			}, {
				label : "付款数",
				data : getMoneyData(),
				yaxis : 2,
				color : "#464f88",
				lines : {
					lineWidth : 1,
					show : true,
					fill : true,
					fillColor : {
						colors : [ {
							opacity : 0.2
						}, {
							opacity : 0.2
						} ]
					}
				},
				splines : {
					show : false,
					tension : 0.6,
					lineWidth : 1,
					fill : 0.1
				}
			} ];
			var options = {
				xaxis : {
					mode : "time",
					tickSize : [ 1, "month" ],
					tickLength : 0,
					axisLabel : "Date",
					axisLabelUseCanvas : true,
					axisLabelFontSizePixels : 12,
					axisLabelFontFamily : "Arial",
					axisLabelPadding : 10,
					color : "#838383"
				},
				yaxes : [{
					position : "left",
					//max : 100,
					color : "#838383",
					axisLabelUseCanvas : true,
					axisLabelFontSizePixels : 12,
					axisLabelFontFamily : "Arial",
					axisLabelPadding : 3
				}, {
					position : "right",
					clolor : "#838383",
					axisLabelUseCanvas : true,
					axisLabelFontSizePixels : 12,
					axisLabelFontFamily : " Arial",
					axisLabelPadding : 67
				}],
				legend : {
					noColumns : 1,
					labelBoxBorderColor : "#000000",
					position : "nw"
				},
				grid : {
					hoverable : true,
					clickable : true,
					borderWidth : 0,
					color : "#838383"
				},
				tooltip : {
					show : true
				},
	            tooltipOpts: {
	            	//content: "%s %x：%y",
	            	content: "%s：%y",
	            	//xDateFormat: "%y-%m",
	                onHover: function () {}
	            }
			};
			function gd(year, month, day) {
				return new Date(year, month - 1, day).getTime()
			}
			var previousPoint = null, previousLabel = null;
			$.plot($("#flot-dashboard-chart"), dataset, options);
			var mapData = {
				"US" : 298,
				"SA" : 200,
				"DE" : 220,
				"FR" : 540,
				"CN" : 120,
				"AU" : 760,
				"BR" : 550,
				"IN" : 200,
				"GB" : 120,
			};
			$("#world-map").vectorMap({
				map : "world_mill_en",
				backgroundColor : "transparent",
				regionStyle : {
					initial : {
						fill : "#e4e4e4",
						"fill-opacity" : 0.9,
						stroke : "none",
						"stroke-width" : 0,
						"stroke-opacity" : 0
					}
				},
				series : {
					regions : [{
						values : mapData,
						scale : [ "#1ab394", "#22d6b1" ],
						normalizeFunction : "polynomial"
					}]
				}
			})
		});
	</script>
</body>
</html>