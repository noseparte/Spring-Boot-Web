<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>
<script type="text/javascript">
	var jsessionid = "<%=session.getId()%>";
</script>

</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>二维码</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
								<div class="col-sm-10">
									<input type="text" class="form-control" id="encoderContent"
										title="输入内容" value="<%=basePath %>"
										style="width: 600px;">
								</div>
								<div class="col-sm-2">
									<a class="btn btn-default btn-primary" onclick="createTwoD();">生成二维码</a>
								</div>
							</div>
						</div>
						<div style="width: 900px; padding-left: 300px;">
							<div>
								<h5>生成二维码</h5>
							</div>
							<div>
								<img id="encoderImgId" cache="false"
									src="static/img/default.png" width="265px"
									height="265px;" />
							</div>
						</div>
						<div class="step-content row-fluid position-relative">
							<input type="hidden" value="no" id="hasTp1" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<system:jsFooter/>
	<!--引入属于此页面的js -->
	<script type="text/javascript">
	//生成二维码
	function createTwoD(){
		if($("#encoderContent").val()==""){
			$("#encoderContent").tips({
				side:3,
	            msg:'输入内容',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#encoderContent").focus();
			return false;
		}
		$("#encoderImgId").attr("src","static/images/jzx.gif");
		$.ajax({
			type: "POST",
			url: 'tool/createTwoDimensionCode.do',
	    	data: {encoderContent:$("#encoderContent").val(),tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 
				 if("success" == data.result){
					 $("#encoderContent").tips({
							side:1,
				            msg:'生成成功',
				            bg:'#75C117',
				            time:3
				     });
					 $("#encoderImgId").attr("src",'uploadFiles/twoDimensionCode/' + data.encoderImgId);       
				 }else{
					 $("#encoderContent").tips({
							side:3,
				            msg:'生成失败,后台有误',
				            bg:'#FF5080',
				            time:10
				     });
					 $("#encoderImgId").attr("src","uploadFiles/twoDimensionCode/default.png");
								return;
							}

						}
					});

		}
	</script>
</body>
</html>

