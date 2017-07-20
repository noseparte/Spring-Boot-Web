<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header />
<!-- jsp文件头和头部 -->
<style type="text/css">
body {
	margin: 20px;
}
</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-8">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>好友圈（发贴数、转发数年统计）</h5>
						<div class="pull-right"></div>
					</div>
					<div class="ibox-content">
						<div class="row">
							<div class="col-sm-12">
								<div class="flot-chart">
									<div class="flot-chart-content" id="flot-dashboard-chart"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>转发平台统计</h5>
						<div class="pull-right"></div>
					</div>
					<div class="ibox-content">
						<div class="row">
							<div class="col-sm-12">
								<div class="flot-chart">
									<div class="flot-chart-content" id="flot-pie-chart"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-6">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>团体参与活动统计</h5>
						<div class="pull-right"></div>
					</div>
					<div class="ibox-content">
						<div class="row">
							<div class="col-sm-12">
								<div class="flot-chart">
									<div class="flot-chart-content" id="flot-dashboard-chart2"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>个人参与活动统计</h5>
						<div class="pull-right"></div>
					</div>
					<div class="ibox-content">
						<div class="row">
							<div class="col-sm-12">
								<div class="flot-chart">
									<div class="flot-chart-content" id="flot-dashboard-chart21"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- <div class="col-sm-4">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>团体、个人参与活动排名</h5>
						<div class="pull-right"></div>
					</div>
					<div class="ibox-content">
						<div class="row">
							<div class="col-sm-12">
								<div class="flot-chart">
									<div class="flot-chart-content" id="flot-dashboard-chart3"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div> -->
		</div>
		<div class="row">
			<div class="col-sm-4">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>运动用户(绑定手环)</h5>
					</div>
					<div class="ibox-content">
						<div id="sparkline_sportUser">
							<canvas width="100%" height="55" style="display: inline-block; width: 100%; height: 55px; vertical-align: top;"></canvas>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-8">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>用户年龄段分布</h5>
						<div class="pull-right"></div>
					</div>
					<div class="ibox-content">
						<div class="row">
							<div class="col-sm-12">
								<div class="flot-chart">
									<div class="flot-chart-content" id="flot-dashboard-chart4"></div>
								</div>
							</div>
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
			var previousPoint = null, previousLabel = null;
			//运动用户
			$.ajax({
				type: "POST",
				url: '<%=basePath%>operation/main/getSixMonthSportUser?tm=' +  new Date().getTime(),
				async: false,
				dataType: 'json',
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
							height : "200",
							lineColor : "#1ab394",
							fillColor : "#ffffff"
						});
					}
				}
			});
			//获取发贴数
			function getPostsData(){
				var res;
				$.ajax({
					type: "POST",
					url: '<%=basePath%>operation/main/getOneYearPostsForMonth?tm=' +  new Date().getTime(),
					async: false,
					dataType: 'json',
					cache: false,
					success: function(data) {
						if(null != data && data.length > 0){
							var array_datas = new Array(data.length);
							for(var i_tmp = 0; i_tmp < data.length; i_tmp++){
								var array_item = new Array(2);
								array_item[0] = gd(data[i_tmp].date_year, data[i_tmp].date_month, 1);
								array_item[1] = data[i_tmp].monthPosts;
								array_datas[i_tmp] = array_item;
							}
							res = array_datas;
						}
					}
				});
				return res;
			}
			//获取转发数
			function getForwardData(){
				var res;
				$.ajax({
					type: "POST",
					url: '<%=basePath%>operation/main/getOneYearForwardForMonth?tm=' +  new Date().getTime(),
					async: false,
					dataType: 'json',
					cache: false,
					success: function(data) {
						if(null != data && data.length > 0){
							var array_datas = new Array(data.length);
							for(var i_tmp = 0; i_tmp < data.length; i_tmp++){
								var array_item = new Array(2);
								array_item[0] = gd(data[i_tmp].date_year, data[i_tmp].date_month, 1);
								array_item[1] = data[i_tmp].monthForward;
								array_datas[i_tmp] = array_item;
							}
							res = array_datas;
						}
					}
				});
				return res;
			}
			//获取转发平台
			function getForwardSysData(){
				var res;
				$.ajax({
					type: "POST",
					url: '<%=basePath%>operation/main/getOneYearForwardSys?tm=' +  new Date().getTime(),
					async: false,
					dataType: 'json',
					cache: false,
					success: function(data) {
						var array_datas = new Array(4);
						if(null != data && data.length > 0){
							var forwardType;
							for(var i_tmp = 0; i_tmp < data.length; i_tmp++){
								forwardType = data[i_tmp].FORWARD_TYPE;
								if(forwardType == 1){
									array_datas[0] = data[i_tmp].monthForwardSys;
								}else if(forwardType == 2){
									array_datas[1] = data[i_tmp].monthForwardSys;
								}else if(forwardType == 3){
									array_datas[2] = data[i_tmp].monthForwardSys;
								}else if(forwardType == 4){
									array_datas[3] = data[i_tmp].monthForwardSys;
								}
							}
						}else{
							array_datas[0] = 0;
							array_datas[1] = 0;
							array_datas[2] = 0;
							array_datas[3] = 0;
						}
						res = array_datas;
					}
				});
				return res;
			}
			//获取团体活动数量
			function getGroupActiveData(){
				var res;
				$.ajax({
					type: "POST",
					url: '<%=basePath%>operation/main/getOneYearGroupActiveForMonth?tm=' +  new Date().getTime(),
					async: false,
					dataType: 'json',
					cache: false,
					success: function(data) {
						if(null != data && data.length > 0){
							var array_datas = new Array(data.length);
							for(var i_tmp = 0; i_tmp < data.length; i_tmp++){
								var array_item = new Array(2);
								array_item[0] = gd(data[i_tmp].date_year, data[i_tmp].date_month, 1);
								array_item[1] = data[i_tmp].monthGroupActive;
								array_datas[i_tmp] = array_item;
							}
							res = array_datas;
						}
					}
				});
				return res;
			}
			//获取个人活动数量
			function getPersonActiveData(){
				var res;
				$.ajax({
					type: "POST",
					url: '<%=basePath%>operation/main/getOneYearPersonActiveForMonth?tm=' +  new Date().getTime(),
					async: false,
					dataType: 'json',
					cache: false,
					success: function(data) {
						if(null != data && data.length > 0){
							var array_datas = new Array(data.length);
							for(var i_tmp = 0; i_tmp < data.length; i_tmp++){
								var array_item = new Array(2);
								array_item[0] = gd(data[i_tmp].date_year, data[i_tmp].date_month, 1);
								array_item[1] = data[i_tmp].monthPersonActive;
								array_datas[i_tmp] = array_item;
							}
							res = array_datas;
						}
					}
				});
				return res;
			}
			//获取团体活动参与人数
			function getGroupActiveUsersData(){
				var res;
				$.ajax({
					type: "POST",
					url: '<%=basePath%>operation/main/getOneYearGroupActiveUsersForMonth?tm=' +  new Date().getTime(),
					async: false,
					dataType: 'json',
					cache: false,
					success: function(data) {
						if(null != data && data.length > 0){
							var array_datas = new Array(data.length);
							for(var i_tmp = 0; i_tmp < data.length; i_tmp++){
								var array_item = new Array(2);
								array_item[0] = gd(data[i_tmp].date_year, data[i_tmp].date_month, 1);
								array_item[1] = data[i_tmp].monthGroupActiveUser;
								array_datas[i_tmp] = array_item;
							}
							res = array_datas;
						}
					}
				});
				return res;
			}
			//获取个人活动参数人数数量
			function getPersonActiveUsersData(){
				var res;
				$.ajax({
					type: "POST",
					url: '<%=basePath%>operation/main/getOneYearPersonActiveUsersForMonth?tm=' +  new Date().getTime(),
					async: false,
					dataType: 'json',
					cache: false,
					success: function(data) {
						if(null != data && data.length > 0){
							var array_datas = new Array(data.length);
							for(var i_tmp = 0; i_tmp < data.length; i_tmp++){
								var array_item = new Array(2);
								array_item[0] = gd(data[i_tmp].date_year, data[i_tmp].date_month, 1);
								array_item[1] = data[i_tmp].monthPersonActiveUser;
								array_datas[i_tmp] = array_item;
							}
							res = array_datas;
						}
					}
				});
				return res;
			}
			//获取所有就医宝用户年龄段分布
			function getJiuYiBaoUserAgesData(){
				var res;
				$.ajax({
					type: "POST",
					url: '<%=basePath%>operation/main/getJiuYiBaoUserAges?tm=' +  new Date().getTime(),
					async: false,
					dataType: 'json',
					cache: false,
					success: function(data) {
						if(null != data && data.length > 0){
							var array_datas = new Array(data.length);
							for(var i_tmp = 0; i_tmp < data.length; i_tmp++){
								var array_item = new Array(2);
								array_item[0] = data[i_tmp].ages;
								array_item[1] = data[i_tmp].ageSize;
								array_datas[i_tmp] = array_item;
							}
							res = array_datas;
						}
					}
				});
				return res;
			}
			function gd(year, month, day) {
				return new Date(year, month - 1, day).getTime()
			}
			//
			$.plot($("#flot-dashboard-chart"), [{
				label : "发贴数",
				data : getPostsData(),
				color : "#1ab394",
				bars : {
					show : true,
					align : "center",
					barWidth : 24 * 60 * 60 * 600 * 30,
					lineWidth : 0
				}
			}, {
				label : "转发数",
				data : getForwardData(),
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
			}], {
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
			});
			//
			var forwardSysData = getForwardSysData();
			$.plot($("#flot-pie-chart"), [{
	            label: "朋友圈",
	            data: forwardSysData[0],
	            color: "#d3d3d3"
	        }, {
	            label: "微信好友",
	            data: forwardSysData[1],
	            color: "#bababa"
	        }, {
	            label: "qq空间",
	            data: forwardSysData[2],
	            color: "#79d2c0"
	        }, {
	            label: "微博",
	            data: forwardSysData[3],
	            color: "#1ab394"
	        }], {
	            series: {
	                pie: {
	                    show: true
	                }
	            },
	            grid: {
	                hoverable: true
	            },
	            tooltip: true,
	            tooltipOpts: {
	                content: "%p.0%, %s",
	                shifts: {
	                    x: 20,
	                    y: 0
	                },
	                defaultTheme: false
	            }
	        });
			
			/* $.plot($("#flot-dashboard-chart2"), [{
				label : "团体活动",
				//label : "活动数",
				data : getGroupActiveData(),
				color : "#1ab394",
				bars : {
					show : true,
					align : "center",
					barWidth : 12 * 60 * 60 * 600 * 30,
					lineWidth : 0
				}
			}, {
				label : "团体参与数量",
				//label : "参与人员数",
				data : getGroupActiveUsersData(),
				color : "#464f88",
				bars : {
					show : true,
					align : "center",
					barWidth : 12 * 60 * 60 * 600 * 30,
					lineWidth : 0
				}
			}, {
				label : "个人活动",
				data : getPersonActiveData(),
				yaxis : 2,
				color : "#1ab394",
				lines : {
					lineWidth : 1,
					show : true,
					fill : false,
					fillColor : {
						colors : [ {
							opacity : 0.9
						}, {
							opacity : 0.9
						} ]
					}
				},
				splines : {
					show : false,
					tension : 0.6,
					lineWidth : 1,
					fill : 0.1
				}
			}, {
				label : "个人参与数量",
				data : getPersonActiveUsersData(),
				yaxis : 2,
				color : "#464f88",
				lines : {
					lineWidth : 1,
					show : true,
					fill : false,
					fillColor : {
						colors : [ {
							opacity : 0.9
						}, {
							opacity : 0.9
						} ]
					}
				},
				splines : {
					show : false,
					tension : 0.6,
					lineWidth : 1,
					fill : 0.1
				}
			}], {
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
					noColumns : 4,
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
			}); */
			
			$.plot($("#flot-dashboard-chart2"), [{
				//label : "团体活动",
				label : "活动数",
				data : getGroupActiveData(),
				color : "#1ab394",
				bars : {
					show : true,
					align : "center",
					barWidth : 12 * 60 * 60 * 600 * 30,
					lineWidth : 0
				}
			}, {
				//label : "团体参与数量",
				label : "参与人员数",
				yaxis : 2,
				data : getGroupActiveUsersData(),
				color : "#464f88",
				lines : {
					lineWidth : 1,
					show : true,
					fill : false,
					fillColor : {
						colors : [ {
							opacity : 0.9
						}, {
							opacity : 0.9
						} ]
					}
				},
				splines : {
					show : false,
					tension : 0.6,
					lineWidth : 1,
					fill : 0.1
				}
			}], {
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
					axisLabelPadding : 3,
					tickDecimals : 0
					/*tickFormatter: function (val, axis) {                    
		                return val.toFixed(axis.tickDecimals); 
		            }*/
				}, {
					position : "right",
					clolor : "#838383",
					axisLabelUseCanvas : true,
					axisLabelFontSizePixels : 12,
					axisLabelFontFamily : " Arial",
					axisLabelPadding : 67,
					tickDecimals : 0
					/*tickFormatter: function (val, axis) {                    
		                return val.toFixed(axis.tickDecimals); 
		            }*/
				}],
				legend : {
					noColumns : 4,
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
			});
			
			$.plot($("#flot-dashboard-chart21"), [{
				//label : "个人活动",
				label : "活动数",
				data : getPersonActiveData(),
				color : "#1ab394",
				bars : {
					show : true,
					align : "center",
					barWidth : 12 * 60 * 60 * 600 * 30,
					lineWidth : 0
				}
			}, {
				//label : "个人参与数量",
				label : "参与人员数",
				data : getPersonActiveUsersData(),
				yaxis : 2,
				color : "#464f88",
				lines : {
					lineWidth : 1,
					show : true,
					fill : false,
					fillColor : {
						colors : [ {
							opacity : 0.9
						}, {
							opacity : 0.9
						} ]
					}
				},
				splines : {
					show : false,
					tension : 0.6,
					lineWidth : 1,
					fill : 0.1
				}
			}], {
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
					axisLabelPadding : 3,
					tickDecimals : 0
				}, {
					position : "right",
					clolor : "#838383",
					axisLabelUseCanvas : true,
					axisLabelFontSizePixels : 12,
					axisLabelFontFamily : " Arial",
					axisLabelPadding : 67,
					tickDecimals : 0
				}],
				legend : {
					noColumns : 4,
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
			});
			
			$.plot($("#flot-dashboard-chart4"), [{
				label : "年龄段",
				data : getJiuYiBaoUserAgesData(),
				color : "#1ab394",
				/*bars : {
					show : true,
					align : "center",
					barWidth : 12 * 60 * 60 * 600 * 30,
					lineWidth : 0
				}*/
				lines : {
					lineWidth : 1,
					show : true,
					fill : false,
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
			}], {
				xaxis : {
					tickSize : [ 10 ],
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
			});
			/*$.plot($("#flot-dashboard-chart3"), dataset, options);*/
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