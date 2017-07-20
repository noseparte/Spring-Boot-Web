<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
	 <system:header/>
	<!-- jsp文件头和头部 -->
	</head> 
<body class="gray-bg" style="width:390px">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content icons-box" style="padding:0 0 0;">
                        <div class="bs-glyphicons">
                            <ul class="bs-glyphicons-list">
							   <c:forEach items="${list}" var="platform">
							   <li style="width:130px;height:130px;padding:0px;">
                                    <div style="width:130px;height:150px;padding:0px">
							            <pre style="padding:0px;margin:0 0 10px;border:0px;">
							            ${platform.description }
							            ${platform.ptype }
							            ${platform.address }
							            </pre>
							        </div>
                                </li>
							   </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	
	<!-- 全局js -->
    <system:jsFooter/>
    <!-- 自定义js -->
	</body>
</html>

