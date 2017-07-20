<%@ page language="java" contentType="text/html; charset=UTF-8"
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
					<div class="ibox-title">
						<h5>
							医院专家对比合并&nbsp;&nbsp;
							<c:forEach var="item" items="${pd}" varStatus="i">
								<c:if test="${i.index == 0}">
									(${item.HEL_NAME}&nbsp;&nbsp;${item.HEL_SEX}&nbsp;&nbsp;${item.HD_ID})
								</c:if>
							</c:forEach>
						</h5>
					</div>
					<div class="ibox-content">
						<form id="HospitalExpertLibsMergeForm" name="HospitalExpertLibsMergeForm" class="form-horizontal" method="post">
							<%-- <div class="form-group">
								<label class="col-sm-2 control-label">专家姓名：</label>
								<c:forEach var="item" items="${pd}" varStatus="i">
									<c:if test="${i.index == 0}">
										<div class="col-sm-5">
											<input type="text" class="form-control required" readonly="readonly" name="HEL_NAME" id="HEL_NAME" value="${item.HEL_NAME}" />
										</div>
									</c:if>
									<c:if test="${i.index == 1}">
										<div class="col-sm-5">
											<input type="text" class="form-control required" readonly="readonly" value="${item.HEL_NAME}" />
										</div>
									</c:if>
								</c:forEach>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">性别：</label>
								<c:forEach var="item" items="${pd}" varStatus="i">
									<c:if test="${i.index == 0}">
										<div class="col-sm-5">
											<input type="text" class="form-control required" readonly="readonly" name="HEL_SEX" id="HEL_SEX" value="${item.HEL_SEX}" />
										</div>
									</c:if>
									<c:if test="${i.index == 1}">
										<div class="col-sm-5">
											<input type="text" class="form-control required" readonly="readonly" value="${item.HEL_SEX}" />
										</div>
									</c:if>
								</c:forEach>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">所属科室：</label>
								<c:forEach var="item" items="${pd}" varStatus="i">
									<c:if test="${i.index == 0}">
										<div class="col-sm-5">
											<input type="text" class="form-control required" readonly="readonly" name="HD_ID" id="HD_ID" value="${item.HD_ID}" />
										</div>
									</c:if>
									<c:if test="${i.index == 1}">
										<div class="col-sm-5">
											<input type="text" class="form-control required" readonly="readonly" value="${item.HD_ID}" />
										</div>
									</c:if>
								</c:forEach>
								<input type="text" id="T12_YEAR" name="T12_YEAR" class="bootstrapdatetimepicker form-control" placeholder="选择年份" style="width: 300px;" />
							</div> --%>
							<div class="form-group">
								<label class="col-sm-2 control-label">出生日期：</label>
								<c:forEach var="item" items="${pd}" varStatus="i">
									<c:if test="${i.index == 0}">
										<div class="col-sm-5">
											<input type="hidden" class="form-control required" name="HEL_ID" id="HEL_ID" value="${item.HEL_ID}" />
											<input type="text" class="bootstrapdatetimepicker form-control required" name="HEL_BIRTHDAY" id="HEL_BIRTHDAY" placeholder="选择出生日期" value="${item.HEL_BIRTHDAY}" />
										</div>
									</c:if>
									<c:if test="${i.index == 1}">
										<div class="col-sm-5">
											<input type="hidden" class="form-control required" name="HE_ID" id="HE_ID" value="${item.HEL_ID}" />
											<input type="text" class="bootstrapdatetimepicker form-control required" readonly="readonly" placeholder="选择出生日期" value="${item.HEL_BIRTHDAY}" />
										</div>
									</c:if>
								</c:forEach>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">所属医院：</label>
								<c:forEach var="item" items="${pd}" varStatus="i">
									<c:if test="${i.index == 0}">
										<div class="col-sm-5">
											<input type="text" class="form-control required" name="HE_HOSPITAL" id="HE_HOSPITAL" value="${item.HE_HOSPITAL}" />
										</div>
									</c:if>
									<c:if test="${i.index == 1}">
										<div class="col-sm-5">
											<input type="text" class="form-control required" readonly="readonly" value="${item.HE_HOSPITAL}" />
										</div>
									</c:if>
								</c:forEach>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">所属区域：</label>
								<c:forEach var="item" items="${pd}" varStatus="i">
									<c:if test="${i.index == 0}">
										<div class="col-sm-5">
											<select class="form-control required" name="HE_AREA" id="HE_AREA" value="${item.HE_AREA}"
						                         ajax--url="dic/getDicAreaForSelect" ajax--column="ID,TEXT">
											</select>
										</div>
									</c:if>
									<c:if test="${i.index == 1}">
										<div class="col-sm-5">
											<select class="form-control required" disabled="disabled" name="HE_AREA_Tmp" id="HE_AREA_Tmp" value="${item.HE_AREA}"
						                         ajax--url="dic/getDicAreaForSelect" ajax--column="ID,TEXT">
											</select>
										</div>
									</c:if>
								</c:forEach>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">职务：</label>
								<c:forEach var="item" items="${pd}" varStatus="i">
									<c:if test="${i.index == 0}">
										<div class="col-sm-5">
											<input type="text" class="form-control required" name="HEL_DUTY" id="HEL_DUTY" value="${item.HEL_DUTY}" />
										</div>
									</c:if>
									<c:if test="${i.index == 1}">
										<div class="col-sm-5">
											<input type="text" class="form-control required" readonly="readonly" value="${item.HEL_DUTY}" />
										</div>
									</c:if>
								</c:forEach>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">擅长专业：</label>
								<c:forEach var="item" items="${pd}" varStatus="i">
									<c:if test="${i.index == 0}">
										<div class="col-sm-5">
											<textarea rows="5" cols="4" class="form-control required" name="HEL_GOODPRO" id="HEL_GOODPRO">${item.HEL_GOODPRO}</textarea>
										</div>
									</c:if>
									<c:if test="${i.index == 1}">
										<div class="col-sm-5">
											<textarea rows="5" cols="4" class="form-control required" readonly="readonly">${item.HEL_GOODPRO}</textarea>
										</div>
									</c:if>
								</c:forEach>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">教育经历：</label>
								<c:forEach var="item" items="${pd}" varStatus="i">
									<c:if test="${i.index == 0}">
										<div class="col-sm-5">
											<textarea rows="5" cols="4" class="form-control required" name="HEL_EDU" id="HEL_EDU">${item.HEL_EDU}</textarea>
										</div>
									</c:if>
									<c:if test="${i.index == 1}">
										<div class="col-sm-5">
											<textarea rows="5" cols="4" class="form-control required" readonly="readonly">${item.HEL_EDU}</textarea>
										</div>
									</c:if>
								</c:forEach>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">相关荣誉：</label>
								<c:forEach var="item" items="${pd}" varStatus="i">
									<c:if test="${i.index == 0}">
										<div class="col-sm-5">
											<textarea rows="5" cols="4" class="form-control required" name="HEL_HONOR" id="HEL_HONOR">${item.HEL_HONOR}</textarea>
										</div>
									</c:if>
									<c:if test="${i.index == 1}">
										<div class="col-sm-5">
											<textarea rows="5" cols="4" class="form-control required" readonly="readonly">${item.HEL_HONOR}</textarea>
										</div>
									</c:if>
								</c:forEach>
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
		//表单ID
		var formId = "#HospitalExpertLibsMergeForm";
		$(document).ready(function(){
			//初始化下拉菜单
	    	$("#HE_AREA").createOption();
	    	$("#HE_AREA_Tmp").createOption();
	    	//表单提交JS验证
			$(formId).validate();
		});
		//父窗口触发表单提交
		function submitMergeData(){
			var id = $('#HEL_ID').val();
	    	var action = "";
	    	if(id != ""){
	    		action = "hospExpLib/saveMergeEdit";
	    	}
	    	$.ajax({
				type: "POST",
				url: action,
				async: false,
				data: $(formId).serialize(),
				success: function(data){
					parent.layer.msg("完成专家数据合并！");
					//关闭弹出图层
					parent.layer.close(index);
				},
				error: function(data){
					parent.layer.msg("保存合并专家信息出现异常，请重新对比数据，或与管理员联系！");
				}
			});
		}
	</script>
</body>
</html>