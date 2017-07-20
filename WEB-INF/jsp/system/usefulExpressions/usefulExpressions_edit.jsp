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
                    <h5>常用语管理
                        <c:if test="pd.CONTENT == null || pd.CONTENT == ''">
                            <small>新增</small>
                        </c:if>
                        <c:if test="pd.CONTETN != null || pd.CONTENT != ''">
                            <small>修改</small>
                        </c:if>
                        </h5>
                    <div class="ibox-tools">

                    </div>
                </div>
                <div class="ibox-content">
                    <form id="buttonForm" name="buttonForm"
                    <c:if test="pd.CONTENT == null || pd.CONTENT == ''">
                        action="usefulExpression/saveAdd"
                    </c:if>
                    <c:if test="pd.CONTETN != null || pd.CONTENT != ''">
                        action="usefulExpression/saveEdit"
                    </c:if>  method="post" class="form-horizontal">
                        <input type="hidden" name="ID" id="id" value="${pd.ID }"/>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">内容</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control required" name="CONTETN" id="content" value="${pd.CONTENT }">
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-2 control-label">排序</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control required digits" name="ORDER_FILED" id="order_filed" value="${pd.ORDER_FILED }">
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
        this.location.href="<%=basePath%>usefulExpression/list";
    }

</script>
</body>
</html>
