<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<link rel="stylesheet" href="hplus/css/plugins/jsTree/style.min.css" />
<div class="modal-dialog">
	<div class="modal-content animated bounceInRight">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">
				<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
			</button>
			<h1 class="modal-title" style="text-align: -webkit-left;">消息管理</h1>
		</div>
		<div class="modal-body">
			<div class="row" style="margin-bottom: -20px;">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div id="toolbar" class="btn-group">
                        <div class="pull-left form-inline form-group">
                       		<input type="text" id="title" name="title" class="form-control"  placeholder="可按标题进行查询">
							<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
						       	查询
						    </button>
                        </div>
						   
						</div>
                        
					<table id="queryTable" data-mobile-responsive="true"></table>
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
		$(document).ready(function () {
			$('#queryTable').bootstrapTable({
			    url: 'message/pageSearch',
			    toolbar:'#toolbar' ,
			    columns: [
			    {
			        field: 'sendid',
			        visible:false,
			        halign: 'center',
			    }, {
			        field: 'title',
			        title: '消息标题',
			        align: 'left',
			        halign: 'center',
			    }, {
			        field: 'content',
			        title: '消息内容',
			        align: 'left',
			        halign: 'center',
			    }, {
			        field: 'sendTime',
			        title: '发送时间',
			        align: 'center',
			        halign: 'center',
			    },{
			    	field: 'status',
			        title: '状态',
			        align: 'center',
			        halign: 'center',
			    } ] 
			});
        });
</script>        