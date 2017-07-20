<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="hplus/css/plugins/treeview/bootstrap-treeview.css"
	rel="stylesheet">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="modal-dialog">
	<div class="modal-content animated bounceInRight">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">
				<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>
			</button>
			<h1 class="modal-title" style="text-align: -webkit-left;">班组选择</h1>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-sm-12">
					<div id="treeview"></div>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button class="btn btn-primary" type="button" data-dismiss="modal"
				onclick="confirm();">确定</button>
			<button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
		</div>
	</div>
</div>
<script src="hplus/js/plugins/treeview/bootstrap-treeview.js"></script>
<script type="text/javascript">
	var selectNodeid = 0;
	var deptId = '${DEPT_ID}';
	$(document).ready(function() {
		makeTree();
	});

	function makeTree() {
		$.ajax({
			type : "POST",
			url : 'user/getTree',
			data : {
				DEPT_ID : deptId
			},
			dataType : 'json',
			//beforeSend: validateData,
			cache : false,
			success : function(treeData) {
				$('#treeview').treeview({
					data : treeData,
					showIcon : false,
					showCheckbox : true,
					//勾选事件
					onNodeChecked : function(event, node) {
						checkParentNode(node); //勾选父节点，记录父节点id
						checkAllChildNodes(node); //勾选子节点记录子节点id
					},
					//取消勾选事件
					onNodeUnchecked : function(event, node) {
						unCheckAllChildNodes(node); //子节点取消勾选，记录子节点id
					}
				});
			}
		});
	}
	
	

	function confirm() {
		var arrayIds = new Array();
		var arrayNames=new Array();
		getCheckNodeIds($('#treeview').treeview('getNode', 0), arrayIds);
		getCheckNodeNames($('#treeview').treeview('getNode', 0), arrayNames);
		$("#DEPT_ID").val(arrayIds);
		$("#DEPT_NAME").val(arrayNames);
// 		$.ajax({
// 			type : "POST",
// 			url : 'role/editMenu',
// 			data : {
// 				MENU_IDS : array.toString(),
// 				ROLEID : role
// 			},
// 			dataType : 'json',
// 			//beforeSend: validateData,
// 			cache : false,
// 			success : function(data) {
// 				if (data.msg == 'ok') {
// 					layer.msg('保存成功');
// 				} else {
// 					layer.msg('操作失败');
// 				}

// 			}
// 		});


	}
	

	//得到所有选择节点id，存入array数组
	function getCheckNodeIds(node, array) {
		for (var i = 0; i < node.nodes.length; i++) {
			if (node.nodes[i].state.checked == true) {
				array.push(node.nodes[i].id);
				getCheckNodeIds(node.nodes[i], array);
			}
		}
	}
	
	//得到所有选择节点name，存入array数组
	function getCheckNodeNames(node, array) {
		for (var i = 0; i < node.nodes.length; i++) {
			if (node.nodes[i].state.checked == true) {
				array.push(node.nodes[i].text);
				getCheckNodeNames(node.nodes[i], array);
			}
		}
	}
	

	//父节点联动勾选
	function checkParentNode(node) {
		var parent = $('#treeview').treeview('getParent', node);
		if (parent != null && parent.hasOwnProperty('nodeId')) { //判断是否有父节点并且父节点不是treeeView
			if (parent.state.checked == false) {
				$('#treeview').treeview('checkNode', [ parent, {
					silent : true
				} ]);
				//array.push(parent.id);
				checkParentNode(parent);
			}
		}
	}

	//所有子节点联动勾选
	function checkAllChildNodes(node) {
		if (node.nodes != null) {
			for (var i = 0; i < node.nodes.length; i++) {
				if (node.nodes[i].state.checked == false) {
					$('#treeview').treeview('checkNode',
							[ node.nodes[i].nodeId, {
								silent : true
							} ]);
					checkAllChildNodes(node.nodes[i]);
				}
			}
		}
	}

	//所有子节点联动取消勾选
	function unCheckAllChildNodes(node) {
		if (node.nodes != null) {
			for (var i = 0; i < node.nodes.length; i++) {
				if (node.nodes[i].state.checked == true) {
					$('#treeview').treeview('uncheckNode',
							[ node.nodes[i].nodeId, {
								silent : true
							} ]);
					// 					array.push(node.nodes[i].id);
					unCheckAllChildNodes(node.nodes[i]);
				}
			}
		}
	}
</script>

