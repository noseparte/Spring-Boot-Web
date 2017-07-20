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
					<div class="ibox-content">
						<form id="OrderEvaluateForm" name="OrderEvaluateForm" class="form-horizontal" method="post">
							<!-- <div class="form-group" style="text-align:center;">
								<label class="col-sm-12 control-label">
									代理商：<img src="" style="width:100px;" id="LEVEL_DL"/>
									专家：<img src="" style="width:100px;" id="LEVEL_ZJ"/>
									陪诊：<img src="" style="width:100px;" id="LEVEL_PZ"/>
								</label>
							</div> -->
							<div class="form-group">
								<label class="col-sm-3 control-label">文字信息：</label>${pd.EVA_CONTENT}
							</div>
							<%-- <c:if test="${pd.imgPaths != null }">
							<div class="form-group">
								<div class="col-sm-12" style="word-break:break-all;text-align:center;">
									<c:forEach items="${pd.imgPaths }" var="item" varStatus="i">
										<img alt="" src="${pd.basePath }${item}" /><br />
										<input type="text" value="${pd.basePath }${item}">
									</c:forEach>
								</div>
							</div>
							</c:if> --%>
							
							<c:if test="${pd.imgPaths != null }">
								<div class="form-group">
								<label class="col-sm-4 control-label">图片信息：</label>
								    <div id="links" class="col-sm-8">
									    <%-- <c:forEach items="${pd.imgPaths }" var="item" varStatus="status">
									    	<a href="${pd.basePaths }${item}" title="大图">
										        <img src="${pd.basePaths }${item}" width='150px' height='120px' />
										    </a>
									    </c:forEach> --%>
									     <c:forEach items="${pd.imgPaths }" var="item" varStatus="status">
										    <a href="${pd.basePaths }${item}" data-fancybox="group${pd.basePaths}" data-caption="">
												<img src="${pd.basePaths }${item}" alt="" width='150px' height='120px'/>
											</a>
								    	</c:forEach>
									</div>
								</div>
							
							</c:if>
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
		$(document).ready(function(){
			var LEVEL_DL = ${pd.LEVEL_DL};
			LEVEL_DL = Math.round(LEVEL_DL);
			$("#LEVEL_DL").attr("src","<%=basePath%>/images/stars/star_"+LEVEL_DL+".png");
			var LEVEL_ZJ = ${pd.LEVEL_ZJ};
			LEVEL_ZJ = Math.round(LEVEL_ZJ);
			$("#LEVEL_ZJ").attr("src","<%=basePath%>/images/stars/star_"+LEVEL_ZJ+".png");
			var LEVEL_PZ = ${pd.LEVEL_PZ};
			LEVEL_PZ = Math.round(LEVEL_PZ);
			$("#LEVEL_PZ").attr("src","<%=basePath%>/images/stars/star_"+LEVEL_PZ+".png");
			
		});
		$('[data-fancybox]').fancybox({
			image : {
				protect: true
			}
		});
	</script>
</body>
</html>