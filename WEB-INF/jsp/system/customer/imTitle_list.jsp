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
                        <h5>主题管理</h5>
                    </div>
                    <div class="ibox-content">
                        <div id="toolbar" class="btn-group">
                        <div class="pull-left form-inline form-group">
                       		<input type="text" id="TITLE" name="TITLE" class="form-control"  placeholder="主题名称">
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
			    url: 'Imtitle/pageSearch',
			    toolbar:'#toolbar' ,
			    columns: [
			    	{
				        field: 'CHECKBOX',
				        halign: 'center',
				        formatter:checkboxFormatter
				    },
			     {
			        field: 'ID',
			        visible:false,
			        halign: 'center',
			    }, {
			        field: 'TITLE',
			        title: '主题',
			        align: 'right',
			        halign: 'center',
			        
			    }, {
			        field: 'STATUS',
			        title: '状态',
			        align: 'right',
			        halign: 'center',
			    }, {
			        field: 'CREATE_TIME',
			        title: '创建时间',
			        align: 'center',
			        halign: 'center',
			    },{
			    	field: 'CHANGE_TIME',
			        title: '修改时间',
			        align: 'center',
			        halign: 'center',
			    } ] 
			});
        });
		
		function checkboxFormatter(value,row,index){
			console.info(row);
			 if (true) {
	            return {
	                disabled: true,
	                checked: true
	            };
	        }
			return value;
		}
		
		
		function toDebug(){
			window.location.href="<%=basePath%>imTitle/toDebug";
		}
		
		
		
		function toAdd(){
			window.location.href="<%=basePath%>imTitle/toAdd";
		}
		
		function toEdit(){
			var ids = getBstCheckedId('ID');
			if(!(ids.length==1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			window.location.href="<%=basePath%>imTitle/toEdit?ID="+ids[0];
		}
		
		function toDel(){
			var ids = getBstCheckedId('ID');
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
					url: 'imTitle/delete?tm='+new Date().getTime(),
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

