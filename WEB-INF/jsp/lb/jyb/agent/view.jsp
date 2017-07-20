<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>
<!-- jsp文件头和头部 -->

</head>
<style>
.col-sm-4{margin-top: 7px !important;}
</style>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>代理商信息：${pd.SP_NAME}</h5>
					</div>
					<div class="ibox-content">
						<form id="GuideForm" name="GuideForm" class="form-horizontal" method="post">
							<div class="form-group">
								<%-- <label class="col-sm-2 control-label">公司名称：</label>
							    <div class="col-sm-4">
									${pd.SP_NAME}
								</div> --%>
								<label class="col-sm-2 control-label">服务范围：</label>
							    <div class="col-sm-4">
							    <c:if test="${pd.SP_REGISTER_ADDR == 'country' }">
							    	全国
							    </c:if>
									${pd.CAA_NAME}
								</div>
								<label class="col-sm-2 control-label">注册时间：</label>
							    <div class="col-sm-4">
									${pd.SP_REGITER_TIME}
								</div>
								
							</div>
							<div class="form-group">
								
								<label class="col-sm-2 control-label">负责人：</label>
							    <div class="col-sm-4">
									${pd.SP_LEGAL_PERSON}
								</div>
								<label class="col-sm-2 control-label">联系方式：</label>
							    <div class="col-sm-4">
									${pd.SP_PHONE}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">星级：</label>
							    <div class="col-sm-1">
									<div style="width: 100px;height: 30px;margin-top: -4px;margin: auto;">
        								<img src="images/wx_pj02.png" width="100%" height="30px;"/>
        								<div id="evaluation" style=""></div>
      								</div>
								</div>
								<div class="col-sm-3"></div>
								<label class="col-sm-2 control-label">业务范围：</label>
							    <div class="col-sm-4">
									${pd.SP_SERVICE_RANGE}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">营业执照扫描件地址：</label>
							    <div class="col-sm-4">
							    	<input type="hidden" id="SP_LICENCE" name="SP_LICENCE" value="${pd.SP_LICENCE }">
									<button id="SP_LICENCEBTN" class="btn btn-white" type="button" onclick="goLicense();">查看详情</button>
								</div>
								<label class="col-sm-2 control-label">合同电子版地址：</label>
							    <div class="col-sm-4">
							    	<input type="hidden" id="SP_CONTRACT" name="SP_CONTRACT" value="${pd.SP_CONTRACT }">
									<button id="SP_CONTRACTBTN" class="btn btn-white" type="button" onclick="goContract();">查看详情</button>
								</div>
							</div>
							<div class="form-group">
								<c:if test="${pd.REJECT_REASON != null && pd.REJECT_REASON  != ''}">
									<label class="col-sm-2 control-label">退回原因：</label>
								    <div class="col-sm-4">
										${pd.REJECT_REASON }
										<!-- <button id="REASON" class="btn btn-white" type="button" onclick="goREASON();">查看详情</button> -->
									</div>
								</c:if>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 全局js -->
    <system:jsFooter/>
	<!-- 自定义js -->
	<script type="text/javascript">
		var SP_LICENCE = $("#SP_LICENCE").val();
		var SP_CONTRACT = $("#SP_CONTRACT").val();
		var REJECT_REASON = $("#REJECT_REASON").val();
		function goLicense(){
			layer.open({
			    type: 2,
			    title: '营业执照扫描件',//窗体标题
			    area: ['500px', '400px'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: false,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["agent/toPicView?ID=" + SP_LICENCE , "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1, //不显示关闭按钮
			    btn:['关闭']
			})
		}
		function goContract(){
			layer.open({
			    type: 2,
			    title: '合同电子版',//窗体标题
			    area: ['500px', '400px'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: false,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["agent/toPicView?ID=" + SP_CONTRACT , "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1, //不显示关闭按钮
			    btn:['关闭']
			})
		}
		function goREASON(){
			layer.open({
			    type: 2,
			    title: '代理商退单原因',//窗体标题
			    area: ['300px', '300px'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: false,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["agent/toResonView?REJECT_REASON=" + REJECT_REASON , "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1, //不显示关闭按钮
			    btn:['关闭']
			})
		}
		
		//设置星级
		$(document).ready(function (){
			var SP_STAR_LEVEL = "${pd.SP_STAR_LEVEL}"/5*100+"%";
			style="width:"+SP_STAR_LEVEL+";height: 20px;background:#fc8627;margin-top: -27px;";
			$("#evaluation").attr("style", style);
		}); 
	</script>
</body>
</html>