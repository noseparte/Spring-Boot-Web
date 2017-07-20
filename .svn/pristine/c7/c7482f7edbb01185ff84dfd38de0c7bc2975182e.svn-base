<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<div class="modal-dialog">
	<div class="modal-content animated bounceInRight">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">
				<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
			</button>
			<h1 class="modal-title" style="text-align: -webkit-left;">通道用户管理</h1>
		</div>
		<div class="modal-body">
			<div class="row">
            <div class="col-sm-6">
                <div class="ibox">
                    <div class="ibox-content">
                        <h3>待选用户列表</h3>
                        <p class="small"><i class="fa fa-hand-o-up"></i> 在列表之间拖动面板</p>

                        <div class="input-group">
                            <input type="text" placeholder="查询用户" class="input input-sm form-control">
                            <span class="input-group-btn">
                                        <button type="button" class="btn btn-sm btn-white"> <i class="fa fa-plus"></i> 查询</button>
                                </span>
                        </div>

                        <ul class="sortable-list connectList agile-list" id="list1">
                            <c:forEach items="${lUserList }" var="item" varStatus="i">
                            	<li class="warning-element" id="${item.USER_ID }">
                                ${item.NAME }<a href="javascript:move('${item.USER_ID }');" class="pull-right btn btn-xs btn-white">选择</a>
                            	</li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="ibox">
                    <div class="ibox-content">
                        <h3>已选用户列表</h3>
                        <p class="small"><i class="fa fa-hand-o-up"></i> 在列表之间拖动面板</p>
                        <ul class="sortable-list connectList agile-list" id="list2">
                            <c:forEach items="${rUserList }" var="item" varStatus="i">
                            	<li class="warning-element" id="${item.USER_ID }">
                                ${item.NAME }<a href="javascript:move('${item.USER_ID }');" class="pull-right btn btn-xs btn-white">选择</a>
                            	</li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
		</div>
	</div>
</div>

<script type="text/javascript">
	var topic=${TOPICID};
	
	$(window).load(function(){
		 $(".sortable-list").sortable({
             connectWith: ".connectList",
             receive:function(event,ui){
             	var obj = ui.item;
             	var itemId = $(obj).attr("id");
             	var list = $(obj).parent().attr("id");
             	var method;
             	if(list=='list1'){
             		method = "remove";
             	}else{
             		method = "add";
             	}
             	$.ajax({
					type: "POST",
					url: 'msgTopic/editUser.do?method='+method,
			    	data: {IDS:itemId,TOPIC_ID:topic},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						if(data.msg=='ok'){
						}else{
							layer.msg('操作失败');
						}
						
					}
				});
            }
         }).disableSelection();
	});
	
	function move(id){
		var list = $("#"+id).parent().attr("id");
		var method;
		
     	if(list=='list1'){
     		$("#"+id).appendTo("#list2");
     		method = "add";
     	}else{
     		$("#"+id).appendTo("#list1");
     		method = "remove";
     	}
     	
     	$.ajax({
			type: "POST",
			url: 'msgTopic/editUser.do?method='+method,
	    	data: {IDS:id,TOPIC_ID:topic},
			dataType:'json',
			//beforeSend: validateData,
			cache: false,
			success: function(data){
				if(data.msg=='ok'){
				}else{
					layer.msg('操作失败');
				}
				
			}
		});
	}
	
</script>

