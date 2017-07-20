<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<div class="modal-dialog">
	<div class="modal-content animated bounceInRight">
		<form id="deptForm">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">
				<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
			</button>
			<h1 class="modal-title" style="text-align: -webkit-left;">班组信息管理</h1>
		</div>
		<div class="modal-body">
			
			<input type="hidden" id="pid" name="pid" value="${pd.pid}">
			<div class="form-group">
				<label>班组名称</label> <input id="name" name="name" type="text" placeholder="请输入班组名称" 
					class="form-control required" value="${pd.DEPT_NAME}">
			</div>
			<div class="form-group">
				<label>显示排序</label> <input id="order" name="order" type="text" placeholder="请输入排序数字"
					class="form-control required digits" value="${pd.DEPT_ORDER}">
			</div>
			
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
			<button type="submit" class="btn btn-primary">保存</button>
		</div>
		</form>
	</div>
</div>
<script type="text/javascript">
	$().ready(function(){
		$('#deptForm').validate({
			submitHandler:function(form){
				$.ajax({
					type:'post',
					url:'dept/saveAdd',
					data:$('#deptForm').serialize(),
					success:function(data){
						layer.msg('新增成功');
						$("#myModal").modal('hide');
						reloadTree();
					}
				});
			}
		});
	});
	
</script>

