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
                        <h5>数据字典信息管理</h5>
                        <div class="ibox-tools">
                            <a href="javascript:toAdd()" class="btn btn-primary" id="addFun">新增</a>
                            <a href="javascript:toEdit()" class="btn btn-primary" id="editFun">修改</a>
                            <a href="javascript:toDel()" class="btn btn-danger" id="deleteFun">删除</a>
                        </div>
                        <div class="ibox-content">
							<div class="col-sm-4">
		                        <div id="treeview" class="test"></div>
		                    </div>
		                    <div class="col-sm-8" style="overflow-y: scroll;" id="tableContainer">
		                        <div class="row" id="loadSta">
		                        </div>
		                        <div class="row" >
		                        	<div class="col-sm-10 col-sm-offset-2">
		                        	<div class="ibox float-e-margins">
					                    <div class="ibox-content">
					                        <table class="table" style="table-layout:fixed;word-wrap: break-word;">
					                            <thead>
					                                <tr>
					                                    <th width="30%">名称</th>
					                                    <th width="20%">代码</th>
					                                    <th width="20%">排序</th>
					                                    <th width="30%">描述</th>
					                                </tr>
					                            </thead>
					                            <tbody id="dic">
					                            </tbody>
					                        </table>
					                    </div>
                					</div>
                					</div>
		                        </div>
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
		var selectNodeCode = '';
		var selectNodeLv = 0;
		
		$(document).ready(function () {
			$("#tableContainer").height($(window).height()-150);
			makeTree();
			
			$("#myModal").on('hidden.bs.modal',function(){
				reloadTree();
			})
        });
		
		
		function makeTree(){
			$.ajax({
				type: "POST",
				url: 'dic/getTree',
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(treeData){
					$('#treeview').treeview({
				        data:treeData,
				        onNodeSelected:function(event,node){
				        	selectNodeid = node.id;
				        	if(node.id==0){
				        		selectNodeCode = '';
				        		selectNodeLv = 0;
				        	}else{
				        		selectNodeCode = node.code;
				        		selectNodeLv = node.levels;
				        	}
				        	
				        	$("#loadSta").html(loadingCssHtml);
				        	$("#dic").html('');
			        		$.ajax({
			        			type: "POST",
			    				url: 'dic/getSubTree',
			    				dataType:'json',
			    				data:{pid:node.id},
			    				cache: false,
			    				success:function(diclist){
			    					$("#loadSta").html('');
			    					var dicHtml = '';
			    					$(diclist).each(function(i,val){
			    						dicHtml += '<tr><td>'+val.NAME+'</td><td>'+val.CODE+'</td><td>'+val.SORTORDER+'</td><td>'+val.DESCP+'</td><tr>';
			    					});
			    					$("#dic").html(dicHtml);
			    				}
			        		});
				        	
				        }
				    });
				}
			});
		}
		
		function reloadTree(){
			$.ajax({
				type: "POST",
				url: 'dic/getTree',
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(treeData){
					$('#treeview').treeview({
				        data:treeData,
				        levels:2,
				        onNodeSelected:function(event,node){
				        	selectNodeid = node.id;
				        	if(node.id==0){
				        		selectNodeCode = '';
				        		selectNodeLv = 0;
				        	}else{
				        		selectNodeCode = node.code;
				        		selectNodeLv = node.levels;
				        	}
				        	
				        	$("#loadSta").html(loadingCssHtml);
				        	$("#dic").html('');
			        		$.ajax({
			        			type: "POST",
			    				url: 'dic/getSubTree',
			    				dataType:'json',
			    				data:{pid:node.id},
			    				cache: false,
			    				success:function(diclist){
			    					$("#loadSta").html('');
			    					var dicHtml = '';
			    					$(diclist).each(function(i,val){
			    						dicHtml += '<tr><td>'+val.NAME+'</td><td>'+val.CODE+'</td><td>'+val.SORTORDER+'</td><td>'+val.DESCP+'</td><tr>';
			    					});
			    					$("#dic").html(dicHtml);
			    				}
			        		});
				        }
				    });
				}
			});
		}
		
		
		function toAdd(){
			if(selectNodeid==undefined||selectNodeid==0){
				$("#myModal").load("dic/toAdd?pid="+selectNodeid+"&pcode="+selectNodeCode+"&plevels="+selectNodeLv,function(){
					$("#myModal").modal();
				})
			}else{
				$.ajax({
					type: "POST",
					url: 'dic/hasSameCode.do',
			    	data: {id:selectNodeid},
					dataType:'json',
					cache: false,
					success: function(data){
						 if("success" == data.result){
							 $("#myModal").load("dic/toAdd?pid="+selectNodeid+"&pcode="+selectNodeCode+"&plevels="+selectNodeLv,function(){
									$("#myModal").modal();
								})
						 }else{
							 layer.msg('所选择的节点的字典值与其他字典字段重复，请修改确保唯一再添加子节点');
							 return false;
						 }
					}
				});
			}
			
		}
		
		function toEdit(){
			if(selectNodeid==undefined||selectNodeid==0){
				layer.msg('请先选择一个数据项');
				return false;
			}
			
			$("#myModal").load("dic/toEdit?id="+selectNodeid,function(){
				$("#myModal").modal();
			})
		}
		
		function toDel(){
			if(selectNodeid==undefined||selectNodeid==0){
				layer.msg('请先选择一个数据项');
				return false;
			}
			
			layer.confirm('操作将会删除当前数据项及其下属数据项，确认删除吗？',{
				btn:['确认','取消'],
				shade:false
			},function(){
				$.ajax({
					type: "POST",
					url: 'dic/delete.do',
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

