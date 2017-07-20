<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<system:header/>
	</head> 
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
	   <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>敏感词管理</h5>
                    </div>
                    <div class="ibox-content">
                        <div id="toolbar" class="btn-group">
                        <div class="pull-left form-inline form-group">
                       		<input type="text" id="SENSITIVE_WORD" name="SENSITIVE_WORD" class="form-control"  placeholder="敏感词名称">
							<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
						       	查询
						    </button>
						    <button type="button" class="btn btn-default btn-primary" onclick="toAdd();">
						       	新增
						    </button>
						    <button type="button" class="btn btn-default btn-primary" onclick="toEdit();">
						                    修改
						    </button>
						    <button type="button" class="btn btn-default btn-danger" onclick="toDel();">
						       	删除
						    </button>
                        </div>
						   
						</div>
                        
					<table id="queryTable" data-mobile-responsive="true"></table>
                    </div>
                </div>
            </div>
        </div>	
	</div>
	<div id="myModal" class="modal inmodal fade" tabindex="-1" role="dialog"  aria-hidden="true">
		                        	 
	</div>	
		<!-- 全局js -->
	<system:jsFooter/>
		<script type="text/javascript">
		
		$(document).ready(function () {
		       table= $('#queryTable').bootstrapTable({
			    url: 'sensitiveWords/sensitiveWordslistPage',
			    toolbar:'#toolbar',
			    columns: [
			     {
			        field: 'SW_ID',
			        visible:false,
			        halign: 'center'
			    }, {
			        field: 'SENSITIVE_WORD',
			        title: '敏感词',
			        align: 'right'
			        
			    }, {
			        field: 'USERNAME',
			        title: '创建人',
			        align: 'right'
			    }]
			});
        });
		
		
		function toDebug(){
			window.location.href="<%=basePath%>sensitiveWords/toDebug";
		}
		
		
		
		function toAdd(){
			window.location.href="<%=basePath%>sensitiveWords/toAdd";
		}
		
		function toEdit(){
			var ids = getBstCheckedId('SW_ID');
			if(!(ids.length==1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			window.location.href="<%=basePath%>sensitiveWords/toEdit?SW_ID="+ids[0];
		}
		
		function toDel(){
			var ids = getBstCheckedId('SW_ID');
			if((ids.length<1)){
				layer.msg('请选中信息再进行删除。');
				return false;
			}
			var idsStr = ids.toString();
			layer.confirm('确认删除这些信息吗？',{
				btn:['确认','取消'],
				shade:false
			},function(){
				$.ajax({
					type: "POST",
					url: 'sensitiveWords/delete',
			    	data: {IDS:idsStr},
					dataType:'json',
					cache: false,
					success: function(data){
						if(data.msg=='ok'){
							layer.msg('删除信息成功');
							bstQuery();
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

