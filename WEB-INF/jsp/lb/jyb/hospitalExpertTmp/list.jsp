﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>
<!-- jsp文件头和头部 -->
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>专家信息</h5>
					</div>
					<div class="ibox-content">
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
								<select class="form-control" name="HD_IDD" id="HD_ID" value="${pd.HD_IDD}"
                                    ajax--url="hospDept/getHospDeptForSelect" ajax--column="ID,TEXT" style="width:150px;">
                                    <option value="">--所属科室--</option>
                     			</select>
                     			<%-- <select class="form-control" name="SYS_UI_ID" id="SYS_UI_ID" value="${pd.SYS_UI_ID}"
                                    ajax--url="agent/getAllAgent" ajax--column="ID,TEXT" style="width:150px;">
                                    <option value="">--所属代理商--</option>
                     			</select> --%>
                     			<select class="form-control" name="HE_AREAA" id="HE_AREA" value="${pd.HE_AREAA}" onchange="changePcode();"
                                    ajax--url="dic/getDicAreaForSelect" ajax--column="ID,TEXT" style="width:140px;">
                                    <option value="">--选择地域信息--</option>
                     			</select>
						    	<select class="form-control required" name="caa_pcode" id="caa_pcode" value="${pd.caa_pcode}"
                               		ajax--url="dic/getSubDicAreaListByProvinceCode" ajax--column="ID,TEXT" style="width:140px;">
                   				 	<option value="">--选择所在城市--</option>
                   				 </select>
							    <input type="text" id="HEL_NAME" name="HEL_NAME" class="form-control" placeholder="专家名称" style="width:150px;"/>
								<button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
							       	查询
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toAdd();">
							       	添加
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toEdit();">
							       	修改
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toSubmission();">
							       	提交
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
	<div id="myModal" class="modal inmodal fade" tabindex="-1" role="dialog"  aria-hidden="true"></div>
	<!-- 全局js -->
	<system:jsFooter/>
	<script type="text/javascript">
		//表格ID
		var tableId = "#queryTable";
		//表格请求及数据
		var tableColumns = {
			url: 'hospitalExpertTmp/pageSearch?tm=' + new Date().getTime(),
			toolbar: '#toolbar',
			columns: [{
		        field: 'HEL_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'HEL_NAME',
		        title: '姓名',
		        align: 'center',
		        halign: 'center',
		        width: '10%',
			    formatter: formatNameFun
		    }, {
		        field: 'HEL_SEX',
		        title: '性别',
		        align: 'center',
		        halign: 'center',
		        width: '5%'
		    }, {
		        field: 'CAA_NAME',
		        title: '所属区域',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'HE_HOSPITAL',
		        title: '所属医院',
		        align: 'left',
		        halign: 'center',
		        width: '15%'
		    }, {
		        field: 'HD_NAME',
		        title: '所属科室',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'HEL_DUTY',
		        title: '职务',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'HEL_BIRTHDAY',
		        title: '出生日期',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'PHONENUM',
		        title: '手机号',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }, {
		        field: 'HE_SUBMIT',
		        title: '提交',
		        align: 'center',
		        halign: 'center',
		        width: '10%'
		    }]
		};
		$(document).ready(function (){
			//初始化及查询生成表格内容
			table = $(tableId).bootstrapTable(tableColumns);
			$("#HE_AREA").createOption();
			$("#HD_ID").createOption();
			$("#SYS_UI_ID").createOption();
		});
		/* 二级联动 */
	    function changePcode(){
			//debugger
    		var addr=$("#HE_AREA").val();
    		//console.log(addr);
   			$("#caa_pcode").createOptions({"caa_pcode":addr});
   			var addr1=$("#HE_AREA").val();
   			//console.log(addr1);
    		if(addr1 == null || addr1 == ""){
    			$("#caa_pcode").empty();
    			$("#caa_pcode").append("<option value=''>--选择所在城市--</option>");
    		}else{
    			$("#caa_pcode").createOptions({"caa_pcode":addr1});
    		}
    	};
		//查询刷新表格
		function searchRefreshTable(){
			//销毁表格
			$(tableId).bootstrapTable('destroy');
			$(tableId).bootstrapTable(tableColumns);
		}
		//导出Excel
		function toExport(){
			$(tableId).bootstrapTable('exportTable', {
				type : 'excel'
			});
		}
		//更改提交状态
		function toSubmission(){
			var ids = getBstCheckedId('HEL_ID');
			if((ids.length < 1)){
				layer.msg('请选中信息再进行提交。');
				return false;
			}
			var idsStr = ids.toString();
			layer.confirm('确定提交已选信息吗？', {
				btn: ['确认','取消'],
				shade: false,
				yes: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>hospitalExpertTmp/toSubmission?tm=' +  new Date().getTime(),
						data: {
							IDS: idsStr
						},
						dataType: 'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data) {
							if (data.msg == 'success') {
								layer.msg('提交成功');
								bstQuery();
							} else {
								layer.msg('提交失败');
							}
						}
					});
				}
			});
		}
		//批量删除数据
		function toDel(){
			var ids = getBstCheckedId('HEL_ID');
			if((ids.length < 1)){
				layer.msg('请选中信息再进行删除。');
				return false;
			}
			var idsStr = ids.toString();
			layer.confirm('确定删除已选信息吗？', {
				btn: ['确认','取消'],
				shade: false,
				yes: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>hospitalExpertTmp/toDelete?tm=' +  new Date().getTime(),
						data: {
							IDS: idsStr
						},
						dataType: 'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data) {
							if (data.msg == 'success') {
								layer.msg('删除信息成功');
								bstQuery();
							} else {
								layer.msg('删除信息失败');
							}
						}
					});
				}
			});
		}
		
		// 跳转编辑添加页面
		function toEdit(){
			var ids = getBstCheckedId('HEL_ID');
			if(!(ids.length==1)) {
				layer.msg("请只选中一条信息进行编辑");
				return false;
			}
 			else
			{
 				$.ajax({
					type: "POST",
					url: '<%=basePath%>hospitalExpertTmp/selectStatus?tm=' +  new Date().getTime(),
					data: {
						HEL_ID: ids
					},
					dataType: 'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data) {
						if (data.msg == 'success') {
							window.location.href ="<%=basePath%>hospitalExpertTmp/toEdit?HEL_ID="+ids;
						} else {
							layer.msg('已经提交的专家不能修改！');
						}
					}
				});
			} 
		}
		//去添加信息
		function toAdd(){
			this.location.href="<%=basePath%>hospitalExpertTmp/toAdd";
		}
		//预览信息
		//浏览
		function toView(HEL_ID){
			if(HEL_ID != null && HEL_ID != ""){
				layer.full(layer.open({
					type: 2,
					title: '信息浏览',//窗体标题
					area: ['600px', '600px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: true,//整体页面滚动条是否显示
					content: ["hospitalExpertTmp/toMergeLists?HEL_ID=" + HEL_ID , "yes"],//URL地址,yes或者or是表示是否允许出现滚动条
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭']
				}));
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		/*function toPreview(){
			var ids = getBstCheckedId('HEL_ID');
			if(!(ids.length==1)) {
				layer.msg("请只选中一条信息进行预览");
				return false;
			}
 			else
			{
 				layer.full(
						layer.open({
						    type: 2,
						    title: '预览信息',//窗体标题
						    area: ['900px', '430px'],//整个窗体宽、高，单位：像素px
						    fix: false, //窗体位置不固定
						    maxmin: false,//最大、小化是否显示
						    scrollbar: false,//整个页面滚动条是否显示
			 			    content: ["hospitalExpertTmp/toMergeLists?HEL_ID="+ids , "yes"],//URL地址,yes或者or是表示是否允许出现滚动条 
						    closeBtn: 1 //不显示关闭按钮
						})
					);
			} 
		}*/
		//操作
		function formatNameFun(value, row, index){
			return "<button type=\"button\" class=\"btn btn-link\" onclick=\"toView('" + row.HEL_ID + "');\">" + row.HEL_NAME + "</button>";
		}
	</script>
</body>
</html>