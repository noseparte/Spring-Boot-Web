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
					<div class="ibox-content">
						<form id="ArticleHealthForm" name="ArticleHealthForm" class="form-horizontal" method="post">
							<div class="form-group">
								<label class="col-sm-2 control-label">订单编号：</label>
							    <div class="col-sm-4">
									${data.rows[0].onum}
								</div>
								<label class="col-sm-2 control-label">下单时间：</label>
							    <div class="col-sm-4">
									${data.rows[0].otime}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">订单类型：</label>
							    <div class="col-sm-4">
									${data.rows[0].otype}
								</div>
								<label class="col-sm-2 control-label">订单状态：</label>
							    <div class="col-sm-4">
									${data.rows[0].ostatus}
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">注意事项：</label>
							    <div class="col-sm-10">
									${data.rows[0].ocontent} 
								</div>
							</div>
							<div class="form-group" style="text-align:center;">
								<c:if test="${pd.spinfoOID eq 'null'}">
									<input type="button" class="btn btn-default btn-primary" disabled value="代理商"></input>
								</c:if>
								<c:if test="${pd.spinfoOID ne 'null'}">
									<input type="button" class="btn btn-default btn-primary" onclick="spDesc('${pd.spinfoOID }');" value="代理商"></input>
								</c:if>
								<c:if test="${pd.expertlibsOID eq 'null'}">
									<input type="button" class="btn btn-default btn-primary" disabled value="专家库"></input>
								</c:if>
								<c:if test="${pd.expertlibsOID ne 'null'}">
									<input type="button" class="btn btn-default btn-primary" onclick="expertLibsDesc('${pd.expertlibsOID }');" value="专家库"></input>
								</c:if>
								<c:if test="${pd.accompanyinfoOID eq 'null'}">
									<input type="button" class="btn btn-default btn-primary" disabled value="陪诊人员"></input>
								</c:if>
								<c:if test="${pd.accompanyinfoOID ne 'null'}">
									<input type="button" class="btn btn-default btn-primary" onclick="accompanyDesc('${pd.accompanyinfoOID }');" value="陪诊人员"></input>
								</c:if>
								<c:if test="${pd.keynodeOID eq 'null'}">
									<input type="button" class="btn btn-default btn-primary" disabled value="就诊过程"></input>
								</c:if>
								<c:if test="${pd.keynodeOID ne 'null'}">
									<input type="button" class="btn btn-default btn-primary" onclick="keyNodeDesc('${data.rows[0].oid }');" value="就诊过程"></input>
								</c:if>
								<c:if test="${pd.evaluateOID eq 'null'}">
									<input type="button" class="btn btn-default btn-primary" disabled value="评价"></input>
								</c:if>
								<c:if test="${pd.evaluateOID ne 'null'}">
									<input type="button" class="btn btn-default btn-primary" onclick="orderEvalDesc('${pd.evaluateOID }');" value="评价"></input>
								</c:if>
							</div>
							<div class="hr-line-dashed"></div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="myModal" class="modal inmodal fade" tabindex="-1" role="dialog"  aria-hidden="true"></div>
	<!-- 全局js -->
	<system:jsFooter/>
	<script type="text/javascript">
		//浏览专家
		function expertLibsDesc(expertlibsOID){
			if(expertlibsOID != null && expertlibsOID != ""){
				layer.full(
					layer.open({
						type: 2,
						title: '专家浏览',//窗体标题
						area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
						fix: false,//窗体位置不固定
						maxmin: false,//最大、小化是否显示
						scrollbar: true,//整体页面滚动条是否显示
						content: ['/hospExpLib/toView?HEL_ID=' + expertlibsOID, 'yes'],//URL地址
						closeBtn: 1,//显示关闭按钮
						btn: ['关闭']
					})
				);
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
			/*layer.open({
			    type: 2,
			    title: '专家库信息',//窗体标题
			    area: ['30%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["operator/orderManagement/toLists_expertLibs?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});*/
		}
		//浏览代理商
		function spDesc(spinfoOID){
			if(spinfoOID != null && spinfoOID != ""){
				layer.full(layer.open({
					type: 2,
					title: '代理商浏览',//窗体标题
					area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/agent/toView?SP_ID=' + spinfoOID, 'yes'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				}));
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
			/*layer.open({
			    type: 2,
			    title: '代理商信息',//窗体标题
			    area: ['30%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["operator/orderManagement/toLists_sp?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});*/
		}
		//浏览陪诊
		function accompanyDesc(accompanyinfoOID){
			if(accompanyinfoOID != null && accompanyinfoOID != ""){
				layer.full(layer.open({
					type: 2,
					title: '陪诊浏览',//窗体标题
					area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/accompanyInfo/toView?AI_ID=' + accompanyinfoOID, 'yes'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				}));
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
			/*layer.open({
			    type: 2,
			    title: '陪诊人员信息',//窗体标题
			    area: ['30%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["operator/orderManagement/toLists_accompany?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});*/
		}
		//浏览就诊记录
		function keyNodeDesc(O_ID){
			layer.open({
			    type: 2,
			    title: '就诊过程记录',//窗体标题
			    area: ['80%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["operator/orderManagement/toLists_keyNode?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1, //不显示关闭按钮
			    btn: ['关闭']
			});
		}
		//浏览订单评价
		function orderEvalDesc(evaluateOID){
			if(evaluateOID != null && evaluateOID != ""){
				layer.open({
					type: 2,
					title: '订单评价详情',//窗体标题
					area: ['60%', '90%'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: false,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ['/evaluate/toView?EVA_ID=' + evaluateOID, 'yes'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				});
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
			/*layer.open({
			    type: 2,
			    title: '评价信息',//窗体标题
			    area: ['30%', '80%'],//整个窗体宽、高，单位：像素px
			    fix: false, //窗体位置不固定
			    maxmin: true,//最大、小化是否显示
			    scrollbar: false,//整个页面滚动条是否显示
 			    content: ["operator/orderManagement/toLists_eval?O_ID=" + O_ID, "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
			    closeBtn: 1 //不显示关闭按钮
			});*/
		}
	</script>
</body>
</html>