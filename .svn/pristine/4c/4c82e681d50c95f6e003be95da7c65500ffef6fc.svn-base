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
                        <h5>按钮管理 <small>修改</small></h5>
                        <div class="ibox-tools">
                            
                        </div>
                    </div>
                    <div class="ibox-content">
                        <form id="buttonForm" name="buttonForm" action="button/saveEdit"  method="post" class="form-horizontal">
                        	<input type="hidden" name="BUTTON_ID" id="button_id" value="${pd.BUTTON_ID }"/>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">按钮名</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control required" name="BUTTON_NAME" id="button_name" value="${pd.BUTTON_NAME }">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">按钮代码</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control required" name="BUTTON_CODE" id="button_code" value="${pd.BUTTON_CODE }">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">按钮描述</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="BUTTON_DESCP" id="button_descp" value="${pd.BUTTON_DESCP }">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">排序</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control required digits" name="BUTTON_ORDER" id="button_order" value="${pd.BUTTON_ORDER }">
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-2">
                                    <button class="btn btn-primary" type="submit">保存内容</button>
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
	
    $().ready(function(){
		$("#buttonForm").validate();
	});
    
	function goBack(){
		this.location.href="<%=basePath%>button/listButtons";
	}
	
</script>
	</body>
</html>

