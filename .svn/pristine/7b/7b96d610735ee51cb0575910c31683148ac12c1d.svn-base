<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
	 <system:header/>
	<link href="hplus/css/plugins/treeview/bootstrap-treeview.css" rel="stylesheet">
	<!-- jsp文件头和头部 -->
	</head> 
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
	   <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>班组信息管理</h5>
                        <div class="ibox-tools">
                            <a href="javascript:toAdd()" class="btn btn-primary" id="addFun">新增</a>
                            <a href="javascript:toEdit()" class="btn btn-primary" id="editFun">修改</a>
                            <a href="javascript:toDel()" class="btn btn-danger" id="deleteFun">删除</a>
                        </div>
                        <div class="ibox-content">
							<div class="col-sm-6">
		                        <div id="treeview" class="test"></div>
		                    </div>
		                    <div class="col-sm-6">
		                        
		                    </div>
		                    <div class="clearfix"></div>
	                    </div>
                    </div>
                </div>
            </div>
        </div>	
	</div>	
	
	<div id="myModal" class="modal inmodal fade" tabindex="-1" role="dialog"  aria-hidden="true">
		                        	 
	</div>
	
		<!-- 全局js -->
	 <system:jsFooter/>
    <!-- treeview -->
    <script src="hplus/js/plugins/treeview/bootstrap-treeview.js"></script> 
    <!-- 自定义js -->
    <script src="hplus/js/content.min.js"></script>
		<script type="text/javascript">
		var selectNodeid = 0;
		
		$(document).ready(function () {
			
			makeTree();
			
			$("#myModal").on('hidden.bs.modal',function(){
				reloadTree();
			})
        });
		
		
		function makeTree(){
			$.ajax({
				type: "POST",
				url: 'dept/getTree',
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(treeData){
					$('#treeview').treeview({
				        data:treeData,
				        onNodeSelected:function(event,node){
				        	selectNodeid = node.id;
				        }
				    });
				}
			});
		}
		
		function reloadTree(){
			$.ajax({
				type: "POST",
				url: 'dept/getTree',
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(treeData){
					$('#treeview').treeview({
				        data:treeData,
				        levels:4,
				        onNodeSelected:function(event,node){
				        	selectNodeid = node.id;
				        }
				    });
				}
			});
		}
		
		
		function toAdd(){
			$("#myModal").load("dept/toAdd?pid="+selectNodeid,function(){
				$("#myModal").modal();
			})
		}
		
		function toEdit(){
			if(selectNodeid==undefined||selectNodeid==0){
				layer.msg('请先选择一个班组');
				return false;
			}
			
			$("#myModal").load("dept/toEdit?id="+selectNodeid,function(){
				$("#myModal").modal();
			})
		}
		
		function toDel(){
			if(selectNodeid==undefined||selectNodeid==0){
				layer.msg('请先选择一个班组');
				return false;
			}
			
			layer.confirm('操作将会删除当前班组，确认删除吗？',{
				btn:['确认','取消'],
				shade:false
			},function(){
				$.ajax({
					type: "POST",
					url: 'dept/delete.do',
			    	data: {'id':selectNodeid},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						
						if(data.msg=='ok'){
							layer.msg('删除信息成功');
							reloadTree();
						}else{
							layer.msg('删除信息失败');
						}
					}
				});
				
			},function(){
				
			}
			);
			
		}
		
		</script>
		
	</body>
</html>

