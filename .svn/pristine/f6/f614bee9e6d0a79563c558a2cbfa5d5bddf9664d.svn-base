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
			<input type="hidden" id="id" name="id" value="${pd.ID}">
			<input type="hidden" id="pid" name="pid" value="${pd.PID}">
			<input type="hidden" id="pcode" name="pcode" value="${pd.PCODE}">
			<div class="form-group">
				<label>名称</label> <input id="name" name="name" type="text" value="${pd.NAME }" placeholder="请输入数据字典名称" 
					class="form-control required">
			</div>
			<div class="form-group">
				<label>值</label> <input id="code" name="code" type="text" value="${pd.CODE }" placeholder="请输入数据字典值" 
					class="form-control required">
			</div>
			<div class="form-group">
				<label>描述</label> <input id="descp" name="descp" type="text" value="${pd.DESCP }" placeholder="请输入描述信息" 
					class="form-control">
			</div>
			<div class="form-group">
				<label>显示排序</label> <input id="sortorder" name="sortorder" type="text" value="${pd.SORTORDER }" placeholder="请输入排序数字"
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
					type: "POST",
					url: 'dic/hasChild.do',
			    	data: {pid:$("#id").val()},
					dataType:'json',
					cache: false,
					success: function(data){
						 if("true" == data.result){
							 $.ajax({
									type: "POST",
									url: 'dic/hasSameCode.do',
							    	data: {id:$("#id").val(),code:$("#code").val()},
									dataType:'json',
									cache: false,
									success: function(data){
										 if("success" == data.result){
											 $.ajax({
													type:'post',
													url:'dic/saveEdit',
													data:$('#dicForm').serialize(),
													success:function(data){
														layer.msg('修改成功');
														$("#myModal").modal('hide');
													}
												});
										 }else{
											 layer.msg('所选择的节点的字典值与其他字典字段重复，请修改确保字典值唯一');
											 return false;
										 }
									}
								});
						 }else{
							 $.ajax({
									type:'post',
									url:'dic/saveEdit',
									data:$('#dicForm').serialize(),
									success:function(data){
										layer.msg('修改成功');
										$("#myModal").modal('hide');
									}
								});
						 }
					}
				})
				
			}
		});
	});
	
</script>

