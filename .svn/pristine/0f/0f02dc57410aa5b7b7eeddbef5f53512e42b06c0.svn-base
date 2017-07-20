<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>

<div class="modal-dialog">
	<div class="modal-content animated bounceInRight">
		<form id="dicForm">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">
				<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
			</button>
			<h1 class="modal-title" style="text-align: -webkit-left;">数据字典信息管理</h1>
		</div>
		<div class="modal-body">
			
			<input type="hidden" id="pid" name="pid" value="${pid}">
			<input type="hidden" id="levels" name="levels" value="${levels}">
			<input type="hidden" id="p_code" name="p_code" value="${p_code}">
			<div class="form-group">
				<label>名称</label> <input id="name" name="name" type="text" placeholder="请输入数据字典名称" 
					class="form-control required">
			</div>
			<div class="form-group">
				<label>值</label> <input id="code" name="code" type="text" placeholder="请输入数据字典值" 
					class="form-control required">
			</div>
			<div class="form-group">
				<label>描述</label> <input id="descp" name="descp" type="text" placeholder="请输入描述信息" 
					class="form-control">
			</div>
			<div class="form-group">
				<label>显示排序</label> <input id="sortorder" name="sortorder" type="text" placeholder="请输入排序数字"
					class="form-control required digits">
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
		$('#dicForm').validate({
			submitHandler:function(form){
				$.ajax({
					type:'post',
					url:'dic/saveAdd',
					data:$('#dicForm').serialize(),
					success:function(data){
						layer.msg('新增成功');
						$("#myModal").modal('hide');
					}
				});
			}
		});
	});
	
</script>

