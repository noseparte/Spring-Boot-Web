<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                        <h5>文件上传信息管理</h5>
                    </div>
                    <div class="ibox-content">
                        <div id="toolbar" class="btn-group">
                        <div class="pull-left form-inline form-group">
                        
							<input type="text" id="FILENAME" name="FILENAME" class="form-control"  placeholder="文件名">
						</if>
							<button type="button" class="btn btn-default btn-primary" onclick="bstQuery('queryTable');">
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
	<!-- 全局js -->
    <system:jsFooter/>
	<script type="text/javascript">
	
	
	
		$(document).ready(function (){
			$('#queryTable').bootstrapTable({
			    url: 'filesUploads/listData',
			    toolbar:'#toolbar' ,
			    columns: [		    	{
			        field: 'ID',
			        visible:false,
			        halign: 'center',
			    },
		    
					{
				        field: 'FILE_NAME',
				        title: '文件名',
				        align: 'center'
				    },
					{
				        field: 'BASE_PATH',
				        title: 'basepath',
				        align: 'center'
				    },
					{
				        field: 'PATH',
				        title: '路径',
				        align: 'center'
				    },
					{
				        field: 'FILE_SIZE',
				        title: '文件大小',
				        align: 'center'
				    },
					{
				        field: 'FILE_TYPE',
				        title: '文件类型',
				        align: 'center'
				    },
					{
				        field: 'MASTER_ID',
				        title: '主键ID',
				        align: 'center'
				    },
					{
				        field: 'STATUS',
				        title: '状态（0有效 1无效）',
				        align: 'center'
				    },
					{
				        field: 'CREATE_ID',
				        title: '上传人ID',
				        align: 'center'
				    },
					{
				        field: 'CREATE_TIME',
				        title: '上传时间',
				        align: 'center'
				    }]
			});
        });
		
		function toAdd(){
			window.location.href="<%=basePath%>filesUploads/toAdd";
		}
		
		
		function toEdit(){
			var ids = getBstCheckedId('ID');
			if(!(ids.length==1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			window.location.href="<%=basePath%>filesUploads/toEdit?ID="+ids[0];
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
					url: 'filesUploads/delete?tm='+new Date().getTime(),
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
				
			});
		}
		</script>
	</body>
</html>