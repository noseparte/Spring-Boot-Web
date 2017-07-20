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
                        <h5>菜单信息管理</h5>
                        <div class="ibox-tools">
                            <a href="javascript:toAdd()" class="btn btn-primary" id="addFun">新增</a>
                            <a href="javascript:toEdit()" class="btn btn-primary" id="editFun">修改</a>
                            <a href="javascript:toDel()" class="btn btn-danger" id="deleteFun">删除</a>
                        </div>
                        <div class="ibox-content">
							<div class="col-sm-4">
		                        <div id="treeview" class="test"></div>
		                    </div>
		                    <div class="col-sm-8">
		                        <div class="row" id="loadSta">
		                        </div>
		                        <div class="row" >
		                        	<div class="col-sm-10 col-sm-offset-1">
		                        	<div class="ibox float-e-margins">
					                    <div class="ibox-content">
					                        <table class="table" style="table-layout:fixed;word-wrap: break-word;">
					                            <thead>
					                                <tr>
					                                    <th width="20%">名称</th>
					                                    <th width="40%">URL</th>
					                                    <th width="10%">排序</th>
					                                    <th width="20%">代码</th>
					                                    <th width="10%">显示</th>
					                                </tr>
					                            </thead>
					                            <tbody id="menu">
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
		
		$(document).ready(function () {
			
			makeTree();
			
			$("#myModal").on('hidden.bs.modal',function(){
				reloadTree();
			})
        });
		
		
		function makeTree(){
			$.ajax({
				type: "POST",
				url: 'menu/getTree',
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(treeData){
					$('#treeview').treeview({
				        data:treeData,
				        onNodeSelected:function(event,node){
				        	selectNodeid = node.id;
				        	$("#loadSta").html(loadingCssHtml);
				        	$("#menu").html('');
			        		$.ajax({
			        			type: "POST",
			    				url: 'menu/getSubTree',
			    				dataType:'json',
			    				data:{pid:node.id},
			    				cache: false,
			    				success:function(menulist){
			    					$("#loadSta").html('');
			    					var menuHtml = '';
			    					$(menulist).each(function(i,val){
			    						if(val.MENU_SHOW=='1'){
			    							menuHtml += '<tr><td>'+val.MENU_NAME+'</td><td>'+val.MENU_URL+'</td><td>'+val.MENU_ORDER+'</td><td>'+val.MENU_CODE+'</td><td>是</td><tr>';
			    						}else{
			    							menuHtml += '<tr><td>'+val.MENU_NAME+'</td><td>'+val.MENU_URL+'</td><td>'+val.MENU_ORDER+'</td><td>'+val.MENU_CODE+'</td><td>否</td><tr>';
			    						}
			    					});
			    					$("#menu").html(menuHtml);
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
				url: 'menu/getTree',
				dataType:'json',
				//beforeSend: validateData,
				cache: false,
				success: function(treeData){
					$('#treeview').treeview({
				        data:treeData,
				        levels:2,
				        onNodeSelected:function(event,node){
				        	selectNodeid = node.id;
				        	$("#loadSta").html(loadingCssHtml);
				        	$("#menu").html('');
			        		$.ajax({
			        			type: "POST",
			    				url: 'menu/getSubTree',
			    				dataType:'json',
			    				data:{pid:node.id},
			    				cache: false,
			    				success:function(menulist){
			    					$("#loadSta").html('');
			    					var menuHtml = '';
			    					$(menulist).each(function(i,val){
			    						if(val.MENU_SHOW=='1'){
			    							menuHtml += '<tr><td>'+val.MENU_NAME+'</td><td>'+val.MENU_URL+'</td><td>'+val.MENU_ORDER+'</td><td>'+val.MENU_CODE+'</td><td>是</td><tr>';
			    						}else{
			    							menuHtml += '<tr><td>'+val.MENU_NAME+'</td><td>'+val.MENU_URL+'</td><td>'+val.MENU_ORDER+'</td><td>'+val.MENU_CODE+'</td><td>否</td><tr>';
			    						}
			    					});
			    					$("#menu").html(menuHtml);
			    				}
			        		});
				        }
				    });
				}
			});
		}
		
		
		function toAdd(){
			$("#myModal").load("menu/toAdd?pid="+selectNodeid,function(){
				$("#myModal").modal();
			})
		}
		
		function toEdit(){
			if(selectNodeid==undefined||selectNodeid==0){
				layer.msg('请先选择一个数据项');
				return false;
			}
			
			$("#myModal").load("menu/toEdit?id="+selectNodeid,function(){
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
					url: 'menu/delete.do',
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

