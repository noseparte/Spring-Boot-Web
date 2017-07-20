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
                        <h5>角色信息管理 <small>新增</small></h5>
                        <div class="ibox-tools">
                            
                        </div>
                    </div>
                    <div class="ibox-content">
                        <form id="roleForm" name="roleForm" action="role/saveAdd"  method="post" class="form-horizontal">
                        	<input type="hidden" name="ROLE_ID" id="role_id" value="${pd.ROLE_ID }"/>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">角色名</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control required" name="ROLE_NAME" id="role_name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">角色代码</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control required" name="ROLE_CODE" id="role_code">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">排序</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control required digits" name="ROLE_ORDER" id="role_code">
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
		$("#roleForm").validate();
	});
    
	function goBack(){
		this.location.href="<%=basePath%>role/listRoles";
	}
	
</script>
	</body>
</html>

