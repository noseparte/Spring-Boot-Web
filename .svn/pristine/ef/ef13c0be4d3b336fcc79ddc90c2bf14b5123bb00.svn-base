<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <system:header/>
<!-- jsp文件头和头部 -->
<link rel="stylesheet" href="hplus/css/plugins/treegrid/jquery.treegrid.css" />
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div>
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>按钮管理</h5>
						<div class="ibox-tools">
							<a href="javascript:saveButton()" class="btn btn-primary"
															id="backFun">保存</a>
							<a href="javascript:goBack()" class="btn btn-primary"
								id="backFun">返回</a>
						</div>

						<div class="ibox-content">
							<div class="container">
								<table class="table tree-2 table-bordered table-striped table-condensed">
								</table>
							</div>
							<!-- /container -->

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 全局js -->
	<system:jsFooter/>
	<!-- 自定义js -->
	<script src="hplus/js/content.min.js"></script>
	<script type="text/javascript" src="hplus/js/plugins/treegrid/jquery.treegrid.js"></script>
	<script type="text/javascript">
	
	var role='${roleid}';
	
	$(function() {
    	$.ajax({
			type: "POST",
			url: 'role/getTreeGrid',
			data: {ROLEID:role},
					dataType : 'text',
					//beforeSend: validateData,
					cache : false,
					success : function(data) {
						var treeGridData=decodeURIComponent(data,'UTF-8');
		                //console.info(treeGridData);
 						$('.tree-2').append(treeGridData);
                        $('.tree-2').treegrid({
                           expanderExpandedClass: 'glyphicon glyphicon-minus',
                           expanderCollapsedClass: 'glyphicon glyphicon-plus'
                        });
					}
		});
        

    });
	
	function saveButton(){
		globalButton = "";
		menuButton = "";
		
		$("input[type='checkbox']:checked").each(function(index){
			var id = $(this).attr("id");
			if(id.indexOf(",")==-1){
				if(globalButton==""){
					globalButton = id;
				}else{
					globalButton += ","+id
				}
			}else{
				if(menuButton==""){
					menuButton = id;
				}else{
					menuButton += ":"+id
				}
			}
		});
		
		
		$.ajax({
			type: "POST",
			url: 'role/editButton.do',
	    	data: {gb:globalButton,mb:menuButton,ROLE_ID:role},
			dataType:'json',
			cache: false,
			success: function(data){
				if(data.msg=='ok'){
					layer.msg('保存成功');
				}else{
					layer.msg('操作失败');
				}
			}
		});
		
	}
	
	function goBack(){
		this.location.href="<%=basePath%>role/listRoles";
	}
	</script>
</body>
</html>

