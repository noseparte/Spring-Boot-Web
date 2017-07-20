<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<div class="modal-dialog">
	<div class="modal-content animated bounceInRight">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">
				<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
			</button>
			<h1 class="modal-title" style="text-align: -webkit-left;">用户角色权限列表</h1>
		</div>
		<div class="modal-body">
			<div class="row">
            <div class="col-sm-12">
            	<div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="file-manager">
                            <h5 class="tag-title">已授权角色</h5>
                            <ul class="tag-list" style="padding: 0">
                                <c:forEach items="${pd.roles }" var="item" varStatus="i">
                            	<li><a href="javascript:void(0);">${item }</a>
                                </li>
                            	</c:forEach>
                            </ul>
                            <div class="clearfix"></div>
                            <h5 class="tag-title">已授权菜单</h5>
                            <ul class="tag-list" style="padding: 0">
                                <c:forEach items="${pd.urls }" var="item" varStatus="i">
                            	<li><a href="javascript:void(0);">${item }</a>
                                </li>
                            	</c:forEach>
                            </ul>
                            <div class="clearfix"></div>
                            <h5 class="tag-title">全局按钮</h5>
                            <ul class="tag-list" style="padding: 0">
                                <c:forEach items="${pd.globalButton }" var="item" varStatus="i">
                            	<li><a href="javascript:void(0);">${item }</a>
                                </li>
                            	</c:forEach>
                            </ul>
                            <div class="clearfix"></div>
                            <h5 class="tag-title">菜单按钮</h5>
                            <ul class="tag-list" style="padding: 0">
                                <c:forEach items="${pd.urlButton }" var="item" varStatus="i">
                            	<li><a href="javascript:void(0);">${item }</a>
                                </li>
                            	</c:forEach>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
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
