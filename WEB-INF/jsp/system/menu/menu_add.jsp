<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ taglib prefix="pg" uri="/pegoe-tags" %>

<div class="modal-dialog">
	<div class="modal-content animated bounceInRight">
		<form id="menuForm">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">
				<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
			</button>
			<h1 class="modal-title" style="text-align: -webkit-left;">菜单信息管理</h1>
		</div>
		<div class="modal-body">
			
			<input type="hidden" id="pid" name="pid" value="${pid}">
			<div class="form-group">
				<label>名称</label> <input id="name" name="name" type="text" placeholder="请输入菜单名称" 
					class="form-control required">
			</div>
			<div class="form-group">
				<label>URL</label> <input id="url" name="url" value="#" type="text" placeholder="请输入菜单URL" 
					class="form-control required">
			</div>
			<div class="form-group">
				<label>ICON<a href="http://code.zoomla.cn/boot/font.html" target="_blank">【参考图标】</a></label> <input id="icon" name="icon" type="text" value="fa-square-o" placeholder="请输入菜单图标" 
					class="form-control">
			</div>
			<div class="form-group">
				<label>类型</label>
				<%-- <pg:simpleSelect name="type" id="type" data="" dicCode="menutype" cssClass="form-control required"/> --%>
			</div>
			<div class="form-group">
				<label>代码</label> <input id="code" name="code" type="text" placeholder="请输入菜单代码" 
					class="form-control required">
			</div>
			<div class="form-group">
				<label>是否显示</label> 
				<select name="show" id="show" class="form-control required">
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
			</div>
			<div class="form-group">
				<label>显示排序</label> <input id="order" name="order" type="text" placeholder="请输入排序数字"
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
		$('#menuForm').validate({
			submitHandler:function(form){
				$.ajax({
					type:'post',
					url:'menu/saveAdd',
					data:$('#menuForm').serialize(),
					success:function(data){
						layer.msg('新增成功');
						$("#myModal").modal('hide');
					}
				});
			}
		});
	});
	
</script>

