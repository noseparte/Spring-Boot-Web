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
							地图初始位置管理
						</h5>
						<div class="ibox-tools"></div>
					</div>
					<div class="ibox-content">
						<form id="homeLocationForm" name="homeLocationForm" class="form-horizontal">
							<input type="hidden" name="HL_ID" id="HL_ID" value="${pd.HL_ID}" />
							
							<div class="form-group">
								<label class="col-sm-2 control-label">地图初始位置代码</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="HL_CODE"
										id="HL_CODE" value="${pd.HL_CODE}">
								</div>
								<label class="col-sm-2 control-label">层级</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required digits" name="HL_LEVEL"
										id="HL_LEVEL" value="${pd.HL_LEVEL}">
								</div>
							</div>
							
							
							
							
							<div class="form-group">
								<label class="col-sm-2 control-label">左上经度</label>
								<div class="col-sm-4">
									<input type="text" class="form-control required number" name="HL_LT_LNG"
										id="HL_LT_LNG" value="${pd.HL_LT_LNG}">
								</div>
								<label class="col-sm-2 control-label">左上纬度</label>
								<div class="col-sm-3">
                                    <input type="text" class="form-control required number" name="HL_LT_LAT"
										id="HL_LT_LAT" value="${pd.HL_LT_LAT}">
								</div>
								<div class="col-sm-1">
									<button class="btn btn-primary" type="button" onclick="javascript:getCoordinateByGis('HL_LT_LNG', 'HL_LT_LAT');">获取坐标</button>
								</div>
							</div>
							
							
							<div class="form-group">
								<label class="col-sm-2 control-label">右下经度</label>
								<div class="col-sm-4">
									<input type="text" class="form-control required number" name="HL_RB_LNG"
										id="HL_RB_LNG" value="${pd.HL_RB_LNG}">
								</div>
								<label class="col-sm-2 control-label">右下纬度</label>
								<div class="col-sm-3">
                                    <input type="text" class="form-control required number" name="HL_RB_LAT"
										id="HL_RB_LAT" value="${pd.HL_RB_LAT}">
								</div>
								<div class="col-sm-1">
									<button class="btn btn-primary" type="button" onclick="javascript:getCoordinateByGis('HL_RB_LNG', 'HL_RB_LAT');">获取坐标</button>
								</div>
							</div>
							
							
							
							<div class="form-group">
								<label class="col-sm-2 control-label">备注</label>
								<div class="col-sm-4">
                                    <input type="text" class="form-control" name="HL_REMARK"
										id="HL_RAMARK" value="${pd.HL_REMARK}">
								</div>
							</div>
					
					       
						
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="col-sm-4 col-sm-offset-2">
									<button class="btn btn-primary" type="button" onclick="submitForm();">保存内容</button>
									<button class="btn btn-white" type="button" onclick="goBack();">取消</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 全局js -->
    <system:jsFooter/>
	<script src="hplus/js/plugins/jeditable/jquery.jeditable.js"></script>
	<!-- 自定义js -->
	<script src="hplus/js/content.min.js"></script>
	<script type="text/javascript">
	var editor;
    $().ready(function(){
	    $("#homeLocationForm").validate();
    });
    
    
    function submitForm(){
        var id=$('#HL_ID').val();
    	var action="";
    	if(id==""){
    		action="homeLocation/saveAdd";
    	}else{
    		action="homeLocation/saveEdit";
    	}
    	//$("#EP_CONTENT").val(editor.getValue());
    	$("#homeLocationForm").attr("action",action);
    	$("#homeLocationForm").submit();
    }
    
    
    
	function goBack(){
		this.location.href="<%=basePath%>homeLocation/listHomeLocations";
	}
	</script>
</body>
</html>

