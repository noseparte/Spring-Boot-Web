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
						<h5>服务器接口测试</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
								<div class="col-sm-8">
									<input style="width: 500px" class="form-control" type="text"
										id="serverUrl" title="输入请求地址"
										value=""
										style="">

								</div>
								<div class="col-sm-4">
									<label><input id="form-field-radio1"
										name="form-field-radio1" onclick="setType('POST');"
										type="radio" checked="checked"><span>POST</span> </label> <label><input
										id="form-field-radio2" name="form-field-radio1"
										onclick="setType('GET');" type="radio"><span>GET</span>
									</label> <a class="btn btn-default btn-primary" onclick="sendSever();">请求</a>
									<a class="btn btn-default btn-primary" onclick="reset();">重置</a>
								</div>
							</div>
						</div>
						<div>
							<textarea id="json-field" title="返回结果"
								class="autosize-transition span12" style="width: 800px;">
							</textarea>
						</div>

						<div>
							<label style="float: left; padding-left: 35px;">服务器响应：<font
								color="red" id="stime">-</font>&nbsp;毫秒
							</label> <label style="float: left; padding-left: 35px;">客户端请求：<font
								color="red" id="ctime">-</font>&nbsp;毫秒
							</label>
						</div>
                        
						<input type="hidden" name="S_TYPE" id="S_TYPE" value="POST" />
					</div>
				</div>
				<!--/row-->

			</div>
			<!--/#page-content-->
		</div>
	</div>
	<!--/.fluid-container#main-container-->
	<!-- 返回顶部  -->
	<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse"> <i
		class="icon-double-angle-up icon-only"></i>
	</a>
	<system:jsFooter/>
	<script type="text/javascript">
		//请求类型
		function setType(value) {
			$("#S_TYPE").val(value);
		}

		//重置
		function reset() {
			$("#serverUrl").val('');
			$("#json-field").val('');
			$("#S_TYPE_S").val('');
		}
		
		function sendSever() {
			
			if ($("#serverUrl").val() == "") {
				$("#serverUrl").tips({
					side : 3,
					msg : '输入请求地址',
					bg : '#AE81FF',
					time : 2
				});
				$("#serverUrl").focus();
				return false;
			}

// 			var nowtime = date2str(new Date(), "yyyyMMdd");
			//alert($.md5(paraname+nowtime+',pegoe,'));
			var startTime = new Date().getTime(); //请求开始时间  毫秒
			$.ajax({
				type : "POST",
				url : 'tool/severTest',
				data : {
					serverUrl : $("#serverUrl").val(),
					requestMethod : $("#S_TYPE").val(),
					tm : new Date().getTime()
				},
				dataType : 'json',
				cache : false,
				success : function(data) {
					//$(top.pegoe());
					if ("success" == data.errInfo) {
						$("#serverUrl").tips({
							side : 1,
							msg : '服务器请求成功',
							bg : '#75C117',
							time : 3
						});
						var endTime = new Date().getTime(); //请求结束时间  毫秒 
						$("#ctime").text(endTime - startTime);

					} else {
						$("#serverUrl").tips({
							side : 3,
							msg : '请求失败,检查URL正误',
							bg : '#FF5080',
							time : 3
						});
						return;
					}

					$("#json-field").val(data.result);
					$("#json-field").tips({
						side : 2,
						msg : '返回结果',
						bg : '#75C117',
						time : 3
					});
					$("#stime").text(data.rTime);

				}
			});
		}

		function intfBox() {
			var intfB = document.getElementById("json-field");
			var intfBt = document.documentElement.clientHeight;
			intfB.style.height = (intfBt - 200) + 'px';
		}
		intfBox();
		window.onresize = function() {
			intfBox();
		};
	</script>
</body>
</html>

